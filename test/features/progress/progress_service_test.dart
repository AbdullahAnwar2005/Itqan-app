import 'package:flutter_test/flutter_test.dart';
import 'package:itqan/features/plan/domain/active_plan.dart';
import 'package:itqan/features/plan/domain/day_assignment.dart';
import 'package:itqan/features/plan/domain/quran_position.dart';
import 'package:itqan/features/setup/domain/user_setup.dart';
import 'package:itqan/features/plan/domain/plan_status.dart';
import 'package:itqan/features/progress/application/progress_service.dart';
import 'package:intl/intl.dart';

void main() {
  late ProgressService service;
  final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
  final yesterday = DateFormat('yyyy-MM-dd').format(DateTime.now().subtract(const Duration(days: 1)));

  setUp(() {
    service = const ProgressService();
  });

  group('ProgressService - Streak Logic', () {
    test('calculateCurrentStreak returns 0 for empty assignments', () {
      expect(service.computeSummary(
        plan: _mockPlan(),
        assignments: [],
      ).consistency.currentStreak, 0);
    });

    test('calculateCurrentStreak counts consecutive completed days', () {
      final assignments = [
        _mockAssignment(date: today, isMemo: true, isReview: true),
        _mockAssignment(date: yesterday, isMemo: true, isReview: true),
      ];
      final summary = service.computeSummary(plan: _mockPlan(), assignments: assignments);
      expect(summary.consistency.currentStreak, 2);
    });

    test('calculateCurrentStreak does not break if today is incomplete but yesterday was done', () {
      final assignments = [
        _mockAssignment(date: today, isMemo: false, isReview: false),
        _mockAssignment(date: yesterday, isMemo: true, isReview: true),
      ];
      final summary = service.computeSummary(plan: _mockPlan(), assignments: assignments);
      expect(summary.consistency.currentStreak, 1);
    });

    test('calculateCurrentStreak breaks if yesterday was incomplete', () {
      final assignments = [
        _mockAssignment(date: today, isMemo: true, isReview: true),
        _mockAssignment(date: yesterday, isMemo: false, isReview: true),
      ];
      final summary = service.computeSummary(plan: _mockPlan(), assignments: assignments);
      expect(summary.consistency.currentStreak, 1); // Only today
    });

    test('calculateCurrentStreak returns 0 if yesterday was incomplete and today is incomplete', () {
      final assignments = [
        _mockAssignment(date: today, isMemo: false, isReview: false),
        _mockAssignment(date: yesterday, isMemo: false, isReview: true),
      ];
      final summary = service.computeSummary(plan: _mockPlan(), assignments: assignments);
      expect(summary.consistency.currentStreak, 0);
    });
  });

  group('ProgressService - Recent Activity', () {
    test('computes activity within 7-day window', () {
      final eightDaysAgo = DateFormat('yyyy-MM-dd').format(DateTime.now().subtract(const Duration(days: 8)));
      final assignments = [
        _mockAssignment(date: today, isMemo: true, isReview: true),
        _mockAssignment(date: eightDaysAgo, isMemo: true, isReview: true),
      ];
      
      final summary = service.computeSummary(plan: _mockPlan(), assignments: assignments);
      expect(summary.recentActivity.completedDays, 1); // Only today is in window
    });
  });
}

ActivePlanEntity _mockPlan() {
  return ActivePlanEntity(
    id: 'plan-1',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    status: PlanStatus.active,
    memorizationTarget: const DailyTarget(amount: 5, unit: ProgressUnit.ayah),
    reviewTarget: const DailyTarget(amount: 1, unit: ProgressUnit.juz),
    startPosition: const QuranPosition(surahNumber: 1, ayahNumber: 1),
    currentPosition: const QuranPosition(surahNumber: 1, ayahNumber: 1),
  );
}

DayAssignmentEntity _mockAssignment({
  required String date,
  bool isMemo = false,
  bool isReview = false,
}) {
  return DayAssignmentEntity(
    id: 'a-$date',
    planId: 'plan-1',
    dateKey: date,
    memoStart: const QuranPosition(surahNumber: 1, ayahNumber: 1),
    memoEnd: const QuranPosition(surahNumber: 1, ayahNumber: 5),
    memoTarget: const DailyTarget(amount: 5, unit: ProgressUnit.ayah),
    reviewTarget: const DailyTarget(amount: 1, unit: ProgressUnit.juz),
    isMemoDone: isMemo,
    isReviewDone: isReview,
    createdAt: DateTime.now(),
  );
}
