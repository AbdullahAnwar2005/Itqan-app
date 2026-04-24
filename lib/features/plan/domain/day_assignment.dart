import 'package:equatable/equatable.dart';
import '../../setup/domain/user_setup.dart';
import 'quran_position.dart';

/// Represents the assigned work for a specific day.
class DayAssignmentEntity extends Equatable {
  const DayAssignmentEntity({
    required this.id,
    required this.planId,
    required this.dateKey,
    required this.memoStart,
    required this.memoEnd,
    required this.memoTarget,
    required this.reviewTarget,
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
  final bool isMemoDone;
  final bool isReviewDone;
  final DateTime createdAt;

  DayAssignmentEntity copyWith({
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
      isMemoDone: isMemoDone ?? this.isMemoDone,
      isReviewDone: isReviewDone ?? this.isReviewDone,
      createdAt: createdAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        planId,
        dateKey,
        memoStart,
        memoEnd,
        memoTarget,
        reviewTarget,
        isMemoDone,
        isReviewDone,
        createdAt,
      ];
}
