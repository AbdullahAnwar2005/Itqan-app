import 'package:flutter_test/flutter_test.dart';
import 'package:itqan/features/plan/data/plan_repository.dart';
import 'package:itqan/features/plan/domain/day_assignment.dart';
import 'package:itqan/features/setup/domain/user_setup.dart';
import 'package:itqan/features/plan/domain/quran_position.dart';
import 'package:itqan/features/today/application/recovery_service.dart';
import 'package:itqan/features/today/data/recovery_resolution_repository.dart';
import 'package:itqan/features/today/domain/recovery_resolution.dart';

class MockPlanRepository implements PlanRepository {
  List<DayAssignmentEntity> mockPastAssignments = [];

  @override
  Future<List<DayAssignmentEntity>> getPastAssignmentsForPlan({
    required String planId,
    required String beforeDateKey,
  }) async {
    return mockPastAssignments;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class MockResolutionRepository implements RecoveryResolutionRepository {
  RecoveryResolution? mockResolution;

  @override
  Future<RecoveryResolution?> getResolution({required String planId}) async {
    return mockResolution;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  late MockPlanRepository mockRepository;
  late MockResolutionRepository mockResolutionRepository;
  late RecoveryService service;

  setUp(() {
    mockRepository = MockPlanRepository();
    mockResolutionRepository = MockResolutionRepository();
    service = RecoveryService(mockRepository, mockResolutionRepository);
  });

  DayAssignmentEntity createAssignment({
    required String id,
    required bool hasMemo,
    required bool isMemoDone,
    required bool hasReview,
    required bool isReviewDone,
    String dateKey = '2024-01-01',
  }) {
    return DayAssignmentEntity(
      id: id,
      planId: 'plan-1',
      dateKey: dateKey,
      memoStart: const QuranPosition(surahNumber: 1, ayahNumber: 1),
      memoEnd: const QuranPosition(surahNumber: 1, ayahNumber: 5),
      memoTarget: const DailyTarget(amount: 1, unit: ProgressUnit.page),
      reviewTarget: const DailyTarget(amount: 1, unit: ProgressUnit.page),
      hasMemoTask: hasMemo,
      hasReviewTask: hasReview,
      isMemoDone: isMemoDone,
      isReviewDone: isReviewDone,
      createdAt: DateTime.now(),
    );
  }

  test('returns null when there are no past assignments', () async {
    mockRepository.mockPastAssignments = [];
    final notice = await service.getRecoveryNotice(planId: 'plan-1');
    expect(notice, isNull);
  });

  test('returns null when all past assignments are completed', () async {
    mockRepository.mockPastAssignments = [
      createAssignment(id: '1', hasMemo: true, isMemoDone: true, hasReview: true, isReviewDone: true),
      createAssignment(id: '2', hasMemo: false, isMemoDone: false, hasReview: true, isReviewDone: true),
    ];
    final notice = await service.getRecoveryNotice(planId: 'plan-1');
    expect(notice, isNull);
  });

  test('returns RecoveryNotice when a past memorization task is incomplete', () async {
    mockRepository.mockPastAssignments = [
      createAssignment(id: '1', hasMemo: true, isMemoDone: false, hasReview: true, isReviewDone: true),
    ];
    final notice = await service.getRecoveryNotice(planId: 'plan-1');
    expect(notice, isNotNull);
    expect(notice!.hasMissedWork, isTrue);
    expect(notice.missedDaysCount, 1);
    expect(notice.missedMemorizationCount, 1);
    expect(notice.missedReviewCount, 0);
  });

  test('returns RecoveryNotice when a past review task is incomplete', () async {
    mockRepository.mockPastAssignments = [
      createAssignment(id: '1', hasMemo: true, isMemoDone: true, hasReview: true, isReviewDone: false),
    ];
    final notice = await service.getRecoveryNotice(planId: 'plan-1');
    expect(notice, isNotNull);
    expect(notice!.hasMissedWork, isTrue);
    expect(notice.missedDaysCount, 1);
    expect(notice.missedMemorizationCount, 0);
    expect(notice.missedReviewCount, 1);
  });

  test('counts multiple missed assignments correctly', () async {
    mockRepository.mockPastAssignments = [
      createAssignment(id: '1', hasMemo: true, isMemoDone: false, hasReview: true, isReviewDone: false),
      createAssignment(id: '2', hasMemo: true, isMemoDone: true, hasReview: true, isReviewDone: false),
    ];
    final notice = await service.getRecoveryNotice(planId: 'plan-1');
    expect(notice, isNotNull);
    expect(notice!.hasMissedWork, isTrue);
    expect(notice.missedDaysCount, 2);
    expect(notice.missedMemorizationCount, 1);
    expect(notice.missedReviewCount, 2);
  });

  test('ignores assignments on or before the resolvedBeforeDateKey', () async {
    mockRepository.mockPastAssignments = [
      createAssignment(id: '1', dateKey: '2024-01-01', hasMemo: true, isMemoDone: false, hasReview: true, isReviewDone: false),
      createAssignment(id: '2', dateKey: '2024-01-02', hasMemo: true, isMemoDone: false, hasReview: true, isReviewDone: false),
      createAssignment(id: '3', dateKey: '2024-01-03', hasMemo: true, isMemoDone: false, hasReview: true, isReviewDone: false),
    ];

    mockResolutionRepository.mockResolution = RecoveryResolution(
      planId: 'plan-1',
      resolvedBeforeDateKey: '2024-01-02',
      resolvedAt: DateTime.now(),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    final notice = await service.getRecoveryNotice(planId: 'plan-1');
    expect(notice, isNotNull);
    expect(notice!.hasMissedWork, isTrue);
    // Only assignment '3' on 2024-01-03 should be counted since it's > 2024-01-02
    expect(notice.missedDaysCount, 1);
    expect(notice.missedMemorizationCount, 1);
    expect(notice.missedReviewCount, 1);
  });

  test('returns null if all missed assignments are covered by resolution cutoff', () async {
    mockRepository.mockPastAssignments = [
      createAssignment(id: '1', dateKey: '2024-01-01', hasMemo: true, isMemoDone: false, hasReview: true, isReviewDone: false),
      createAssignment(id: '2', dateKey: '2024-01-02', hasMemo: true, isMemoDone: false, hasReview: true, isReviewDone: false),
    ];

    mockResolutionRepository.mockResolution = RecoveryResolution(
      planId: 'plan-1',
      resolvedBeforeDateKey: '2024-01-05',
      resolvedAt: DateTime.now(),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    final notice = await service.getRecoveryNotice(planId: 'plan-1');
    expect(notice, isNull);
  });
}
