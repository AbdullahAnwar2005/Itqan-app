import 'package:equatable/equatable.dart';
import 'package:itqan/core/utils/arabic_formatter.dart';
import '../../setup/domain/user_setup.dart';

/// Types of tasks available in the Today view.
enum TodayTaskType {
  /// New memorization work
  memorization,

  /// Revision of previously memorized material
  review;

  String get label {
    return switch (this) {
      TodayTaskType.memorization => 'حفظ جديد', // Refined labels
      TodayTaskType.review => 'مراجعة',
    };
  }
}

/// A discrete task for the current day.
///
/// In Increment 2, these are generated directly from [UserSetup].
class TodayTask extends Equatable {
  const TodayTask({
    required this.id,
    required this.type,
    required this.target,
    this.isCompleted = false,
  });

  final String id;
  final TodayTaskType type;
  final DailyTarget target;
  final bool isCompleted;

  String get title => type.label;

  /// Human-readable target description (e.g. "5 Ayahs", "1 Juz")
  String get targetDescription => ArabicFormatter.formatTarget(target);

  TodayTask copyWith({
    bool? isCompleted,
  }) {
    return TodayTask(
      id: id,
      type: type,
      target: target,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  @override
  List<Object?> get props => [id, type, target, isCompleted];
}
