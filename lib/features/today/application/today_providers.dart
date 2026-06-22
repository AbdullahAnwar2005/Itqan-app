import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:itqan/features/today/application/today_mode_provider.dart';
import 'package:itqan/features/today/domain/today_mode.dart';
import '../../plan/application/plan_providers.dart';
import '../../plan/domain/day_assignment.dart';
import '../domain/today_summary.dart';
import '../domain/today_task.dart';
import '../../session/domain/session.dart';
import '../../session/application/session_providers.dart';
import '../../progress/domain/quran_segment_progress.dart';

import 'near_review_service.dart';
import 'old_review_service.dart';
import 'recovery_recommendation_service.dart';
import 'recovery_service.dart';
import 'today_task_capacity_policy.dart';
import 'today_task_ordering_policy.dart';
import '../data/today_adjustment_repository.dart';
import '../data/recovery_resolution_repository.dart';
import '../domain/recovery_notice.dart';
import '../../progress/application/progress_providers.dart';

final oldReviewServiceProvider = Provider<OldReviewService>((ref) {
  return OldReviewService(ref.watch(segmentProgressRepositoryProvider));
});

/// Manages today's tasks and their completion state using the active plan's assignment.
class TodayController extends AsyncNotifier<TodaySummary> {
  @override
  Future<TodaySummary> build() async {
    final assignment = await ref.watch(todayAssignmentProvider.future);
    final plan = await ref.watch(activePlanProvider.future);

    if (assignment == null || plan == null) {
      return const TodaySummary(tasks: []);
    }

    final nearReviewTasks =
        await ref.watch(nearReviewServiceProvider).getNearReviewTasks(
              planId: plan.id,
              limit: 1, // Only show 1 near review task for now
            );

    final oldReviewTasks =
        await ref.watch(oldReviewServiceProvider).getOldReviewTasks(
              planId: plan.id,
              date: DateTime.now(), // Use today's date for old review
            );

    final recoveryNotice =
        await ref.watch(recoveryServiceProvider).getRecoveryNotice(
              planId: plan.id,
            );

    final todayMode = ref.watch(todayModeProvider);

    final adjustment = await ref.watch(todayAdjustmentRepositoryProvider).getAdjustment(
      planId: plan.id,
      dateKey: assignment.dateKey,
    );

    return _mapAssignmentToSummary(
      assignment, 
      nearReviewTasks, 
      oldReviewTasks, 
      recoveryNotice, 
      todayMode,
      adjustment.deferMemorization,
    );
  }

  TodaySummary _mapAssignmentToSummary(
    DayAssignmentEntity assignment,
    List<TodayTask> nearReviewTasks,
    List<TodayTask> oldReviewTasks,
    RecoveryNotice? recoveryNotice,
    TodayMode mode,
    bool deferMemorization,
  ) {
    final recommendation = ref.read(recoveryRecommendationServiceProvider).buildRecommendation(
      notice: recoveryNotice,
      hasNearReview: nearReviewTasks.isNotEmpty,
      hasOldReview: oldReviewTasks.isNotEmpty,
      isMemorizationDeferred: deferMemorization,
      currentMode: mode,
    );

    // Rest day: neither task is scheduled.
    if (assignment.isRestDay) {
      return TodaySummary(
        tasks: const [],
        isRestDay: true,
        recoveryNotice: recoveryNotice,
        recoveryRecommendation: recommendation,
      );
    }

    final tasks = <TodayTask>[];

    if (assignment.hasMemoTask && !deferMemorization) {
      tasks.add(TodayTask(
        id: 'memorization',
        type: TodayTaskType.memorization,
        target: assignment.memoTarget,
        isCompleted: assignment.isMemoDone,
      ));
    }

    tasks.addAll(nearReviewTasks);
    tasks.addAll(oldReviewTasks);

    if (assignment.hasReviewTask) {
      tasks.add(TodayTask(
        id: 'review',
        type: TodayTaskType.review,
        target: assignment.reviewTarget,
        isCompleted: assignment.isReviewDone,
      ));
    }

    const capacityPolicy = TodayTaskCapacityPolicy();
    final filteredTasks = capacityPolicy.applyCapacityRules(tasks, mode);

    const orderingPolicy = TodayTaskOrderingPolicy();
    final orderedTasks = orderingPolicy.orderTasks(filteredTasks, mode);

    return TodaySummary(
      tasks: orderedTasks,
      recoveryNotice: recoveryNotice,
      isMemorizationDeferred: deferMemorization,
      recoveryRecommendation: recommendation,
    );
  }

  /// Defers the memorization task for today.
  Future<void> deferMemorizationForToday() async {
    final assignment = await ref.read(todayAssignmentProvider.future);
    final plan = await ref.read(activePlanProvider.future);
    if (assignment == null || plan == null) return;

    await ref.read(todayAdjustmentRepositoryProvider).setDeferMemorization(
      planId: plan.id,
      dateKey: assignment.dateKey,
      defer: true,
    );
    ref.invalidateSelf();
  }

  /// Cancels the deferral of the memorization task for today.
  Future<void> cancelMemorizationDeferForToday() async {
    final assignment = await ref.read(todayAssignmentProvider.future);
    final plan = await ref.read(activePlanProvider.future);
    if (assignment == null || plan == null) return;

    await ref.read(todayAdjustmentRepositoryProvider).setDeferMemorization(
      planId: plan.id,
      dateKey: assignment.dateKey,
      defer: false,
    );
    ref.invalidateSelf();
  }

  /// Resolves missed work by setting a cutoff at yesterday's date.
  Future<void> resolveMissedWork() async {
    final plan = await ref.read(activePlanProvider.future);
    if (plan == null) return;

    final now = DateTime.now();
    final yesterday = now.subtract(const Duration(days: 1));
    final yesterdayDateKey = DateFormat('yyyy-MM-dd').format(yesterday);

    await ref.read(recoveryResolutionRepositoryProvider).resolveMissedWorkBefore(
      planId: plan.id,
      resolvedBeforeDateKey: yesterdayDateKey,
    );

    ref.invalidateSelf();
  }

  /// Launches a session for the given task.
  Future<void> startTask(String taskId) async {
    final assignment = await ref.read(todayAssignmentProvider.future);
    if (assignment == null) return;
    final summary = state.value;
    if (summary == null) return;

    final task = summary.tasks.firstWhere((t) => t.id == taskId);

    final type = task.type == TodayTaskType.memorization
        ? SessionType.memorization
        : SessionType.review;

    final isSpecificReview = task.type == TodayTaskType.nearReview ||
        task.type == TodayTaskType.oldReview;

    ref.read(sessionControllerProvider.notifier).startSession(
          assignment,
          type,
          reviewStart: isSpecificReview ? task.startPosition : null,
          reviewEnd: isSpecificReview ? task.endPosition : null,
          segmentProgressId: task.segmentProgressId,
        );
  }
}

/// Provides the [TodaySummary] state.
final todayControllerProvider =
    AsyncNotifierProvider<TodayController, TodaySummary>(TodayController.new);
