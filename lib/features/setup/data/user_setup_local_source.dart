import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../../plan/domain/quran_position.dart';
import '../../plan/domain/quran_range.dart';
import '../domain/user_setup.dart';

/// SharedPreferences key namespace for [UserSetup].
abstract final class _Keys {
  // ── Current keys ────────────────────────────────────────────────────────────
  static const String memorizationAmount = 'setup.memorization_amount';
  static const String memorizationUnit = 'setup.memorization_unit';

  static const String reviewAmount = 'setup.review_amount';
  static const String reviewUnit = 'setup.review_unit';

  // Schedule keys (v2)
  static const String memorizationDays = 'setup.memorization_days';
  static const String reviewSchedule = 'setup.review_schedule';
  static const String customReviewDays = 'setup.custom_review_days';

  // Start position (v2)
  static const String startSurah = 'setup.start_surah';
  static const String startAyah = 'setup.start_ayah';

  // Previous memorized ranges (v3, JSON list)
  static const String previousRanges = 'setup.previous_ranges';

  // Previous memorized range (v2, legacy single range)
  static const String prevRangeFromSurah = 'setup.prev_range_from_surah';
  static const String prevRangeFromAyah = 'setup.prev_range_from_ayah';
  static const String prevRangeToSurah = 'setup.prev_range_to_surah';
  static const String prevRangeToAyah = 'setup.prev_range_to_ayah';

  // ── Legacy keys (kept for migration only) ────────────────────────────────────
  static const String legacyIntensity = 'setup.intensity';
  static const String legacyMemorizeAyahsPerDay = 'setup.memorize_ayahs_per_day';
  static const String legacyReviewPartsPerDay = 'setup.review_parts_per_day';
}

/// Local data source for [UserSetup] backed by [SharedPreferences].
class UserSetupLocalSource {
  const UserSetupLocalSource(this._prefs);

  final SharedPreferences _prefs;

  /// True if a complete v2 setup exists; also accepts legacy setups (migrated on read).
  bool get hasSetup {
    // v2 setup: must have memorization amount + schedule keys
    final hasV2 = _prefs.containsKey(_Keys.memorizationAmount) &&
        _prefs.containsKey(_Keys.memorizationUnit) &&
        _prefs.containsKey(_Keys.reviewAmount) &&
        _prefs.containsKey(_Keys.reviewUnit) &&
        _prefs.containsKey(_Keys.memorizationDays) &&
        _prefs.containsKey(_Keys.reviewSchedule) &&
        _prefs.containsKey(_Keys.startSurah) &&
        _prefs.containsKey(_Keys.startAyah);

    // Legacy v1 setup: old keys with intensity
    final hasLegacy = (_prefs.containsKey(_Keys.memorizationAmount) ||
            _prefs.containsKey(_Keys.legacyMemorizeAyahsPerDay)) &&
        _prefs.containsKey(_Keys.legacyIntensity);

    return hasV2 || hasLegacy;
  }

  /// Reads and returns the stored [UserSetup], migrating legacy data if needed.
  UserSetup? read() {
    if (!hasSetup) return null;

    // Try reading v2 keys first.
    if (_prefs.containsKey(_Keys.memorizationAmount) &&
        _prefs.containsKey(_Keys.memorizationDays)) {
      return _readV2();
    }

    // Fallback: migrate legacy setup.
    return _migrateLegacy();
  }

  UserSetup? _readV2() {
    final memAmount = _prefs.getDouble(_Keys.memorizationAmount);
    final memUnitStr = _prefs.getString(_Keys.memorizationUnit);
    final revAmount = _prefs.getDouble(_Keys.reviewAmount);
    final revUnitStr = _prefs.getString(_Keys.reviewUnit);
    final memDaysStr = _prefs.getString(_Keys.memorizationDays);
    final revScheduleStr = _prefs.getString(_Keys.reviewSchedule);
    final startSurahVal = _prefs.getInt(_Keys.startSurah);
    final startAyahVal = _prefs.getInt(_Keys.startAyah);

    if (memAmount == null ||
        memUnitStr == null ||
        revAmount == null ||
        revUnitStr == null ||
        memDaysStr == null ||
        revScheduleStr == null ||
        startSurahVal == null ||
        startAyahVal == null) {
      return null;
    }

    final customRevStr = _prefs.getString(_Keys.customReviewDays) ?? '';

    return UserSetup(
      memorizationTarget: DailyTarget(
        amount: memAmount,
        unit: ProgressUnit.values.firstWhere(
          (e) => e.name == memUnitStr,
          orElse: () => ProgressUnit.page,
        ),
      ),
      reviewTarget: DailyTarget(
        amount: revAmount,
        unit: ProgressUnit.values.firstWhere(
          (e) => e.name == revUnitStr,
          orElse: () => ProgressUnit.page,
        ),
      ),
      memorizationDays: _parseDaySet(memDaysStr),
      reviewSchedule: ReviewSchedule.fromKey(revScheduleStr),
      customReviewDays: _parseDaySet(customRevStr),
      startPosition:
          QuranPosition(surahNumber: startSurahVal, ayahNumber: startAyahVal),
      previousMemorizedRanges: _readRanges(),
    );
  }

  List<QuranRange> _readRanges() {
    final jsonStr = _prefs.getString(_Keys.previousRanges);
    if (jsonStr != null) {
      try {
        final decoded = jsonDecode(jsonStr) as List;
        return decoded
            .map((item) => QuranRange.fromMap(item as Map<String, dynamic>))
            .toList();
      } catch (_) {
        return const [];
      }
    }

    // Migration from v2 (single range)
    final fromSurah = _prefs.getInt(_Keys.prevRangeFromSurah);
    final fromAyah = _prefs.getInt(_Keys.prevRangeFromAyah);
    final toSurah = _prefs.getInt(_Keys.prevRangeToSurah);
    final toAyah = _prefs.getInt(_Keys.prevRangeToAyah);
    if (fromSurah != null &&
        fromAyah != null &&
        toSurah != null &&
        toAyah != null) {
      return [
        QuranRange(
          from: QuranPosition(surahNumber: fromSurah, ayahNumber: fromAyah),
          to: QuranPosition(surahNumber: toSurah, ayahNumber: toAyah),
        )
      ];
    }

    return const [];
  }

  /// Migrates a v1 (legacy) stored setup to v2 model with safe defaults.
  UserSetup? _migrateLegacy() {
    double memAmount;
    ProgressUnit memUnit;
    double revAmount;
    ProgressUnit revUnit;

    if (_prefs.containsKey(_Keys.memorizationAmount)) {
      memAmount = _prefs.getDouble(_Keys.memorizationAmount) ?? 5;
      memUnit = ProgressUnit.values.firstWhere(
        (e) => e.name == (_prefs.getString(_Keys.memorizationUnit) ?? ''),
        orElse: () => ProgressUnit.ayah,
      );
      revAmount = _prefs.getDouble(_Keys.reviewAmount) ?? 1;
      revUnit = ProgressUnit.values.firstWhere(
        (e) => e.name == (_prefs.getString(_Keys.reviewUnit) ?? ''),
        orElse: () => ProgressUnit.page,
      );
    } else {
      // Very old legacy format.
      memAmount = (_prefs.getInt(_Keys.legacyMemorizeAyahsPerDay) ?? 5).toDouble();
      memUnit = ProgressUnit.ayah;
      revAmount = (_prefs.getInt(_Keys.legacyReviewPartsPerDay) ?? 1).toDouble();
      revUnit = ProgressUnit.hizb;
    }

    return UserSetup(
      memorizationTarget: DailyTarget(amount: memAmount, unit: memUnit),
      reviewTarget: DailyTarget(amount: revAmount, unit: revUnit),
      // Legacy setups default to Mon–Fri memorization, everyday review.
      memorizationDays: {1, 2, 3, 4, 5},
      reviewSchedule: ReviewSchedule.everyday,
      customReviewDays: const {},
      startPosition: const QuranPosition(surahNumber: 1, ayahNumber: 1),
      previousMemorizedRanges: const [],
    );
  }

  /// Persists [setup] to local storage (v2 format). Overwrites any existing values.
  Future<void> write(UserSetup setup) async {
    final memoDaysStr =
        (setup.memorizationDays.toList()..sort()).join(',');
    final customRevStr =
        (setup.customReviewDays.toList()..sort()).join(',');

    final futures = <Future>[
      _prefs.setDouble(_Keys.memorizationAmount, setup.memorizationTarget.amount),
      _prefs.setString(_Keys.memorizationUnit, setup.memorizationTarget.unit.name),
      _prefs.setDouble(_Keys.reviewAmount, setup.reviewTarget.amount),
      _prefs.setString(_Keys.reviewUnit, setup.reviewTarget.unit.name),
      _prefs.setString(_Keys.memorizationDays, memoDaysStr),
      _prefs.setString(_Keys.reviewSchedule, setup.reviewSchedule.persistenceKey),
      _prefs.setString(_Keys.customReviewDays, customRevStr),
      _prefs.setInt(_Keys.startSurah, setup.startPosition.surahNumber),
      _prefs.setInt(_Keys.startAyah, setup.startPosition.ayahNumber),
      _prefs.setString(
        _Keys.previousRanges,
        jsonEncode(setup.previousMemorizedRanges.map((r) => r.toMap()).toList()),
      ),
      // Clean up legacy v2 range keys
      _prefs.remove(_Keys.prevRangeFromSurah),
      _prefs.remove(_Keys.prevRangeFromAyah),
      _prefs.remove(_Keys.prevRangeToSurah),
      _prefs.remove(_Keys.prevRangeToAyah),
    ];

    await Future.wait(futures);
  }

  /// Clears all setup data.
  Future<void> clear() async {
    await Future.wait([
      _prefs.remove(_Keys.memorizationAmount),
      _prefs.remove(_Keys.memorizationUnit),
      _prefs.remove(_Keys.reviewAmount),
      _prefs.remove(_Keys.reviewUnit),
      _prefs.remove(_Keys.memorizationDays),
      _prefs.remove(_Keys.reviewSchedule),
      _prefs.remove(_Keys.customReviewDays),
      _prefs.remove(_Keys.startSurah),
      _prefs.remove(_Keys.startAyah),
      _prefs.remove(_Keys.previousRanges),
      _prefs.remove(_Keys.prevRangeFromSurah),
      _prefs.remove(_Keys.prevRangeFromAyah),
      _prefs.remove(_Keys.prevRangeToSurah),
      _prefs.remove(_Keys.prevRangeToAyah),
      _prefs.remove(_Keys.legacyIntensity),
      _prefs.remove(_Keys.legacyMemorizeAyahsPerDay),
      _prefs.remove(_Keys.legacyReviewPartsPerDay),
    ]);
  }

  // ── Helpers ────────────────────────────────────────────────────────────────

  static Set<int> _parseDaySet(String raw) {
    if (raw.trim().isEmpty) return {};
    return raw
        .split(',')
        .map((s) => int.tryParse(s.trim()))
        .whereType<int>()
        .toSet();
  }
}
