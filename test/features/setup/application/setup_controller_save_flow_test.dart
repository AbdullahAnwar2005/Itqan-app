import 'package:drift/drift.dart' hide isNull, isNotNull;
import 'package:drift/native.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:itqan/core/database/app_database.dart';
import 'package:itqan/core/database/database_provider.dart';
import 'package:itqan/features/plan/application/plan_providers.dart';
import 'package:itqan/features/plan/application/plan_service.dart';
import 'package:itqan/features/plan/domain/active_plan.dart';
import 'package:itqan/features/plan/domain/day_assignment.dart';
import 'package:itqan/features/plan/domain/plan_status.dart';
import 'package:itqan/features/plan/domain/quran_position.dart';
import 'package:itqan/features/setup/application/setup_providers.dart';
import 'package:itqan/features/setup/domain/user_setup.dart';
import 'package:itqan/features/previous_memorization/data/previous_memorization_repository.dart';
import 'package:itqan/features/previous_memorization/domain/previous_memorized_range.dart';
import 'package:itqan/features/today/application/today_providers.dart';
import 'package:itqan/features/today/data/today_adjustment_repository.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FakeWidgetRef extends Mock implements WidgetRef {
  final ProviderContainer container;
  FakeWidgetRef(this.container);

  @override
  void invalidate(ProviderOrFamily provider) {
    container.invalidate(provider);
  }
}

class ThrowingPlanService extends Mock implements PlanService {
  @override
  Future<ActivePlanEntity> initPlan({
    required UserSetup setup,
    required QuranPosition startPosition,
  }) {
    return Future.error(Exception('Database write failure simulation'));
  }
}

void main() {
  late AppDatabase db;
  late SharedPreferences prefs;
  late ProviderContainer container;
  late FakeWidgetRef fakeRef;

  setUp(() async {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    SharedPreferences.setMockInitialValues({});
    prefs = await SharedPreferences.getInstance();

    container = ProviderContainer(
      overrides: [
        databaseProvider.overrideWithValue(db),
        sharedPreferencesProvider.overrideWithValue(prefs),
      ],
    );
    fakeRef = FakeWidgetRef(container);
  });

  tearDown(() async {
    container.dispose();
    await db.close();
  });

  group('Onboarding & Plan-Creation Bugfix Verification', () {
    test('PreviousMemorizationRepository uses real databaseProvider and inserts successfully', () async {
      final repo = container.read(previousMemorizationRepositoryProvider);
      
      final range = PreviousMemorizedRange(
        id: '1',
        planId: 'plan-test',
        startSurah: 1,
        startAyah: 1,
        endSurah: 1,
        endAyah: 7,
        source: PreviousMemorizationSource.manual,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await repo.addRange(range);
      final retrieved = await repo.getRangesForPlan('plan-test');
      expect(retrieved, hasLength(1));
      expect(retrieved.first.id, equals('1'));
    });

    test('TodayAdjustmentRepository uses real databaseProvider and reads/writes successfully', () async {
      final repo = container.read(todayAdjustmentRepositoryProvider);

      await repo.setDeferMemorization(planId: 'plan-test', dateKey: '2026-06-22', defer: true);
      final adj = await repo.getAdjustment(planId: 'plan-test', dateKey: '2026-06-22');
      expect(adj.deferMemorization, isTrue);
    });

    test('PlanRepository.getActivePlan() returns the newest active plan over older paused plans', () async {
      final planRepo = container.read(planRepositoryProvider);

      // Create an older plan
      final olderPlan = ActivePlanEntity(
        id: 'older-plan',
        createdAt: DateTime.now().subtract(const Duration(hours: 2)),
        updatedAt: DateTime.now().subtract(const Duration(hours: 2)),
        status: PlanStatus.paused,
        memorizationTarget: const DailyTarget(amount: 1, unit: ProgressUnit.page),
        reviewTarget: const DailyTarget(amount: 1, unit: ProgressUnit.page),
        startPosition: const QuranPosition(surahNumber: 1, ayahNumber: 1),
        currentPosition: const QuranPosition(surahNumber: 1, ayahNumber: 1),
        memorizationDays: const {1, 2, 3, 4, 5},
        reviewSchedule: ReviewSchedule.everyday,
        customReviewDays: const {},
        previousMemorizedRanges: const [],
      );

      // Create a newer active plan
      final newerPlan = ActivePlanEntity(
        id: 'newer-plan',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        status: PlanStatus.active,
        memorizationTarget: const DailyTarget(amount: 1, unit: ProgressUnit.page),
        reviewTarget: const DailyTarget(amount: 1, unit: ProgressUnit.page),
        startPosition: const QuranPosition(surahNumber: 1, ayahNumber: 1),
        currentPosition: const QuranPosition(surahNumber: 1, ayahNumber: 1),
        memorizationDays: const {1, 2, 3, 4, 5},
        reviewSchedule: ReviewSchedule.everyday,
        customReviewDays: const {},
        previousMemorizedRanges: const [],
      );

      await planRepo.createActivePlan(olderPlan);
      await planRepo.createActivePlan(newerPlan);

      final currentPlan = await planRepo.getActivePlan();
      expect(currentPlan, isNotNull);
      expect(currentPlan!.id, equals('newer-plan'));
      expect(currentPlan.status, equals(PlanStatus.active));
    });

    test('PlanRepository.getActivePlan() falls back to the latest paused plan if no active plan exists', () async {
      final planRepo = container.read(planRepositoryProvider);

      // Create a paused plan
      final pausedPlan = ActivePlanEntity(
        id: 'paused-plan',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        status: PlanStatus.paused,
        memorizationTarget: const DailyTarget(amount: 1, unit: ProgressUnit.page),
        reviewTarget: const DailyTarget(amount: 1, unit: ProgressUnit.page),
        startPosition: const QuranPosition(surahNumber: 1, ayahNumber: 1),
        currentPosition: const QuranPosition(surahNumber: 1, ayahNumber: 1),
        memorizationDays: const {1, 2, 3, 4, 5},
        reviewSchedule: ReviewSchedule.everyday,
        customReviewDays: const {},
        previousMemorizedRanges: const [],
      );

      // Insert directly
      await db.into(db.activePlans).insert(
        ActivePlansCompanion(
          id: Value(pausedPlan.id),
          createdAt: Value(pausedPlan.createdAt),
          updatedAt: Value(pausedPlan.updatedAt),
          status: Value(PlanStatus.paused.name),
          memorizationAmount: Value(pausedPlan.memorizationTarget.amount),
          memorizationUnit: Value(pausedPlan.memorizationTarget.unit.name),
          reviewAmount: Value(pausedPlan.reviewTarget.amount),
          reviewUnit: Value(pausedPlan.reviewTarget.unit.name),
          memorizationStartSurah: Value(pausedPlan.startPosition.surahNumber),
          memorizationStartAyah: Value(pausedPlan.startPosition.ayahNumber),
          currentMemorizationSurah: Value(pausedPlan.currentPosition.surahNumber),
          currentMemorizationAyah: Value(pausedPlan.currentPosition.ayahNumber),
          memorizationDays: const Value('1,2,3,4,5'),
          reviewSchedule: const Value('everyday'),
          customReviewDays: const Value(''),
          previousMemorizedRanges: const Value('[]'),
        ),
      );

      final currentPlan = await planRepo.getActivePlan();
      expect(currentPlan, isNotNull);
      expect(currentPlan!.id, equals('paused-plan'));
      expect(currentPlan.status, equals(PlanStatus.paused));
    });

    test('Onboarding with "لا، سأبدأ من الصفر" creates plan successfully, derivedRanges is empty, and saves completion after DB operations', () async {
      final setupController = container.read(setupControllerProvider.notifier);
      
      // Set to "لا، سأبدأ من الصفر" (hasPreviousMemorization: false)
      setupController.setHasPreviousMemorization(false);

      // Verify entries are cleared
      expect(container.read(setupControllerProvider).previousMemorizationEntries, isEmpty);
      expect(container.read(setupControllerProvider).hasPreviousMemorization, isFalse);

      // Trigger Save
      await setupController.save(fakeRef);

      // Verify setup completion
      expect(container.read(isSetupCompleteProvider), isTrue);

      // Verify plan is active, not paused
      final plan = await container.read(activePlanProvider.future);
      expect(plan, isNotNull);
      expect(plan!.status, equals(PlanStatus.active));
      expect(plan.previousMemorizedRanges, isEmpty);

      // Verify today's first assignment is generated
      final assignment = await container.read(todayAssignmentProvider.future);
      expect(assignment, isNotNull);
      expect(assignment!.planId, equals(plan.id));

      // Verify no previous memorization ranges were saved in repository
      final ranges = await container.read(previousMemorizationRepositoryProvider).getRangesForPlan(plan.id);
      expect(ranges, isEmpty);
    });

    test('Onboarding with previous memorization completes successfully', () async {
      final setupController = container.read(setupControllerProvider.notifier);
      
      setupController.setHasPreviousMemorization(true);
      setupController.addSurahEntry(1, isWholeSurah: true); // Al-Fatiha

      expect(container.read(setupControllerProvider).previousMemorizationEntries, hasLength(1));

      // Save onboarding
      await setupController.save(fakeRef);

      expect(container.read(isSetupCompleteProvider), isTrue);

      final plan = await container.read(activePlanProvider.future);
      expect(plan, isNotNull);
      expect(plan!.status, equals(PlanStatus.active));
      expect(plan.previousMemorizedRanges, hasLength(1));

      // Verify ranges are populated in DB
      final dbRanges = await container.read(previousMemorizationRepositoryProvider).getRangesForPlan(plan.id);
      expect(dbRanges, hasLength(1));
      expect(dbRanges.first.startSurah, equals(1));
      expect(dbRanges.first.endSurah, equals(1));

      // Verify Today controller loads without error
      final summary = await container.read(todayControllerProvider.future);
      expect(summary, isNotNull);
      expect(summary.recoveryNotice, isNull); // New onboarding has no past missed work
    });

    test('Setup completion is NOT persisted if database operations fail', () async {
      final throwingPlanService = ThrowingPlanService();
      final localContainer = ProviderContainer(
        overrides: [
          databaseProvider.overrideWithValue(db),
          sharedPreferencesProvider.overrideWithValue(prefs),
          planServiceProvider.overrideWithValue(throwingPlanService),
        ],
      );
      final localFakeRef = FakeWidgetRef(localContainer);

      final setupController = localContainer.read(setupControllerProvider.notifier);
      setupController.setHasPreviousMemorization(false);

      expect(
        () => setupController.save(localFakeRef),
        throwsA(anything),
      );

      // SharedPreferences setup complete must STILL be false
      expect(localContainer.read(isSetupCompleteProvider), isFalse);
      localContainer.dispose();
    });
  });
}
