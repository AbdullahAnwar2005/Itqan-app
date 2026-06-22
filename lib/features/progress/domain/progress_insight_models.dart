import 'package:equatable/equatable.dart';
import '../../plan/domain/quran_position.dart';
import 'segment_progress_source.dart';
import 'segment_progress_status.dart';

/// Breakdown of session self-ratings in a recent window.
class SessionRatingBreakdown extends Equatable {
  const SessionRatingBreakdown({
    required this.easyCount,
    required this.goodCount,
    required this.hardCount,
    required this.againCount,
    required this.unratedCount,
  });

  final int easyCount;
  final int goodCount;
  final int hardCount;
  final int againCount;
  final int unratedCount;

  @override
  List<Object?> get props => [
        easyCount,
        goodCount,
        hardCount,
        againCount,
        unratedCount,
      ];
}

/// Representation of a weak or needsRetry segment that requires focus.
class PrioritySegmentInsight extends Equatable {
  const PrioritySegmentInsight({
    required this.segmentProgressId,
    required this.startPosition,
    required this.endPosition,
    required this.status,
    required this.source,
    required this.nextReviewAt,
    required this.displayRange,
  });

  final String segmentProgressId;
  final QuranPosition startPosition;
  final QuranPosition endPosition;
  final SegmentProgressStatus status;
  final SegmentProgressSource source;
  final DateTime nextReviewAt;
  final String displayRange;

  @override
  List<Object?> get props => [
        segmentProgressId,
        startPosition,
        endPosition,
        status,
        source,
        nextReviewAt,
        displayRange,
      ];
}

/// Consolidated progress insights based on real database records.
class ProgressInsightSummary extends Equatable {
  const ProgressInsightSummary({
    required this.totalTrackedSegments,
    required this.stableCount,
    required this.stabilizingCount,
    required this.learningCount,
    required this.weakCount,
    required this.needsRetryCount,
    required this.dueTodayCount,
    required this.dueSoonCount,
    required this.appMemorizationCount,
    required this.previousMemorizationCount,
    required this.recentSessionCount,
    required this.lastSessionAt,
    required this.ratingBreakdown,
    required this.prioritySegments,
  });

  final int totalTrackedSegments;
  final int stableCount;
  final int stabilizingCount;
  final int learningCount;
  final int weakCount;
  final int needsRetryCount;
  final int dueTodayCount;
  final int dueSoonCount;
  final int appMemorizationCount;
  final int previousMemorizationCount;
  final int recentSessionCount;
  final DateTime? lastSessionAt;
  final SessionRatingBreakdown ratingBreakdown;
  final List<PrioritySegmentInsight> prioritySegments;

  @override
  List<Object?> get props => [
        totalTrackedSegments,
        stableCount,
        stabilizingCount,
        learningCount,
        weakCount,
        needsRetryCount,
        dueTodayCount,
        dueSoonCount,
        appMemorizationCount,
        previousMemorizationCount,
        recentSessionCount,
        lastSessionAt,
        ratingBreakdown,
        prioritySegments,
      ];
}
