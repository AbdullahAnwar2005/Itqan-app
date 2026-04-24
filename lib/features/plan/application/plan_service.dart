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

  /// Creates a new active plan from setup and a starting position.
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
    );

    return await _repository.createActivePlan(plan);
  }

  /// Gets today's assignment or creates it if it doesn't exist.
  Future<DayAssignmentEntity?> getOrCreateTodayAssignment(ActivePlanEntity plan) async {
    final dateKey = DateFormat('yyyy-MM-dd').format(DateTime.now());
    
    final existing = await _repository.getAssignmentByDate(plan.id, dateKey);
    if (existing != null) return existing;

    // Check if the plan has already seen any completed work
    final recent = await _repository.getRecentAssignments(plan.id, limit: 1);
    final hasStarted = recent.any((a) => a.isMemoDone);

    // Generate new assignment
    final memoStart = hasStarted ? _nextPosition(plan.currentPosition) : plan.currentPosition;
    final memoEnd = _calculateEndPosition(memoStart, plan.memorizationTarget);

    final assignment = DayAssignmentEntity(
      id: _repository.nextId(),
      planId: plan.id,
      dateKey: dateKey,
      memoStart: memoStart,
      memoEnd: memoEnd,
      memoTarget: plan.memorizationTarget,
      reviewTarget: plan.reviewTarget,
      createdAt: DateTime.now(),
    );

    await _repository.saveAssignment(assignment);
    return assignment;
  }

  /// Completes or undoes a memorization task, updating the plan pointer.
  /// 
  /// Progression Rule:
  /// - On completion: Advances plan.currentPosition to assignment.memoEnd.
  /// - On undo: Reverts plan.currentPosition to assignment.memoStart, but ONLY
  ///   if the current pointer is at memoEnd (ensuring no subsequent progress is lost).
  Future<void> toggleMemorization({
    required ActivePlanEntity plan,
    required DayAssignmentEntity assignment,
    required bool isDone,
  }) async {
    final bool canUpdatePointer = isDone || plan.currentPosition == assignment.memoEnd;

    if (canUpdatePointer) {
      final updatedPlan = plan.copyWith(
        currentPosition: isDone ? assignment.memoEnd : assignment.memoStart,
      );
      await _repository.updateActivePlan(updatedPlan);
    }

    final updatedAssignment = assignment.copyWith(isMemoDone: isDone);
    await _repository.saveAssignment(updatedAssignment);
  }

  /// Calculates the end position based on start and target (inclusive).
  QuranPosition _calculateEndPosition(QuranPosition start, DailyTarget target) {
    int remainingAyahs = _convertTargetToAyahs(target);
    if (remainingAyahs <= 1) return start;

    int currentSurah = start.surahNumber;
    int currentAyah = start.ayahNumber;

    // Move forward (remainingAyahs - 1) times from the start position
    int toMove = remainingAyahs - 1;

    while (toMove > 0) {
      final ayahsInCurrentSurah = QuranMetadata.getAyahCount(currentSurah);
      final ayahsLeftInSurah = ayahsInCurrentSurah - currentAyah;

      if (toMove <= ayahsLeftInSurah) {
        currentAyah += toMove;
        toMove = 0;
      } else {
        toMove -= (ayahsLeftInSurah + 1);
        if (currentSurah < 114) {
          currentSurah++;
          currentAyah = 1;
        } else {
          // Reached end of Quran
          currentAyah = ayahsInCurrentSurah;
          toMove = 0;
        }
      }
    }

    return QuranPosition(surahNumber: currentSurah, ayahNumber: currentAyah);
  }

  /// Calculates the immediate next position in the Quran.
  QuranPosition _nextPosition(QuranPosition current) {
    final ayahsInCurrent = QuranMetadata.getAyahCount(current.surahNumber);
    
    if (current.ayahNumber < ayahsInCurrent) {
      return QuranPosition(
        surahNumber: current.surahNumber,
        ayahNumber: current.ayahNumber + 1,
      );
    }
    
    if (current.surahNumber < 114) {
      return QuranPosition(
        surahNumber: current.surahNumber + 1,
        ayahNumber: 1,
      );
    }
    
    // Reached the end
    return current;
  }

  /// Converts target amount into a raw ayah count for range calculation.
  /// 
  /// [V1 POLICY: ALTERNATIVE (Approximation)]
  /// This implementation uses fixed approximations (e.g., 15 ayahs per page)
  /// to enable position-aware progression for all units in V1.
  /// This is NOT semantically exact and will be replaced by mushaf-aware 
  /// mapping in future increments.
  int _convertTargetToAyahs(DailyTarget target) {
    final amount = target.amount.toInt();
    return switch (target.unit) {
      ProgressUnit.ayah => amount,
      ProgressUnit.page => amount * 15, // Approximation for V1
      ProgressUnit.hizb => amount * 100, // Approximation
      ProgressUnit.juz => amount * 200, // Approximation
    };
  }
}
