import 'package:intl/intl.dart';
import '../../plan/domain/active_plan.dart';
import '../../plan/domain/day_assignment.dart';
import '../domain/progress_models.dart';

class ProgressService {
  const ProgressService();

  /// Computes a full [ProgressSummary] from the active plan and its assignments.
  ProgressSummary computeSummary({
    required ActivePlanEntity plan,
    required List<DayAssignmentEntity> assignments,
    int windowSize = 7,
  }) {
    return ProgressSummary(
      memorization: MemorizationProgressSnapshot(
        startPosition: plan.startPosition,
        currentPosition: plan.currentPosition,
      ),
      recentActivity: _computeRecentActivity(assignments, windowSize),
      consistency: _computeConsistency(assignments, windowSize),
    );
  }

  RecentActivitySummary _computeRecentActivity(
    List<DayAssignmentEntity> assignments,
    int windowSize,
  ) {
    final now = DateTime.now();
    final windowStart = DateTime(now.year, now.month, now.day).subtract(Duration(days: windowSize - 1));
    final dateFormat = DateFormat('yyyy-MM-dd');

    // Filter assignments that fall within the calendar window
    final recent = assignments.where((a) {
      try {
        final date = dateFormat.parse(a.dateKey);
        return date.isAfter(windowStart.subtract(const Duration(seconds: 1)));
      } catch (_) {
        return false;
      }
    }).toList();

    int memoCount = 0;
    int reviewCount = 0;
    int completedDays = 0;

    for (final assignment in recent) {
      if (assignment.isMemoDone) memoCount++;
      if (assignment.isReviewDone) reviewCount++;
      if (assignment.isMemoDone && assignment.isReviewDone) completedDays++;
    }

    return RecentActivitySummary(
      daysInWindow: windowSize,
      completedMemorizationTasks: memoCount,
      completedReviewTasks: reviewCount,
      completedDays: completedDays,
    );
  }

  ConsistencySummary _computeConsistency(
    List<DayAssignmentEntity> assignments,
    int windowSize,
  ) {
    final streak = _calculateCurrentStreak(assignments);
    
    // For completion rate, we use the same calendar-filtered assignments
    final recentActivity = _computeRecentActivity(assignments, windowSize);
    final rate = windowSize > 0 ? recentActivity.completedDays / windowSize : 0.0;

    return ConsistencySummary(
      currentStreak: streak,
      bestStreak: streak, 
      completionRateRecent: rate,
    );
  }

  int _calculateCurrentStreak(List<DayAssignmentEntity> assignments) {
    if (assignments.isEmpty) return 0;

    final todayKey = DateFormat('yyyy-MM-dd').format(DateTime.now());
    int streak = 0;
    
    // assignments are desc by dateKey
    for (int i = 0; i < assignments.length; i++) {
      final a = assignments[i];
      final isDone = a.isMemoDone && a.isReviewDone;

      if (isDone) {
        streak++;
      } else {
        // If this is today's assignment and it's not done yet, 
        // we don't break the streak (give the user until end of day).
        if (a.dateKey == todayKey) continue;
        
        // If it's a past day and it's not done, the streak is broken.
        break;
      }
    }
    return streak;
  }
}
