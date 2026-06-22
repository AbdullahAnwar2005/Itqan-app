import 'dart:convert';
import '../../../core/database/app_database.dart';
import '../../setup/domain/user_setup.dart';
import '../domain/active_plan.dart';
import '../domain/day_assignment.dart';
import '../domain/plan_status.dart';
import '../domain/quran_position.dart';
import '../domain/quran_range.dart';

/// Mappers to convert between database rows and domain entities.
class PlanMappers {
  const PlanMappers._();

  static ActivePlanEntity activePlanFromDb(ActivePlan data) {
    // Parse memorization days from comma-separated string.
    final memoDays = _parseDaySet(data.memorizationDays);
    final customRevDays = _parseDaySet(data.customReviewDays);

    // Reconstruct previous memorized ranges from JSON.
    final List<QuranRange> previousRanges = [];
    try {
      final decoded = jsonDecode(data.previousMemorizedRanges) as List;
      for (final item in decoded) {
        previousRanges.add(QuranRange.fromMap(item as Map<String, dynamic>));
      }
    } catch (_) {
      // Fallback to empty list on parse error
    }

    return ActivePlanEntity(
      id: data.id,
      createdAt: data.createdAt,
      updatedAt: data.updatedAt,
      status: PlanStatus.fromString(data.status),
      memorizationTarget: DailyTarget(
        amount: data.memorizationAmount,
        unit: ProgressUnit.values.firstWhere(
          (e) => e.name == data.memorizationUnit,
        ),
      ),
      reviewTarget: DailyTarget(
        amount: data.reviewAmount,
        unit: ProgressUnit.values.firstWhere(
          (e) => e.name == data.reviewUnit,
        ),
      ),
      startPosition: QuranPosition(
        surahNumber: data.memorizationStartSurah,
        ayahNumber: data.memorizationStartAyah,
      ),
      currentPosition: QuranPosition(
        surahNumber: data.currentMemorizationSurah,
        ayahNumber: data.currentMemorizationAyah,
      ),
      memorizationDays: memoDays,
      reviewSchedule: ReviewSchedule.fromKey(data.reviewSchedule),
      customReviewDays: customRevDays,
      previousMemorizedRanges: previousRanges,
    );
  }

  static DayAssignmentEntity dayAssignmentFromDb(DayAssignment data) {
    return DayAssignmentEntity(
      id: data.id,
      planId: data.planId,
      dateKey: data.dateKey,
      memoStart: QuranPosition(
        surahNumber: data.memorizationStartSurah,
        ayahNumber: data.memorizationStartAyah,
      ),
      memoEnd: QuranPosition(
        surahNumber: data.memorizationEndSurah,
        ayahNumber: data.memorizationEndAyah,
      ),
      memoTarget: DailyTarget(
        amount: data.memorizationAmount,
        unit: ProgressUnit.values.firstWhere(
          (e) => e.name == data.memorizationUnit,
        ),
      ),
      reviewTarget: DailyTarget(
        amount: data.reviewAmount,
        unit: ProgressUnit.values.firstWhere(
          (e) => e.name == data.reviewUnit,
        ),
      ),
      hasMemoTask: data.hasMemoTask,
      hasReviewTask: data.hasReviewTask,
      isMemoDone: data.isMemorizationDone,
      isReviewDone: data.isReviewDone,
      createdAt: data.createdAt,
    );
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

  static String encodeDaySet(Set<int> days) {
    final sorted = days.toList()..sort();
    return sorted.join(',');
  }
}
