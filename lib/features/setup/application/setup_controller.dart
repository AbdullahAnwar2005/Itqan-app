import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:itqan/features/plan/domain/active_plan.dart';

import '../../../core/constants/quran_metadata.dart';
import '../../plan/application/plan_providers.dart';
import '../../plan/domain/quran_position.dart';
import '../../plan/domain/quran_range.dart';
import 'previous_memorization_draft_entry.dart';
import 'previous_memorization_service.dart';
import 'setup_providers.dart';
import 'package:flutter/foundation.dart';
import '../../../core/database/database_provider.dart';
import '../domain/user_setup.dart';
import '../../previous_memorization/domain/previous_memorized_range.dart';
import '../../previous_memorization/data/previous_memorization_repository.dart';
import '../../previous_memorization/application/previous_memorization_import_service.dart';

class SetupController extends Notifier<SetupWizardState> {
  @override
  SetupWizardState build() => SetupWizardState.initial();

  // ── Step setters ─────────────────────────────────────────────────────────

  void setMemorizationTarget(DailyTarget target) {
    state = state.copyWith(memorizationTarget: target);
  }

  void setMemorizationDays(Set<int> days) {
    state = state.copyWith(memorizationDays: days);
  }

  void setReviewTarget(DailyTarget target) {
    state = state.copyWith(reviewTarget: target);
  }

  void setReviewSchedule(ReviewSchedule schedule,
      {Set<int> customDays = const {}}) {
    state = state.copyWith(
      reviewSchedule: schedule,
      customReviewDays: customDays,
    );
  }

  // ── Previous Memorization ────────────────────────────────────────────────

  void setHasPreviousMemorization(bool value) {
    if (!value) {
      state = state.copyWith(
        hasPreviousMemorization: false,
        clearEntries: true,
        startPosition: const QuranPosition(surahNumber: 1, ayahNumber: 1),
        suggestedStartPosition: null,
      );
    } else {
      state = state.copyWith(hasPreviousMemorization: true);
    }
  }

  /// Adds a surah (whole or partial) as a single entry.
  ///
  /// If the user selects ayahs 1 through the last ayah, the entry is
  /// automatically normalized to [isWholeSurah] = true.
  void addSurahEntry(int surahNumber,
      {bool isWholeSurah = true, int? fromAyah, int? toAyah}) {
    final service = ref.read(previousMemorizationServiceProvider);
    final normalized =
        _normalizeSurahParams(surahNumber, isWholeSurah, fromAyah, toAyah);

    if (!normalized.isWholeSurah) {
      service.validateRange(normalized.fromAyah!, normalized.toAyah!);
    }

    final entry = PreviousSurahEntry(
      id: _generateId(),
      surahNumber: surahNumber,
      isWholeSurah: normalized.isWholeSurah,
      fromAyah: normalized.fromAyah,
      toAyah: normalized.toAyah,
    );

    service.validateEntryNoOverlap(state.previousMemorizationEntries, entry);
    _addEntry(entry, service);
  }

  /// Updates an existing surah entry by id.
  ///
  /// Validates overlap against all other entries (excluding the one being updated).
  void updateSurahEntry(
    String entryId, {
    required int surahNumber,
    required bool isWholeSurah,
    int? fromAyah,
    int? toAyah,
  }) {
    final service = ref.read(previousMemorizationServiceProvider);
    final normalized =
        _normalizeSurahParams(surahNumber, isWholeSurah, fromAyah, toAyah);

    if (!normalized.isWholeSurah) {
      service.validateRange(normalized.fromAyah!, normalized.toAyah!);
    }

    final updatedEntry = PreviousSurahEntry(
      id: entryId,
      surahNumber: surahNumber,
      isWholeSurah: normalized.isWholeSurah,
      fromAyah: normalized.fromAyah,
      toAyah: normalized.toAyah,
    );

    service.validateEntryNoOverlapExcluding(
      state.previousMemorizationEntries,
      entryId,
      updatedEntry,
    );

    _replaceEntry(entryId, updatedEntry, service);
  }

  /// Adds a juz as a single entry. Displayed as one item in the summary.
  void addJuzEntry(int juzNumber) {
    final service = ref.read(previousMemorizationServiceProvider);

    final entry = PreviousJuzEntry(
      id: _generateId(),
      juzNumber: juzNumber,
    );

    service.validateEntryNoOverlap(state.previousMemorizationEntries, entry);
    _addEntry(entry, service);
  }

  /// Adds multiple whole surahs as a single bulk entry.
  ///
  /// Rejects empty selection. Validates overlap through the service.
  void addBulkSurahEntry(List<int> surahNumbers) {
    if (surahNumbers.isEmpty) {
      throw const InvalidRangeException();
    }

    final service = ref.read(previousMemorizationServiceProvider);
    final sortedNumbers = List<int>.from(surahNumbers)..sort();

    final surahCoverages = sortedNumbers
        .map((n) => SurahCoverage(
              surahNumber: n,
              type: MemorizationCoverageType.full,
            ))
        .toList();

    final entry = PreviousBulkSurahEntry(
      id: _generateId(),
      surahCoverages: surahCoverages,
    );

    service.validateEntryNoOverlap(state.previousMemorizationEntries, entry);
    _addEntry(entry, service);
  }

  /// Updates an existing bulk surah entry.
  ///
  /// Rejects empty selection. Validates overlap against other entries.
  void updateBulkSurahEntry({
    required String entryId,
    required List<SurahCoverage> surahCoverages,
  }) {
    // Reject if no surahs are selected or all are marked as 'none'
    final effectiveCoverages = surahCoverages
        .where((c) => c.type != MemorizationCoverageType.none)
        .toList();
    if (effectiveCoverages.isEmpty) {
      throw const InvalidRangeException();
    }

    final service = ref.read(previousMemorizationServiceProvider);
    service.validateSurahCoverage(surahCoverages);

    final updatedEntry = PreviousBulkSurahEntry(
      id: entryId,
      surahCoverages: surahCoverages,
    );

    service.validateEntryNoOverlapExcluding(
      state.previousMemorizationEntries,
      entryId,
      updatedEntry,
    );

    _replaceEntry(entryId, updatedEntry, service);
  }

  /// Customizes a Juz entry with per-segment coverage.
  ///
  /// Validates coverage bounds and overlap against other entries.
  void customizeJuzEntry(String entryId, List<JuzSurahCoverage> coverage) {
    final service = ref.read(previousMemorizationServiceProvider);
    service.validateCoverage(coverage);

    final existingEntry = state.previousMemorizationEntries
        .whereType<PreviousJuzEntry>()
        .firstWhere((e) => e.id == entryId);

    final updatedEntry = PreviousJuzEntry(
      id: entryId,
      juzNumber: existingEntry.juzNumber,
      customizedCoverage: coverage,
    );

    service.validateEntryNoOverlapExcluding(
      state.previousMemorizationEntries,
      entryId,
      updatedEntry,
    );

    _replaceEntry(entryId, updatedEntry, service);
  }

  /// Resets a customized Juz entry back to full coverage.
  ///
  /// Validates overlap against other entries because restoring full coverage
  /// may now overlap with entries added after the customization.
  void resetJuzEntryToFull(String entryId) {
    final service = ref.read(previousMemorizationServiceProvider);

    final existingEntry = state.previousMemorizationEntries
        .whereType<PreviousJuzEntry>()
        .firstWhere((e) => e.id == entryId);

    final fullEntry = PreviousJuzEntry(
      id: entryId,
      juzNumber: existingEntry.juzNumber,
      // customizedCoverage: null → full Juz
    );

    service.validateEntryNoOverlapExcluding(
      state.previousMemorizationEntries,
      entryId,
      fullEntry,
    );

    _replaceEntry(entryId, fullEntry, service);
  }

  /// Removes a draft entry by its unique id.
  void removePreviousMemorizationEntry(String entryId) {
    final service = ref.read(previousMemorizationServiceProvider);
    final updated = state.previousMemorizationEntries
        .where((e) => e.id != entryId)
        .toList();
    _updateStateWithEntries(updated, service);
  }

  void _addEntry(PreviousMemorizationDraftEntry entry,
      PreviousMemorizationService service) {
    final updated = [...state.previousMemorizationEntries, entry];
    _updateStateWithEntries(updated, service);
  }

  void _replaceEntry(String entryId, PreviousMemorizationDraftEntry replacement,
      PreviousMemorizationService service) {
    final updated = state.previousMemorizationEntries.map((e) {
      return e.id == entryId ? replacement : e;
    }).toList();
    _updateStateWithEntries(updated, service);
  }

  void _updateStateWithEntries(List<PreviousMemorizationDraftEntry> entries,
      PreviousMemorizationService service) {
    final derivedRanges = service.rangesFromEntries(entries);
    state = state.copyWith(
      previousMemorizationEntries: entries,
      suggestedStartPosition: service.suggestStartPosition(derivedRanges),
      startPosition: service.suggestStartPosition(derivedRanges),
    );
  }

  void useSuggestedStartPosition() {
    if (state.suggestedStartPosition != null) {
      state = state.copyWith(startPosition: state.suggestedStartPosition);
    }
  }

  void setStartPosition(QuranPosition position) {
    state = state.copyWith(startPosition: position);
  }

  // ── Save (atomic plan creation) ───────────────────────────────────────────

  /// Persists setup, creates the ActivePlan and first DayAssignment.
  ///
  /// On failure throws — callers must catch and show an Arabic error message.
  Future<void> save(WidgetRef parentRef) async {
    final service = ref.read(previousMemorizationServiceProvider);
    final List<QuranRange> derivedRanges = state.hasPreviousMemorization
        ? service.rangesFromEntries(state.previousMemorizationEntries)
        : const <QuranRange>[];
    final userSetup = state.toUserSetup(derivedRanges: derivedRanges);

    final planService = ref.read(planServiceProvider);
    final db = ref.read(databaseProvider);

    ActivePlanEntity? plan;

    // Wrap database-side setup operations in a transaction.
    await db.transaction(() async {
      // 1. Create the ActivePlan via PlanService.
      plan = await planService.initPlan(
        setup: userSetup,
        startPosition: state.startPosition,
      );

      // 2. Save previous memorization into the new PreviousMemorizedRanges registry if present.
      if (state.hasPreviousMemorization && derivedRanges.isNotEmpty) {
        final prevMemoRepo = ref.read(previousMemorizationRepositoryProvider);
        final importService =
            ref.read(previousMemorizationImportServiceProvider);

        for (final range in derivedRanges) {
          final newRange = PreviousMemorizedRange(
            id: 'prev_${DateTime.now().millisecondsSinceEpoch}_${range.hashCode}',
            planId: plan!.id,
            startSurah: range.from.surahNumber,
            startAyah: range.from.ayahNumber,
            endSurah: range.to.surahNumber,
            endAyah: range.to.ayahNumber,
            source: PreviousMemorizationSource.setupImport,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          );
          await prevMemoRepo.addRange(newRange);
        }

        // Seed QuranSegmentProgress records.
        await importService.importRangesForPlan(plan!.id);
      }

      // 3. Generate today's assignment immediately.
      await planService.getOrCreateTodayAssignment(plan!);
    });

    // 4. Persist UserSetup to SharedPreferences only after database transaction succeeds.
    await ref.read(userSetupRepositoryProvider).saveSetup(userSetup);

    // 5. Invalidate providers so Today screen sees fresh data.
    parentRef.invalidate(isSetupCompleteProvider);
    parentRef.invalidate(activePlanProvider);
    parentRef.invalidate(todayAssignmentProvider);
  }

  // ── Helpers ───────────────────────────────────────────────────────────────

  /// Normalizes partial-surah params to whole-surah when the range covers
  /// every ayah (fromAyah == 1 && toAyah == total ayahs).
  ({bool isWholeSurah, int? fromAyah, int? toAyah}) _normalizeSurahParams(
    int surahNumber,
    bool isWholeSurah,
    int? fromAyah,
    int? toAyah,
  ) {
    if (!isWholeSurah && fromAyah != null && toAyah != null) {
      final totalAyahs = QuranMetadata.getAyahCount(surahNumber);
      if (fromAyah == 1 && toAyah == totalAyahs) {
        return (isWholeSurah: true, fromAyah: null, toAyah: null);
      }
    }
    return (
      isWholeSurah: isWholeSurah,
      fromAyah: isWholeSurah ? null : fromAyah,
      toAyah: isWholeSurah ? null : toAyah,
    );
  }

  int _idCounter = 0;
  String _generateId() =>
      'entry_${DateTime.now().millisecondsSinceEpoch}_${_idCounter++}';
}

final setupControllerProvider =
    NotifierProvider<SetupController, SetupWizardState>(SetupController.new);
