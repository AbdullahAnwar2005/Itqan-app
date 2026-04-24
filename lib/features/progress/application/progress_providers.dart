import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../plan/application/plan_providers.dart';
import '../domain/progress_models.dart';
import 'progress_service.dart';

/// Provides the [ProgressService] singleton.
final progressServiceProvider = Provider<ProgressService>((ref) {
  return const ProgressService();
});

/// Provides the current [ProgressSummary] derived from active plan and recent assignments.
final progressSummaryProvider = FutureProvider<ProgressSummary?>((ref) async {
  final plan = await ref.watch(activePlanProvider.future);
  if (plan == null) return null;

  final repository = ref.watch(planRepositoryProvider);
  final assignments = await repository.getRecentAssignments(plan.id);

  final service = ref.watch(progressServiceProvider);
  return service.computeSummary(
    plan: plan,
    assignments: assignments,
  );
});
