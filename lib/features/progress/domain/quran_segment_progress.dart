import 'package:equatable/equatable.dart';
import '../../plan/domain/quran_position.dart';
import '../../session/domain/session_rating.dart';
import 'segment_progress_source.dart';
import 'segment_progress_status.dart';

/// Represents the internal progress and mastery state of a specific memorized segment.
class QuranSegmentProgress extends Equatable {
  const QuranSegmentProgress({
    required this.id,
    required this.planId,
    required this.startPosition,
    required this.endPosition,
    required this.status,
    required this.masteryScore,
    required this.lastRating,
    required this.lastPracticedAt,
    required this.nextReviewAt,
    required this.source,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String planId;
  final QuranPosition startPosition;
  final QuranPosition endPosition;
  final SegmentProgressStatus status;
  final int masteryScore;
  final SessionRating lastRating;
  final DateTime lastPracticedAt;
  final DateTime nextReviewAt;
  final SegmentProgressSource source;
  final DateTime createdAt;
  final DateTime updatedAt;

  QuranSegmentProgress copyWith({
    String? id,
    SegmentProgressStatus? status,
    int? masteryScore,
    SessionRating? lastRating,
    DateTime? lastPracticedAt,
    DateTime? nextReviewAt,
    DateTime? updatedAt,
  }) {
    return QuranSegmentProgress(
      id: id ?? this.id,
      planId: planId,
      startPosition: startPosition,
      endPosition: endPosition,
      status: status ?? this.status,
      masteryScore: masteryScore ?? this.masteryScore,
      lastRating: lastRating ?? this.lastRating,
      lastPracticedAt: lastPracticedAt ?? this.lastPracticedAt,
      nextReviewAt: nextReviewAt ?? this.nextReviewAt,
      source: this.source,
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        planId,
        startPosition,
        endPosition,
        status,
        masteryScore,
        lastRating,
        lastPracticedAt,
        nextReviewAt,
        source,
        createdAt,
        updatedAt,
      ];
}
