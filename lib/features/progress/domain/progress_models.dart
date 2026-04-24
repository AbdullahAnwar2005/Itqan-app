import 'package:equatable/equatable.dart';
import '../../plan/domain/quran_position.dart';

/// Summarizes the user's progress in their current memorization journey.
class ProgressSummary extends Equatable {
  const ProgressSummary({
    required this.memorization,
    required this.recentActivity,
    required this.consistency,
  });

  final MemorizationProgressSnapshot memorization;
  final RecentActivitySummary recentActivity;
  final ConsistencySummary consistency;

  @override
  List<Object?> get props => [memorization, recentActivity, consistency];
}

/// Snapshot of current memorization position vs starting position.
class MemorizationProgressSnapshot extends Equatable {
  const MemorizationProgressSnapshot({
    required this.startPosition,
    required this.currentPosition,
  });

  final QuranPosition startPosition;
  final QuranPosition currentPosition;

  @override
  List<Object?> get props => [startPosition, currentPosition];
}

/// Summary of work completed in a recent window (e.g., last 7 days).
class RecentActivitySummary extends Equatable {
  const RecentActivitySummary({
    required this.daysInWindow,
    required this.completedMemorizationTasks,
    required this.completedReviewTasks,
    required this.completedDays,
  });

  final int daysInWindow;
  final int completedMemorizationTasks;
  final int completedReviewTasks;
  final int completedDays;

  @override
  List<Object?> get props => [
        daysInWindow,
        completedMemorizationTasks,
        completedReviewTasks,
        completedDays,
      ];
}

/// Summary of consistency and streaks.
class ConsistencySummary extends Equatable {
  const ConsistencySummary({
    required this.currentStreak,
    required this.bestStreak,
    required this.completionRateRecent,
  });

  final int currentStreak;
  final int bestStreak;
  final double completionRateRecent; // 0.0 to 1.0

  @override
  List<Object?> get props => [currentStreak, bestStreak, completionRateRecent];
}
