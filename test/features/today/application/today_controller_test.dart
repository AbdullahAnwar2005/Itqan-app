import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:itqan/features/plan/application/plan_providers.dart';
import 'package:itqan/features/plan/domain/active_plan.dart';
import 'package:itqan/features/plan/domain/day_assignment.dart';
import 'package:itqan/features/plan/domain/plan_status.dart';
import 'package:itqan/features/plan/domain/quran_position.dart';
import 'package:itqan/features/progress/application/progress_providers.dart';
import 'package:itqan/features/today/application/near_review_service.dart';
import 'package:itqan/features/today/application/old_review_service.dart';
import 'package:itqan/features/today/application/recovery_service.dart';
import 'package:itqan/features/today/application/today_providers.dart';
import 'package:itqan/features/today/data/recovery_resolution_repository.dart';
import 'package:itqan/features/today/data/today_adjustment_repository.dart';
import 'package:itqan/features/today/domain/today_adjustment.dart';
import 'package:itqan/features/today/domain/today_task.dart';
import 'package:itqan/features/today/domain/recovery_notice.dart';
import 'package:itqan/features/today/domain/recovery_recommendation.dart';
import 'package:itqan/features/setup/domain/user_setup.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'today_controller_test.mocks.dart';

@GenerateMocks([
  NearReviewService,
  OldReviewService,
  RecoveryService,
  TodayAdjustmentRepository,
  RecoveryResolutionRepository,
])
void main() {
  late MockNearReviewService mockNearReviewService;
  late MockOldReviewService mockOldReviewService;
  late MockRecoveryService mockRecoveryService;
  late MockTodayAdjustmentRepository mockTodayAdjustmentRepository;
  late MockRecoveryResolutionRepository mockRecoveryResolutionRepository;

  setUp(() {
    mockNearReviewService = MockNearReviewService();
    mockOldReviewService = MockOldReviewService();
    mockRecoveryService = MockRecoveryService();
    mockTodayAdjustmentRepository = MockTodayAdjustmentRepository();
    mockRecoveryResolutionRepository = MockRecoveryResolutionRepository();
  });

  ProviderContainer createContainer(DayAssignmentEntity? assignment, ActivePlanEntity? plan) {
    return ProviderContainer(
      overrides: [
        todayAssignmentProvider.overrideWith((ref) => assignment),
        activePlanProvider.overrideWith((ref) => plan),
        nearReviewServiceProvider.overrideWithValue(mockNearReviewService),
        oldReviewServiceProvider.overrideWithValue(mockOldReviewService),
        recoveryServiceProvider.overrideWithValue(mockRecoveryService),
        todayAdjustmentRepositoryProvider.overrideWithValue(mockTodayAdjustmentRepository),
        recoveryResolutionRepositoryProvider.overrideWithValue(mockRecoveryResolutionRepository),
      ],
    );
  }

  final testDate = DateTime(2026, 6, 19);
  
  final mockPlan = ActivePlanEntity(
    id: 'plan-1',
    createdAt: testDate,
    updatedAt: testDate,
    status: PlanStatus.active,
    memorizationTarget: const DailyTarget(amount: 5, unit: ProgressUnit.ayah),
    reviewTarget: const DailyTarget(amount: 1, unit: ProgressUnit.juz),
    startPosition: const QuranPosition(surahNumber: 1, ayahNumber: 1),
    currentPosition: const QuranPosition(surahNumber: 1, ayahNumber: 1),
    memorizationDays: const {1, 2, 3, 4, 5, 6, 7},
    reviewSchedule: ReviewSchedule.everyday,
    customReviewDays: const {},
    previousMemorizedRanges: const [],
  );

  final mockAssignment = DayAssignmentEntity(
    id: 'a1',
    planId: 'plan-1',
    dateKey: '2026-06-19',
    memoStart: const QuranPosition(surahNumber: 1, ayahNumber: 1),
    memoEnd: const QuranPosition(surahNumber: 1, ayahNumber: 5),
    memoTarget: const DailyTarget(amount: 5, unit: ProgressUnit.ayah),
    reviewTarget: const DailyTarget(amount: 1, unit: ProgressUnit.juz),
    isMemoDone: false,
    isReviewDone: false,
    hasMemoTask: true,
    hasReviewTask: true,
    createdAt: testDate,
  );

  group('TodayController Deferral Logic', () {
    test('memorization task is present when deferMemorization is false', () async {
      when(mockNearReviewService.getNearReviewTasks(planId: anyNamed('planId'), limit: anyNamed('limit')))
          .thenAnswer((_) async => []);
      when(mockOldReviewService.getOldReviewTasks(planId: anyNamed('planId'), date: anyNamed('date')))
          .thenAnswer((_) async => []);
      when(mockRecoveryService.getRecoveryNotice(planId: anyNamed('planId')))
          .thenAnswer((_) async => null);
          
      when(mockTodayAdjustmentRepository.getAdjustment(planId: 'plan-1', dateKey: '2026-06-19'))
          .thenAnswer((_) async => TodayAdjustment(
                planId: 'plan-1',
                dateKey: '2026-06-19',
                deferMemorization: false,
                createdAt: testDate,
                updatedAt: testDate,
              ));

      final container = createContainer(mockAssignment, mockPlan);
      final summary = await container.read(todayControllerProvider.future);

      expect(summary.isMemorizationDeferred, isFalse);
      expect(summary.tasks.any((t) => t.type == TodayTaskType.memorization), isTrue);
    });

    test('memorization task is NOT present when deferMemorization is true', () async {
      when(mockNearReviewService.getNearReviewTasks(planId: anyNamed('planId'), limit: anyNamed('limit')))
          .thenAnswer((_) async => []);
      when(mockOldReviewService.getOldReviewTasks(planId: anyNamed('planId'), date: anyNamed('date')))
          .thenAnswer((_) async => []);
      when(mockRecoveryService.getRecoveryNotice(planId: anyNamed('planId')))
          .thenAnswer((_) async => null);
          
      when(mockTodayAdjustmentRepository.getAdjustment(planId: 'plan-1', dateKey: '2026-06-19'))
          .thenAnswer((_) async => TodayAdjustment(
                planId: 'plan-1',
                dateKey: '2026-06-19',
                deferMemorization: true,
                createdAt: testDate,
                updatedAt: testDate,
              ));

      final container = createContainer(mockAssignment, mockPlan);
      final summary = await container.read(todayControllerProvider.future);

      expect(summary.isMemorizationDeferred, isTrue);
      expect(summary.tasks.any((t) => t.type == TodayTaskType.memorization), isFalse);
    });

    test('resolveMissedWork sets cutoff at yesterday and invalidates state', () async {
      when(mockNearReviewService.getNearReviewTasks(planId: anyNamed('planId'), limit: anyNamed('limit')))
          .thenAnswer((_) async => []);
      when(mockOldReviewService.getOldReviewTasks(planId: anyNamed('planId'), date: anyNamed('date')))
          .thenAnswer((_) async => []);
      when(mockRecoveryService.getRecoveryNotice(planId: anyNamed('planId')))
          .thenAnswer((_) async => null);
          
      when(mockTodayAdjustmentRepository.getAdjustment(planId: 'plan-1', dateKey: '2026-06-19'))
          .thenAnswer((_) async => TodayAdjustment(
                planId: 'plan-1',
                dateKey: '2026-06-19',
                deferMemorization: false,
                createdAt: testDate,
                updatedAt: testDate,
              ));

      when(mockRecoveryResolutionRepository.resolveMissedWorkBefore(
        planId: anyNamed('planId'),
        resolvedBeforeDateKey: anyNamed('resolvedBeforeDateKey'),
      )).thenAnswer((_) async => {});

      final container = createContainer(mockAssignment, mockPlan);
      final controller = container.read(todayControllerProvider.notifier);

      await controller.resolveMissedWork();

      // Ensure it was called with yesterday's date
      final now = DateTime.now();
      final yesterday = now.subtract(const Duration(days: 1));
      final yesterdayDateStr = "${yesterday.year.toString().padLeft(4, '0')}-${yesterday.month.toString().padLeft(2, '0')}-${yesterday.day.toString().padLeft(2, '0')}";

      verify(mockRecoveryResolutionRepository.resolveMissedWorkBefore(
        planId: 'plan-1',
        resolvedBeforeDateKey: yesterdayDateStr,
      )).called(1);
    });

    test('TodaySummary includes recommendation when RecoveryNotice exists with missed work', () async {
      when(mockNearReviewService.getNearReviewTasks(planId: anyNamed('planId'), limit: anyNamed('limit')))
          .thenAnswer((_) async => []);
      when(mockOldReviewService.getOldReviewTasks(planId: anyNamed('planId'), date: anyNamed('date')))
          .thenAnswer((_) async => []);
      
      const notice = RecoveryNotice(
        hasMissedWork: true,
        missedDaysCount: 2,
        missedMemorizationCount: 2,
        missedReviewCount: 2,
      );
      
      when(mockRecoveryService.getRecoveryNotice(planId: anyNamed('planId')))
          .thenAnswer((_) async => notice);
          
      when(mockTodayAdjustmentRepository.getAdjustment(planId: 'plan-1', dateKey: '2026-06-19'))
          .thenAnswer((_) async => TodayAdjustment(
                planId: 'plan-1',
                dateKey: '2026-06-19',
                deferMemorization: false,
                createdAt: testDate,
                updatedAt: testDate,
              ));

      final container = createContainer(mockAssignment, mockPlan);
      final summary = await container.read(todayControllerProvider.future);

      expect(summary.recoveryNotice, equals(notice));
      expect(summary.recoveryRecommendation, isNotNull);
      expect(summary.recoveryRecommendation!.severity, equals(RecoverySeverity.moderate));
    });

    test('TodaySummary has no recommendation when RecoveryNotice is null', () async {
      when(mockNearReviewService.getNearReviewTasks(planId: anyNamed('planId'), limit: anyNamed('limit')))
          .thenAnswer((_) async => []);
      when(mockOldReviewService.getOldReviewTasks(planId: anyNamed('planId'), date: anyNamed('date')))
          .thenAnswer((_) async => []);
      
      when(mockRecoveryService.getRecoveryNotice(planId: anyNamed('planId')))
          .thenAnswer((_) async => null);
          
      when(mockTodayAdjustmentRepository.getAdjustment(planId: 'plan-1', dateKey: '2026-06-19'))
          .thenAnswer((_) async => TodayAdjustment(
                planId: 'plan-1',
                dateKey: '2026-06-19',
                deferMemorization: false,
                createdAt: testDate,
                updatedAt: testDate,
              ));

      final container = createContainer(mockAssignment, mockPlan);
      final summary = await container.read(todayControllerProvider.future);

      expect(summary.recoveryNotice, isNull);
      expect(summary.recoveryRecommendation, isNull);
    });
  });
}
