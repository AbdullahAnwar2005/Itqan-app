import 'package:intl/intl.dart';

import '../../../core/constants/quran_metadata.dart';
import '../../setup/domain/user_setup.dart';
import '../data/plan_repository.dart';
import '../domain/active_plan.dart';
import '../domain/day_assignment.dart';
import '../domain/plan_status.dart';
import '../domain/quran_position.dart';

class PlanService {
  PlanService(this._repository);

  final PlanRepository _repository;

  /// Creates a new active plan from setup and an explicit starting position.
  ///
  /// [startPosition] is ALWAYS explicitly provided. It is never inferred
  /// from [setup.previousMemorizedRange].
  Future<ActivePlanEntity> initPlan({
    required UserSetup setup,
    required QuranPosition startPosition,
  }) async {
    final plan = ActivePlanEntity(
      id: _repository.nextId(),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      status: PlanStatus.active,
      memorizationTarget: setup.memorizationTarget,
      reviewTarget: setup.reviewTarget,
      startPosition: startPosition,
      currentPosition: startPosition,
      memorizationDays: setup.memorizationDays,
      reviewSchedule: setup.reviewSchedule,
      customReviewDays: setup.customReviewDays,
      previousMemorizedRanges: setup.previousMemorizedRanges,
    );

    return await _repository.createActivePlan(plan);
  }

  /// Gets today's assignment, creating it if it doesn't exist.
  ///
  /// ## Task generation rules
  /// - [hasMemoTask] = true only if today is in [plan.memorizationDays].
  /// - [hasReviewTask] = true only if:
  ///   - Today is a scheduled review day, AND
  ///   - There is known content to review ([plan.previousMemorizedRange] != null
  ///     OR at least one memorization session has been completed).
  Future<DayAssignmentEntity?> getOrCreateTodayAssignment(
      ActivePlanEntity plan) async {
    final dateKey = DateFormat('yyyy-MM-dd').format(DateTime.now());

    final existing = await _repository.getAssignmentByDate(plan.id, dateKey);
    if (existing != null) return existing;

    final todayWeekday = DateTime.now().weekday; // 1=Mon … 7=Sun
    final isMemoDay = plan.memorizationDays.contains(todayWeekday);
    final isReviewDay = plan.effectiveReviewDays.contains(todayWeekday);

    // Determine if there is any known content to review.
    final hasKnownReviewContent = plan.previousMemorizedRanges.isNotEmpty ||
        await _repository.hasCompletedMemorizationSession(plan.id);

    final hasMemoTask = isMemoDay;
    final hasReviewTask = isReviewDay && hasKnownReviewContent;

    // Calculate memorization range for today (only if it's a memo day).
    final QuranPosition memoStart;
    final QuranPosition memoEnd;

    if (hasMemoTask) {
      final recent =
          await _repository.getRecentAssignments(plan.id, limit: 1);
      final hasStarted = recent.any((a) => a.isMemoDone);
      memoStart = hasStarted
          ? _nextPosition(plan.currentPosition)
          : plan.currentPosition;
      memoEnd = _calculateEndPosition(memoStart, plan.memorizationTarget);
    } else {
      // Rest day for memorization — position values are irrelevant but non-null.
      memoStart = plan.currentPosition;
      memoEnd = plan.currentPosition;
    }

    final assignment = DayAssignmentEntity(
      id: _repository.nextId(),
      planId: plan.id,
      dateKey: dateKey,
      memoStart: memoStart,
      memoEnd: memoEnd,
      memoTarget: plan.memorizationTarget,
      reviewTarget: plan.reviewTarget,
      hasMemoTask: hasMemoTask,
      hasReviewTask: hasReviewTask,
      createdAt: DateTime.now(),
    );

    await _repository.saveAssignment(assignment);
    return assignment;
  }

  /// Completes a memorization task and advances the plan pointer.
  /// Guard: only advances if [assignment.isMemoDone] is false.
  Future<void> completeMemorization({
    required ActivePlanEntity plan,
    required DayAssignmentEntity assignment,
  }) async {
    if (assignment.isMemoDone) return;

    final updatedPlan = plan.copyWith(currentPosition: assignment.memoEnd);
    await _repository.updateActivePlan(updatedPlan);

    final updatedAssignment = assignment.copyWith(isMemoDone: true);
    await _repository.saveAssignment(updatedAssignment);
  }

  // ── Private helpers ──────────────────────────────────────────────────────────

  QuranPosition _calculateEndPosition(QuranPosition start, DailyTarget target) {
    int remainingAyahs = _convertTargetToAyahs(target);
    if (remainingAyahs <= 1) return start;

    int currentSurah = start.surahNumber;
    int currentAyah = start.ayahNumber;
    int toMove = remainingAyahs - 1;

    while (toMove > 0) {
      final ayahsInCurrent = QuranMetadata.getAyahCount(currentSurah);
      final ayahsLeft = ayahsInCurrent - currentAyah;

      if (toMove <= ayahsLeft) {
        currentAyah += toMove;
        toMove = 0;
      } else {
        toMove -= (ayahsLeft + 1);
        if (currentSurah < 114) {
          currentSurah++;
          currentAyah = 1;
        } else {
          currentAyah = ayahsInCurrent;
          toMove = 0;
        }
      }
    }

    return QuranPosition(surahNumber: currentSurah, ayahNumber: currentAyah);
  }

  QuranPosition _nextPosition(QuranPosition current) {
    final ayahsInCurrent = QuranMetadata.getAyahCount(current.surahNumber);
    if (current.ayahNumber < ayahsInCurrent) {
      return QuranPosition(
        surahNumber: current.surahNumber,
        ayahNumber: current.ayahNumber + 1,
      );
    }
    if (current.surahNumber < 114) {
      return QuranPosition(surahNumber: current.surahNumber + 1, ayahNumber: 1);
    }
    return current;
  }

  /// [V1 POLICY: APPROXIMATION]
  /// Uses fixed ayah counts per unit. Will be replaced by mushaf-aware mapping.
  int _convertTargetToAyahs(DailyTarget target) {
    final amount = target.amount.toInt();
    return switch (target.unit) {
      ProgressUnit.ayah => amount,
      ProgressUnit.page => amount * 15,
      ProgressUnit.hizb => amount * 100,
      ProgressUnit.juz => amount * 200,
    };
  }
}
