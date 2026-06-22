import '../domain/today_task.dart';
import '../domain/today_mode.dart';

class TodayTaskOrderingPolicy {
  const TodayTaskOrderingPolicy();

  List<TodayTask> orderTasks(List<TodayTask> tasks, TodayMode mode) {
    if (mode == TodayMode.lightRecovery) {
      // Light Recovery: nearReview -> oldReview -> generic review -> memorization
      return _sortTasks(tasks, [
        TodayTaskType.nearReview,
        TodayTaskType.oldReview,
        TodayTaskType.review,
        TodayTaskType.memorization,
      ]);
    }

    // Normal: memorization -> nearReview -> oldReview -> generic review
    return _sortTasks(tasks, [
      TodayTaskType.memorization,
      TodayTaskType.nearReview,
      TodayTaskType.oldReview,
      TodayTaskType.review,
    ]);
  }

  List<TodayTask> _sortTasks(List<TodayTask> tasks, List<TodayTaskType> order) {
    final sorted = List<TodayTask>.from(tasks);
    sorted.sort((a, b) {
      final idxA = order.indexOf(a.type);
      final idxB = order.indexOf(b.type);
      return idxA.compareTo(idxB);
    });
    return sorted;
  }
}
