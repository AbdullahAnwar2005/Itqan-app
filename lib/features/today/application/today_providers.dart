import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../plan/application/plan_providers.dart';
import '../../plan/domain/day_assignment.dart';
import '../domain/today_summary.dart';
import '../domain/today_task.dart';
import '../../session/domain/session.dart';
import '../../session/application/session_providers.dart';

/// Manages today's tasks and their completion state using the active plan's assignment.
class TodayController extends AsyncNotifier<TodaySummary> {
  @override
  Future<TodaySummary> build() async {
    final assignment = await ref.watch(todayAssignmentProvider.future);
    
    if (assignment == null) {
      return const TodaySummary(tasks: []);
    }

    return _mapAssignmentToSummary(assignment);
  }

  TodaySummary _mapAssignmentToSummary(DayAssignmentEntity assignment) {
    return TodaySummary(
      tasks: [
        TodayTask(
          id: 'memorization',
          type: TodayTaskType.memorization,
          target: assignment.memoTarget,
          isCompleted: assignment.isMemoDone,
        ),
        TodayTask(
          id: 'review',
          type: TodayTaskType.review,
          target: assignment.reviewTarget,
          isCompleted: assignment.isReviewDone,
        ),
      ],
    );
  }

  /// Launches a session for the given task.
  Future<void> startTask(String taskId) async {
    final assignment = await ref.read(todayAssignmentProvider.future);
    if (assignment == null) return;

    final type = taskId == 'memorization' 
        ? SessionType.memorization 
        : SessionType.review;

    ref.read(sessionControllerProvider.notifier).startSession(assignment, type);
  }
}

/// Provides the [TodaySummary] state.
final todayControllerProvider =
    AsyncNotifierProvider<TodayController, TodaySummary>(TodayController.new);
