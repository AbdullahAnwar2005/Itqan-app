import 'package:equatable/equatable.dart';
import '../../plan/domain/day_assignment.dart';

/// Types of work sessions.
enum SessionType {
  /// Memorizing new material.
  memorization,

  /// Reviewing previously memorized material.
  review;

  String get label {
    return switch (this) {
      SessionType.memorization => 'حفظ جديد',
      SessionType.review => 'مراجعة اليوم',
    };
  }
}

/// Lifecycle states of a session.
enum SessionStatus {
  /// Session has not started.
  idle,

  /// User is actively performing the session tasks.
  inProgress,

  /// Session successfully completed.
  completed,

  /// Session was exited without completion.
  canceled,
}

/// Domain entity representing a work session.
class WorkSession extends Equatable {
  const WorkSession({
    required this.id,
    required this.type,
    required this.assignment,
    this.status = SessionStatus.idle,
    this.startedAt,
    this.endedAt,
  });

  final String id;
  final SessionType type;
  final DayAssignmentEntity assignment;
  final SessionStatus status;
  final DateTime? startedAt;
  final DateTime? endedAt;

  bool get isCompleted => status == SessionStatus.completed;

  WorkSession copyWith({
    SessionStatus? status,
    DateTime? startedAt,
    DateTime? endedAt,
  }) {
    return WorkSession(
      id: id,
      type: type,
      assignment: assignment,
      status: status ?? this.status,
      startedAt: startedAt ?? this.startedAt,
      endedAt: endedAt ?? this.endedAt,
    );
  }

  @override
  List<Object?> get props => [id, type, assignment, status, startedAt, endedAt];
}
