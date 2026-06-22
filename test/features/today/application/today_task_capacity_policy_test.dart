import 'package:flutter_test/flutter_test.dart';
import 'package:itqan/features/today/application/today_task_capacity_policy.dart';
import 'package:itqan/features/today/domain/today_mode.dart';
import 'package:itqan/features/today/domain/today_task.dart';

void main() {
  const policy = TodayTaskCapacityPolicy();

  final memoTask = TodayTask(id: '1', type: TodayTaskType.memorization);
  final reviewTask = TodayTask(id: '2', type: TodayTaskType.review);
  final nearReviewTask1 = TodayTask(id: '3', type: TodayTaskType.nearReview);
  final nearReviewTask2 = TodayTask(id: '4', type: TodayTaskType.nearReview);
  final oldReviewTask1 = TodayTask(id: '5', type: TodayTaskType.oldReview);
  final oldReviewTask2 = TodayTask(id: '6', type: TodayTaskType.oldReview);

  group('TodayTaskCapacityPolicy', () {
    test('normal mode keeps memorization, max 1 nearReview, max 1 oldReview, hides generic review', () {
      final tasks = [
        memoTask,
        reviewTask,
        nearReviewTask1,
        nearReviewTask2,
        oldReviewTask1,
        oldReviewTask2,
      ];

      final filtered = policy.applyCapacityRules(tasks, TodayMode.normal);

      expect(filtered.length, 3);
      expect(filtered.contains(memoTask), isTrue);
      expect(filtered.contains(nearReviewTask1), isTrue);
      expect(filtered.contains(nearReviewTask2), isFalse);
      expect(filtered.contains(oldReviewTask1), isTrue);
      expect(filtered.contains(oldReviewTask2), isFalse);
      expect(filtered.contains(reviewTask), isFalse); // Suppressed
    });

    test('normal mode keeps generic review if no specific reviews exist', () {
      final tasks = [memoTask, reviewTask];
      final filtered = policy.applyCapacityRules(tasks, TodayMode.normal);

      expect(filtered.length, 2);
      expect(filtered.contains(memoTask), isTrue);
      expect(filtered.contains(reviewTask), isTrue);
    });

    test('generic review hidden when ONLY nearReview exists', () {
      final tasks = [memoTask, reviewTask, nearReviewTask1];
      final filtered = policy.applyCapacityRules(tasks, TodayMode.normal);

      expect(filtered.length, 2);
      expect(filtered.contains(memoTask), isTrue);
      expect(filtered.contains(nearReviewTask1), isTrue);
      expect(filtered.contains(reviewTask), isFalse);
    });

    test('generic review hidden when ONLY oldReview exists', () {
      final tasks = [memoTask, reviewTask, oldReviewTask1];
      final filtered = policy.applyCapacityRules(tasks, TodayMode.normal);

      expect(filtered.length, 2);
      expect(filtered.contains(memoTask), isTrue);
      expect(filtered.contains(oldReviewTask1), isTrue);
      expect(filtered.contains(reviewTask), isFalse);
    });

    test('lightRecovery mode keeps memorization visible, limits specific reviews, hides generic', () {
      final tasks = [
        memoTask,
        reviewTask,
        nearReviewTask1,
        nearReviewTask2,
        oldReviewTask1,
        oldReviewTask2,
      ];

      final filtered = policy.applyCapacityRules(tasks, TodayMode.lightRecovery);

      // Should have memoTask, 1 nearReview, 1 oldReview
      expect(filtered.length, 3);
      expect(filtered.contains(memoTask), isTrue);
      expect(filtered.contains(nearReviewTask1), isTrue);
      expect(filtered.contains(oldReviewTask1), isTrue);
      expect(filtered.contains(reviewTask), isFalse);
    });
  });
}
