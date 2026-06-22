import 'package:equatable/equatable.dart';

/// Represents a simple recovery recommendation when the user has unfinished past assignments.
class RecoveryNotice extends Equatable {
  const RecoveryNotice({
    required this.hasMissedWork,
    required this.missedDaysCount,
    required this.missedMemorizationCount,
    required this.missedReviewCount,
  });

  /// True if there is at least one missed assignment.
  final bool hasMissedWork;
  
  /// Number of unique past days with missed work.
  final int missedDaysCount;
  
  /// Number of past memorization tasks that were not completed.
  final int missedMemorizationCount;
  
  /// Number of past review tasks that were not completed.
  final int missedReviewCount;

  @override
  List<Object?> get props => [
        hasMissedWork,
        missedDaysCount,
        missedMemorizationCount,
        missedReviewCount,
      ];
}
