import 'package:equatable/equatable.dart';
import '../../setup/domain/user_setup.dart';
import 'quran_position.dart';

/// Represents the assigned work for a specific day.
///
/// [hasMemoTask] and [hasReviewTask] indicate whether today is a
/// scheduled memorization/review day. They are false on rest days.
/// [isMemoDone] and [isReviewDone] track completion — only meaningful
/// when the corresponding has* flag is true.
class DayAssignmentEntity extends Equatable {
  const DayAssignmentEntity({
    required this.id,
    required this.planId,
    required this.dateKey,
    required this.memoStart,
    required this.memoEnd,
    required this.memoTarget,
    required this.reviewTarget,
    this.hasMemoTask = true,
    this.hasReviewTask = true,
    this.isMemoDone = false,
    this.isReviewDone = false,
    required this.createdAt,
  });

  final String id;
  final String planId;
  final String dateKey;
  final QuranPosition memoStart;
  final QuranPosition memoEnd;
  final DailyTarget memoTarget;
  final DailyTarget reviewTarget;

  /// True if today is a scheduled memorization day.
  final bool hasMemoTask;

  /// True if today is a scheduled review day AND there is known content to review.
  final bool hasReviewTask;

  final bool isMemoDone;
  final bool isReviewDone;
  final DateTime createdAt;

  DayAssignmentEntity copyWith({
    bool? hasMemoTask,
    bool? hasReviewTask,
    bool? isMemoDone,
    bool? isReviewDone,
  }) {
    return DayAssignmentEntity(
      id: id,
      planId: planId,
      dateKey: dateKey,
      memoStart: memoStart,
      memoEnd: memoEnd,
      memoTarget: memoTarget,
      reviewTarget: reviewTarget,
      hasMemoTask: hasMemoTask ?? this.hasMemoTask,
      hasReviewTask: hasReviewTask ?? this.hasReviewTask,
      isMemoDone: isMemoDone ?? this.isMemoDone,
      isReviewDone: isReviewDone ?? this.isReviewDone,
      createdAt: createdAt,
    );
  }

  /// True if this day has no scheduled tasks (rest day).
  bool get isRestDay => !hasMemoTask && !hasReviewTask;

  @override
  List<Object?> get props => [
        id,
        planId,
        dateKey,
        memoStart,
        memoEnd,
        memoTarget,
        reviewTarget,
        hasMemoTask,
        hasReviewTask,
        isMemoDone,
        isReviewDone,
        createdAt,
      ];
}
