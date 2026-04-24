import 'package:flutter_test/flutter_test.dart';
import 'package:itqan/features/plan/application/plan_service.dart';
import 'package:itqan/features/plan/data/plan_repository.dart';
import 'package:itqan/features/plan/domain/active_plan.dart';
import 'package:itqan/features/plan/domain/day_assignment.dart';
import 'package:itqan/features/plan/domain/plan_status.dart';
import 'package:itqan/features/plan/domain/quran_position.dart';
import 'package:itqan/features/setup/domain/user_setup.dart';

void main() {
  late PlanService service;
  late MockPlanRepository repository;

  setUp(() {
    repository = MockPlanRepository();
    service = PlanService(repository);
  });

  group('PlanService - Assignment Generation', () {
    test('generates first assignment starting at currentPosition', () async {
      final plan = _mockPlan(current: const QuranPosition(surahNumber: 1, ayahNumber: 1));
      repository.recentAssignments = [];

      final assignment = await service.getOrCreateTodayAssignment(plan);
      
      expect(assignment?.memoStart.surahNumber, 1);
      expect(assignment?.memoStart.ayahNumber, 1);
    });

    test('advances memoStart to next position if previous work was done', () async {
      final plan = _mockPlan(current: const QuranPosition(surahNumber: 1, ayahNumber: 5));
      repository.recentAssignments = [
        _mockAssignment(isMemoDone: true) // Previous work done
      ];

      final assignment = await service.getOrCreateTodayAssignment(plan);
      
      // Should start at 6, not 5
      expect(assignment?.memoStart.surahNumber, 1);
      expect(assignment?.memoStart.ayahNumber, 6);
    });

    test('calculates end position correctly (inclusive)', () async {
      final plan = _mockPlan(
        current: const QuranPosition(surahNumber: 1, ayahNumber: 1),
        target: const DailyTarget(amount: 5, unit: ProgressUnit.ayah),
      );
      repository.recentAssignments = [];

      final assignment = await service.getOrCreateTodayAssignment(plan);
      
      // Fatiha 1 to 5 is 5 ayahs (inclusive)
      expect(assignment?.memoEnd.surahNumber, 1);
      expect(assignment?.memoEnd.ayahNumber, 5);
    });

    test('crosses surah boundary correctly', () async {
      // Fatiha has 7 ayahs. 
      // If we start at ayah 6 and target 5 ayahs:
      // 6, 7 (Fatiha) -> 1, 2, 3 (Baqarah)
      final plan = _mockPlan(
        current: const QuranPosition(surahNumber: 1, ayahNumber: 6),
        target: const DailyTarget(amount: 5, unit: ProgressUnit.ayah),
      );
      repository.recentAssignments = [];

      final assignment = await service.getOrCreateTodayAssignment(plan);
      
      expect(assignment?.memoEnd.surahNumber, 2);
      expect(assignment?.memoEnd.ayahNumber, 3);
    });
  });
}

class MockPlanRepository implements PlanRepository {
  List<DayAssignmentEntity> recentAssignments = [];

  @override
  String nextId() => 'test-id';

  @override
  Future<DayAssignmentEntity?> getAssignmentByDate(String planId, String dateKey) async => null;

  @override
  Future<List<DayAssignmentEntity>> getRecentAssignments(String planId, {int limit = 10}) async => recentAssignments;

  @override
  Future<void> saveAssignment(DayAssignmentEntity assignment) async {}

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

ActivePlanEntity _mockPlan({
  QuranPosition? current,
  DailyTarget? target,
}) {
  return ActivePlanEntity(
    id: 'plan-1',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    status: PlanStatus.active,
    memorizationTarget: target ?? const DailyTarget(amount: 5, unit: ProgressUnit.ayah),
    reviewTarget: const DailyTarget(amount: 1, unit: ProgressUnit.juz),
    startPosition: const QuranPosition(surahNumber: 1, ayahNumber: 1),
    currentPosition: current ?? const QuranPosition(surahNumber: 1, ayahNumber: 1),
  );
}

DayAssignmentEntity _mockAssignment({bool isMemoDone = false}) {
  return DayAssignmentEntity(
    id: 'a1',
    planId: 'plan-1',
    dateKey: '2023-01-01',
    memoStart: const QuranPosition(surahNumber: 1, ayahNumber: 1),
    memoEnd: const QuranPosition(surahNumber: 1, ayahNumber: 5),
    memoTarget: const DailyTarget(amount: 5, unit: ProgressUnit.ayah),
    reviewTarget: const DailyTarget(amount: 1, unit: ProgressUnit.juz),
    isMemoDone: isMemoDone,
    createdAt: DateTime.now(),
  );
}
