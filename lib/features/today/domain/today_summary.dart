import 'package:equatable/equatable.dart';
import 'today_task.dart';

/// Summary of the user's status for the current day.
class TodaySummary extends Equatable {
  const TodaySummary({
    required this.tasks,
  });

  final List<TodayTask> tasks;

  int get totalTasks => tasks.length;
  int get completedTasks => tasks.where((t) => t.isCompleted).length;
  int get remainingTasks => totalTasks - completedTasks;
  bool get allCompleted => totalTasks > 0 && remainingTasks == 0;
  
  double get progress {
    if (totalTasks == 0) return 0;
    return completedTasks / totalTasks;
  }

  @override
  List<Object?> get props => [tasks];
}
