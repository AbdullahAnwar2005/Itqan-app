import '../../../core/utils/arabic_formatter.dart';
import '../../session/data/session_repository.dart';
import '../../session/domain/session_rating.dart';
import '../data/segment_progress_repository.dart';
import '../domain/progress_insight_models.dart';
import '../domain/quran_segment_progress.dart';
import '../domain/segment_progress_source.dart';
import '../domain/segment_progress_status.dart';

class ProgressInsightService {
  const ProgressInsightService({
    required SegmentProgressRepository segmentProgressRepository,
    required SessionRepository sessionRepository,
  })  : _segmentProgressRepository = segmentProgressRepository,
        _sessionRepository = sessionRepository;

  final SegmentProgressRepository _segmentProgressRepository;
  final SessionRepository _sessionRepository;

  /// Computes deterministic [ProgressInsightSummary] based on actual database data.
  Future<ProgressInsightSummary> getSummary({
    required String planId,
    required DateTime now,
  }) async {
    // 1. Fetch segments and session logs from repositories
    final segments = await _segmentProgressRepository.getAllSegmentsForPlan(planId);
    final logs = await _sessionRepository.getSessionLogsForPlan(planId);

    // 2. Counts from segments
    final totalTrackedSegments = segments.length;
    int stableCount = 0;
    int stabilizingCount = 0;
    int learningCount = 0;
    int weakCount = 0;
    int needsRetryCount = 0;
    int appMemorizationCount = 0;
    int previousMemorizationCount = 0;

    for (final s in segments) {
      switch (s.status) {
        case SegmentProgressStatus.stable:
          stableCount++;
          break;
        case SegmentProgressStatus.stabilizing:
          stabilizingCount++;
          break;
        case SegmentProgressStatus.learning:
          learningCount++;
          break;
        case SegmentProgressStatus.weak:
          weakCount++;
          break;
        case SegmentProgressStatus.needsRetry:
          needsRetryCount++;
          break;
      }

      switch (s.source) {
        case SegmentProgressSource.appMemorization:
          appMemorizationCount++;
          break;
        case SegmentProgressSource.previousMemorization:
          previousMemorizationCount++;
          break;
      }
    }

    // 3. Due review counts
    // endOfToday: 23:59:59.999 of now's date
    final endOfToday = DateTime(now.year, now.month, now.day, 23, 59, 59, 999);
    final endOfThreeDays = endOfToday.add(const Duration(days: 3));

    int dueTodayCount = 0;
    int dueSoonCount = 0;

    for (final s in segments) {
      if (!s.nextReviewAt.isAfter(endOfToday)) {
        dueTodayCount++;
      } else if (!s.nextReviewAt.isAfter(endOfThreeDays)) {
        dueSoonCount++;
      }
    }

    // 4. Session logs calculations
    DateTime? lastSessionAt;
    if (logs.isNotEmpty) {
      lastSessionAt = logs.first.completedAt;
      for (final log in logs) {
        if (log.completedAt.isAfter(lastSessionAt!)) {
          lastSessionAt = log.completedAt;
        }
      }
    }

    final sevenDaysAgo = now.subtract(const Duration(days: 7));
    final recentLogs = logs
        .where((l) =>
            l.completedAt.isAfter(sevenDaysAgo) ||
            l.completedAt.isAtSameMomentAs(sevenDaysAgo))
        .toList();
    final recentSessionCount = recentLogs.length;

    int easyCount = 0;
    int goodCount = 0;
    int hardCount = 0;
    int againCount = 0;
    int unratedCount = 0;

    for (final log in recentLogs) {
      switch (log.rating) {
        case SessionRating.easy:
          easyCount++;
          break;
        case SessionRating.good:
          goodCount++;
          break;
        case SessionRating.hard:
          hardCount++;
          break;
        case SessionRating.again:
          againCount++;
          break;
        case SessionRating.unrated:
          unratedCount++;
          break;
      }
    }

    final ratingBreakdown = SessionRatingBreakdown(
      easyCount: easyCount,
      goodCount: goodCount,
      hardCount: hardCount,
      againCount: againCount,
      unratedCount: unratedCount,
    );

    // 5. Priority segments sorting and formatting
    final priorityCandidates = segments
        .where((s) =>
            s.status == SegmentProgressStatus.needsRetry ||
            s.status == SegmentProgressStatus.weak)
        .toList();

    priorityCandidates.sort((a, b) {
      if (a.status != b.status) {
        if (a.status == SegmentProgressStatus.needsRetry) return -1;
        if (b.status == SegmentProgressStatus.needsRetry) return 1;
      }
      return a.nextReviewAt.compareTo(b.nextReviewAt);
    });

    final prioritySegments = priorityCandidates.take(5).map((s) {
      return PrioritySegmentInsight(
        segmentProgressId: s.id,
        startPosition: s.startPosition,
        endPosition: s.endPosition,
        status: s.status,
        source: s.source,
        nextReviewAt: s.nextReviewAt,
        displayRange: ArabicFormatter.formatRange(s.startPosition, s.endPosition),
      );
    }).toList();

    return ProgressInsightSummary(
      totalTrackedSegments: totalTrackedSegments,
      stableCount: stableCount,
      stabilizingCount: stabilizingCount,
      learningCount: learningCount,
      weakCount: weakCount,
      needsRetryCount: needsRetryCount,
      dueTodayCount: dueTodayCount,
      dueSoonCount: dueSoonCount,
      appMemorizationCount: appMemorizationCount,
      previousMemorizationCount: previousMemorizationCount,
      recentSessionCount: recentSessionCount,
      lastSessionAt: lastSessionAt,
      ratingBreakdown: ratingBreakdown,
      prioritySegments: prioritySegments,
    );
  }
}
