import '../domain/today_mode.dart';
import '../domain/today_task.dart';

/// Enforces capacity rules to prevent the Today screen from overloading.
class TodayTaskCapacityPolicy {
  const TodayTaskCapacityPolicy();

  /// Applies filtering limits based on the provided [TodayMode].
  List<TodayTask> applyCapacityRules(List<TodayTask> tasks, TodayMode mode) {
    final memorizationTasks = <TodayTask>[];
    final nearReviewTasks = <TodayTask>[];
    final oldReviewTasks = <TodayTask>[];
    final reviewTasks = <TodayTask>[];

    // Group tasks by type
    for (final task in tasks) {
      switch (task.type) {
        case TodayTaskType.memorization:
          memorizationTasks.add(task);
          break;
        case TodayTaskType.nearReview:
          nearReviewTasks.add(task);
          break;
        case TodayTaskType.oldReview:
          oldReviewTasks.add(task);
          break;
        case TodayTaskType.review:
          reviewTasks.add(task);
          break;
      }
    }

    final filtered = <TodayTask>[];

    // 1. Memorization: Always keep if scheduled (visible but optional in lightRecovery)
    filtered.addAll(memorizationTasks);

    // 2. Specific reviews capacity: max 1 nearReview, max 1 oldReview
    final hasNearReview = nearReviewTasks.isNotEmpty;
    final hasOldReview = oldReviewTasks.isNotEmpty;

    if (hasNearReview) {
      filtered.add(nearReviewTasks.first);
    }
    
    if (hasOldReview) {
      filtered.add(oldReviewTasks.first);
    }

    // 3. Generic review suppression: Hide if ANY specific review exists
    final hasAnySpecificReview = hasNearReview || hasOldReview;
    if (!hasAnySpecificReview) {
      filtered.addAll(reviewTasks);
    }

    return filtered;
  }
}
