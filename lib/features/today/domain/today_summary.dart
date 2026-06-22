import 'package:equatable/equatable.dart';
import 'recovery_notice.dart';
import 'recovery_recommendation.dart';
import 'today_task.dart';

/// Summary of the user's status for the current day.
class TodaySummary extends Equatable {
  const TodaySummary({
    required this.tasks,
    this.isRestDay = false,
    this.recoveryNotice,
    this.isMemorizationDeferred = false,
    this.recoveryRecommendation,
  });

  final List<TodayTask> tasks;

  /// True when today has no scheduled tasks (neither memo nor review day).
  final bool isRestDay;

  /// Notice regarding incomplete past tasks, if any.
  final RecoveryNotice? recoveryNotice;

  /// Whether the user has deferred the memorization task for today.
  final bool isMemorizationDeferred;

  /// Recommendation on how to return to the plan.
  final RecoveryRecommendation? recoveryRecommendation;

  int get totalTasks => tasks.length;
  int get completedTasks => tasks.where((t) => t.isCompleted).length;
  int get remainingTasks => totalTasks - completedTasks;
  bool get allCompleted => totalTasks > 0 && remainingTasks == 0;

  double get progress {
    if (totalTasks == 0) return 0;
    return completedTasks / totalTasks;
  }

  @override
  List<Object?> get props => [
        tasks,
        isRestDay,
        recoveryNotice,
        isMemorizationDeferred,
        recoveryRecommendation,
      ];
}
