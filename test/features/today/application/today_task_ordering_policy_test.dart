import 'package:flutter_test/flutter_test.dart';
import 'package:itqan/features/today/application/today_task_ordering_policy.dart';
import 'package:itqan/features/today/domain/today_mode.dart';
import 'package:itqan/features/today/domain/today_task.dart';

void main() {
  const policy = TodayTaskOrderingPolicy();

  final memoTask = TodayTask(id: '1', type: TodayTaskType.memorization);
  final reviewTask = TodayTask(id: '2', type: TodayTaskType.review);
  final nearReviewTask = TodayTask(id: '3', type: TodayTaskType.nearReview);
  final oldReviewTask = TodayTask(id: '4', type: TodayTaskType.oldReview);

  final unsortedTasks = [
    reviewTask,
    oldReviewTask,
    memoTask,
    nearReviewTask,
  ];

  test('orderTasks applies normal ordering correctly', () {
    final sorted = policy.orderTasks(unsortedTasks, TodayMode.normal);

    expect(sorted.length, 4);
    expect(sorted[0].type, TodayTaskType.memorization);
    expect(sorted[1].type, TodayTaskType.nearReview);
    expect(sorted[2].type, TodayTaskType.oldReview);
    expect(sorted[3].type, TodayTaskType.review);
  });

  test('orderTasks applies lightRecovery ordering correctly', () {
    final sorted = policy.orderTasks(unsortedTasks, TodayMode.lightRecovery);

    expect(sorted.length, 4);
    expect(sorted[0].type, TodayTaskType.nearReview);
    expect(sorted[1].type, TodayTaskType.oldReview);
    expect(sorted[2].type, TodayTaskType.review);
    expect(sorted[3].type, TodayTaskType.memorization);
  });
}
