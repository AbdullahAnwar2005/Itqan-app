import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:itqan/features/plan/domain/day_assignment.dart';

import '../../../core/database/database_provider.dart';
import '../../setup/application/setup_providers.dart';
import '../data/plan_repository.dart';
import '../domain/active_plan.dart';
import '../domain/plan_status.dart';
import '../domain/quran_position.dart';
import 'plan_service.dart';

/// Provides the [PlanRepository].
final planRepositoryProvider = Provider<PlanRepository>(
  (ref) => PlanRepository(ref.watch(databaseProvider)),
);

/// Provides the [PlanService].
final planServiceProvider = Provider<PlanService>(
  (ref) => PlanService(ref.watch(planRepositoryProvider)),
);

/// Provides the current active plan.
final activePlanProvider = FutureProvider<ActivePlanEntity?>(
  (ref) => ref.watch(planRepositoryProvider).getActivePlan(),
);

/// Provides today's assignment if an active plan exists.
final todayAssignmentProvider = FutureProvider<DayAssignmentEntity?>(
  (ref) async {
    final plan = await ref.watch(activePlanProvider.future);
    if (plan == null || plan.status != PlanStatus.active) return null;
    return ref.watch(planServiceProvider).getOrCreateTodayAssignment(plan);
  },
);

/// Controller for plan-related actions.
class PlanController extends AutoDisposeAsyncNotifier<void> {
  @override
  Future<void> build() async {}

  /// Initializes the first plan.
  Future<void> createPlan(QuranPosition startPosition) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final setup = ref.read(userSetupRepositoryProvider).getSetup();
      if (setup == null) throw Exception('Setup not found');

      await ref.read(planServiceProvider).initPlan(
            setup: setup,
            startPosition: startPosition,
          );

      ref.invalidate(activePlanProvider);
    });
  }
}

final planControllerProvider =
    AutoDisposeAsyncNotifierProvider<PlanController, void>(PlanController.new);
