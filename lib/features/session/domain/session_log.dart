import 'package:equatable/equatable.dart';
import '../../plan/domain/quran_position.dart';
import 'session.dart';
import 'session_rating.dart';

/// Represents a log of a completed session.
class SessionLogEntry extends Equatable {
  const SessionLogEntry({
    required this.id,
    required this.assignmentId,
    required this.planId,
    required this.sessionType,
    this.startPosition,
    this.endPosition,
    required this.rating,
    required this.completedAt,
    required this.createdAt,
  });

  final String id;
  final String assignmentId;
  final String planId;
  final SessionType sessionType;
  
  /// The starting position of the Quran range covered, if applicable.
  final QuranPosition? startPosition;
  
  /// The ending position of the Quran range covered, if applicable.
  final QuranPosition? endPosition;
  
  final SessionRating rating;
  final DateTime completedAt;
  final DateTime createdAt;

  @override
  List<Object?> get props => [
        id,
        assignmentId,
        planId,
        sessionType,
        startPosition,
        endPosition,
        rating,
        completedAt,
        createdAt,
      ];
}
