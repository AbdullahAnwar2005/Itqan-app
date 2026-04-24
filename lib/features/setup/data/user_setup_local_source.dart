import 'package:shared_preferences/shared_preferences.dart';

import '../domain/user_setup.dart';

/// SharedPreferences key namespace for [UserSetup].
abstract final class _Keys {
  static const String memorizationAmount = 'setup.memorization_amount';
  static const String memorizationUnit = 'setup.memorization_unit';
  
  static const String reviewAmount = 'setup.review_amount';
  static const String reviewUnit = 'setup.review_unit';
  
  static const String intensity = 'setup.intensity';

  // Legacy keys for migration.
  static const String legacyMemorizeAyahsPerDay = 'setup.memorize_ayahs_per_day';
  static const String legacyReviewPartsPerDay = 'setup.review_parts_per_day';
}

/// Local data source for [UserSetup] backed by [SharedPreferences].
///
/// This class owns all serialization/deserialization for the setup entity.
/// Nothing outside this file should know how the data is stored.
///
/// Separation note: the repository ([UserSetupRepository]) is the public
/// contract; this class is the implementation detail.
class UserSetupLocalSource {
  const UserSetupLocalSource(this._prefs);

  final SharedPreferences _prefs;

  /// Returns true if a complete setup exists in local storage.
  /// Also checks for legacy setup completion.
  bool get hasSetup {
    final hasNewSetup = _prefs.containsKey(_Keys.memorizationAmount) &&
        _prefs.containsKey(_Keys.memorizationUnit) &&
        _prefs.containsKey(_Keys.reviewAmount) &&
        _prefs.containsKey(_Keys.reviewUnit) &&
        _prefs.containsKey(_Keys.intensity);

    final hasLegacySetup = _prefs.containsKey(_Keys.legacyMemorizeAyahsPerDay) &&
        _prefs.containsKey(_Keys.legacyReviewPartsPerDay) &&
        _prefs.containsKey(_Keys.intensity);

    return hasNewSetup || hasLegacySetup;
  }

  /// Reads and returns the stored [UserSetup], or null if none exists.
  UserSetup? read() {
    if (!hasSetup) return null;

    final intensityKey = _prefs.getString(_Keys.intensity);
    if (intensityKey == null) return null;

    final intensity = MemorizationIntensity.fromKey(intensityKey);

    // Try reading new keys first
    if (_prefs.containsKey(_Keys.memorizationAmount)) {
      final memAmount = _prefs.getDouble(_Keys.memorizationAmount);
      final memUnitStr = _prefs.getString(_Keys.memorizationUnit);
      final revAmount = _prefs.getDouble(_Keys.reviewAmount);
      final revUnitStr = _prefs.getString(_Keys.reviewUnit);

      if (memAmount != null && memUnitStr != null && revAmount != null && revUnitStr != null) {
        return UserSetup(
          memorizationTarget: DailyTarget(
            amount: memAmount,
            unit: ProgressUnit.values.firstWhere((e) => e.name == memUnitStr, orElse: () => ProgressUnit.ayah),
          ),
          reviewTarget: DailyTarget(
            amount: revAmount,
            unit: ProgressUnit.values.firstWhere((e) => e.name == revUnitStr, orElse: () => ProgressUnit.page),
          ),
          intensity: intensity,
        );
      }
    }

    // Fallback: Read legacy keys and run migration
    final legacyAyahs = _prefs.getInt(_Keys.legacyMemorizeAyahsPerDay);
    final legacyParts = _prefs.getInt(_Keys.legacyReviewPartsPerDay);

    if (legacyAyahs != null && legacyParts != null) {
      return UserSetup(
        memorizationTarget: DailyTarget(
          amount: legacyAyahs.toDouble(),
          unit: ProgressUnit.ayah,
        ),
        reviewTarget: DailyTarget(
          amount: legacyParts.toDouble(),
          // Migration Assumption: The old review capacity question explicitly asked
          // "كم حزباً تراجع يومياً؟" and values 1-8 represented hizb-parts. Therefore,
          // falling back to `hizb` is the most accurate reflection of intent, correctly
          // preserving the semantic meaning despite a legacy UI label mismatch.
          unit: ProgressUnit.hizb,
        ),
        intensity: intensity,
      );
    }

    return null;
  }

  /// Persists [setup] to local storage. Overwrites any existing values.
  Future<void> write(UserSetup setup) async {
    await Future.wait([
      _prefs.setDouble(_Keys.memorizationAmount, setup.memorizationTarget.amount),
      _prefs.setString(_Keys.memorizationUnit, setup.memorizationTarget.unit.name),
      _prefs.setDouble(_Keys.reviewAmount, setup.reviewTarget.amount),
      _prefs.setString(_Keys.reviewUnit, setup.reviewTarget.unit.name),
      _prefs.setString(_Keys.intensity, setup.intensity.persistenceKey),
    ]);
  }

  /// Clears all setup data from local storage.
  Future<void> clear() async {
    await Future.wait([
      _prefs.remove(_Keys.memorizationAmount),
      _prefs.remove(_Keys.memorizationUnit),
      _prefs.remove(_Keys.reviewAmount),
      _prefs.remove(_Keys.reviewUnit),
      _prefs.remove(_Keys.intensity),
      _prefs.remove(_Keys.legacyMemorizeAyahsPerDay),
      _prefs.remove(_Keys.legacyReviewPartsPerDay),
    ]);
  }
}
