import 'package:equatable/equatable.dart';
import '../../setup/domain/user_setup.dart';
import 'plan_status.dart';
import 'quran_position.dart';
import 'quran_range.dart';

/// Represents a user's active memorization and review plan.
class ActivePlanEntity extends Equatable {
  const ActivePlanEntity({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    required this.memorizationTarget,
    required this.reviewTarget,
    required this.startPosition,
    required this.currentPosition,
    required this.memorizationDays,
    required this.reviewSchedule,
    required this.customReviewDays,
    required this.previousMemorizedRanges,
  });

  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final PlanStatus status;
  final DailyTarget memorizationTarget;
  final DailyTarget reviewTarget;

  /// Where new memorization started in Itqan. Immutable after plan creation.
  final QuranPosition startPosition;

  /// Current furthest position reached by completed memorization sessions.
  final QuranPosition currentPosition;

  /// Weekdays (1=Mon … 7=Sun) on which memorization is scheduled.
  final Set<int> memorizationDays;

  /// How review days are determined.
  final ReviewSchedule reviewSchedule;

  /// Active only when [reviewSchedule] == [ReviewSchedule.custom].
  final Set<int> customReviewDays;

  /// Previously memorized content (before Itqan) used as review baseline.
  ///
  /// IMPORTANT: This is separate from [startPosition] and must never be
  /// inferred from it. May be null if the user had no prior memorization.
  final List<QuranRange> previousMemorizedRanges;

  /// Resolves the effective review weekdays from [reviewSchedule].
  Set<int> get effectiveReviewDays {
    return switch (reviewSchedule) {
      ReviewSchedule.sameAsMemorization => memorizationDays,
      ReviewSchedule.everyday => {1, 2, 3, 4, 5, 6, 7},
      ReviewSchedule.custom => customReviewDays,
    };
  }

  ActivePlanEntity copyWith({
    PlanStatus? status,
    DailyTarget? memorizationTarget,
    DailyTarget? reviewTarget,
    QuranPosition? currentPosition,
    Set<int>? memorizationDays,
    ReviewSchedule? reviewSchedule,
    Set<int>? customReviewDays,
    List<QuranRange>? previousMemorizedRanges,
  }) {
    return ActivePlanEntity(
      id: id,
      createdAt: createdAt,
      updatedAt: DateTime.now(),
      status: status ?? this.status,
      memorizationTarget: memorizationTarget ?? this.memorizationTarget,
      reviewTarget: reviewTarget ?? this.reviewTarget,
      startPosition: startPosition,
      currentPosition: currentPosition ?? this.currentPosition,
      memorizationDays: memorizationDays ?? this.memorizationDays,
      reviewSchedule: reviewSchedule ?? this.reviewSchedule,
      customReviewDays: customReviewDays ?? this.customReviewDays,
      previousMemorizedRanges:
          previousMemorizedRanges ?? this.previousMemorizedRanges,
    );
  }

  @override
  List<Object?> get props => [
        id,
        createdAt,
        updatedAt,
        status,
        memorizationTarget,
        reviewTarget,
        startPosition,
        currentPosition,
        memorizationDays,
        reviewSchedule,
        customReviewDays,
        previousMemorizedRanges,
      ];
}
