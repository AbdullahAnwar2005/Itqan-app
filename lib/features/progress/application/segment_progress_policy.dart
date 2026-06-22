import 'package:equatable/equatable.dart';
import '../../session/domain/session_rating.dart';
import '../domain/segment_progress_status.dart';

class SegmentProgressDecision extends Equatable {
  const SegmentProgressDecision({
    required this.status,
    required this.masteryScore,
    required this.nextReviewAt,
  });

  final SegmentProgressStatus status;
  final int masteryScore;
  final DateTime nextReviewAt;

  @override
  List<Object?> get props => [status, masteryScore, nextReviewAt];
}

class SegmentProgressPolicy {
  const SegmentProgressPolicy();

  SegmentProgressDecision fromRating(SessionRating rating, DateTime now) {
    switch (rating) {
      case SessionRating.easy:
        return SegmentProgressDecision(
          status: SegmentProgressStatus.stable,
          masteryScore: 3,
          nextReviewAt: now.add(const Duration(days: 3)),
        );
      case SessionRating.good:
        return SegmentProgressDecision(
          status: SegmentProgressStatus.stabilizing,
          masteryScore: 2,
          nextReviewAt: now.add(const Duration(days: 1)),
        );
      case SessionRating.hard:
        return SegmentProgressDecision(
          status: SegmentProgressStatus.weak,
          masteryScore: 1,
          nextReviewAt: now.add(const Duration(days: 1)),
        );
      case SessionRating.again:
        return SegmentProgressDecision(
          status: SegmentProgressStatus.needsRetry,
          masteryScore: 0,
          nextReviewAt: now,
        );
      case SessionRating.unrated:
        return SegmentProgressDecision(
          status: SegmentProgressStatus.stabilizing,
          masteryScore: 2,
          nextReviewAt: now.add(const Duration(days: 1)),
        );
    }
  }
}
