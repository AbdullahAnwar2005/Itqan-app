import 'package:equatable/equatable.dart';
import '../../setup/domain/user_setup.dart';
import 'plan_status.dart';
import 'quran_position.dart';

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
  });

  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final PlanStatus status;
  final DailyTarget memorizationTarget;
  final DailyTarget reviewTarget;
  final QuranPosition startPosition;
  final QuranPosition currentPosition;

  ActivePlanEntity copyWith({
    PlanStatus? status,
    DailyTarget? memorizationTarget,
    DailyTarget? reviewTarget,
    QuranPosition? startPosition,
    QuranPosition? currentPosition,
  }) {
    return ActivePlanEntity(
      id: id,
      createdAt: createdAt,
      updatedAt: DateTime.now(),
      status: status ?? this.status,
      memorizationTarget: memorizationTarget ?? this.memorizationTarget,
      reviewTarget: reviewTarget ?? this.reviewTarget,
      startPosition: startPosition ?? this.startPosition,
      currentPosition: currentPosition ?? this.currentPosition,
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
      ];
}
