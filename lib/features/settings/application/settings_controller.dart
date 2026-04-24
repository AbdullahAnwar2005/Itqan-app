import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../plan/application/plan_providers.dart';
import '../../plan/domain/plan_status.dart';
import '../../setup/domain/user_setup.dart';

class SettingsController extends AutoDisposeAsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<void> updateTargets({
    required DailyTarget memorizationTarget,
    required DailyTarget reviewTarget,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final plan = await ref.read(activePlanProvider.future);
      if (plan == null) return;

      final updatedPlan = plan.copyWith(
        memorizationTarget: memorizationTarget,
        reviewTarget: reviewTarget,
      );

      await ref.read(planRepositoryProvider).updateActivePlan(updatedPlan);
      ref.invalidate(activePlanProvider);
    });
  }

  Future<void> togglePlanStatus() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final plan = await ref.read(activePlanProvider.future);
      if (plan == null) return;

      final newStatus = plan.status == PlanStatus.active
          ? PlanStatus.paused
          : PlanStatus.active;

      final updatedPlan = plan.copyWith(status: newStatus);
      await ref.read(planRepositoryProvider).updateActivePlan(updatedPlan);
      ref.invalidate(activePlanProvider);
    });
  }

  Future<void> resetPlan() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final plan = await ref.read(activePlanProvider.future);
      if (plan == null) return;

      final updatedPlan = plan.copyWith(status: PlanStatus.archived);
      await ref.read(planRepositoryProvider).updateActivePlan(updatedPlan);
      ref.invalidate(activePlanProvider);
    });
  }
}

final settingsControllerProvider =
    AutoDisposeAsyncNotifierProvider<SettingsController, void>(
        SettingsController.new);
