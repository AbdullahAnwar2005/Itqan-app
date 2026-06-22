import 'package:equatable/equatable.dart';
import 'package:itqan/core/constants/quran_metadata.dart';
import 'package:itqan/core/utils/arabic_formatter.dart';
import '../../plan/domain/quran_position.dart';
import '../../setup/domain/user_setup.dart';

/// Types of tasks available in the Today view.
enum TodayTaskType {
  /// New memorization work
  memorization,

  /// Revision of previously memorized material
  review,
  
  /// Specific review of recently memorized or weak material
  nearReview,
  
  /// Review of previously memorized material from the registry
  oldReview;

  String get label {
    return switch (this) {
      TodayTaskType.memorization => 'الحفظ',
      TodayTaskType.review => 'المراجعة',
      TodayTaskType.nearReview => 'تثبيت قريب',
      TodayTaskType.oldReview => 'مراجعة قديمة',
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
    this.target,
    this.startPosition,
    this.endPosition,
    this.segmentProgressId,
    this.isCompleted = false,
  });

  final String id;
  final TodayTaskType type;
  final DailyTarget? target;
  final QuranPosition? startPosition;
  final QuranPosition? endPosition;
  final String? segmentProgressId;
  final bool isCompleted;

  String get title => type.label;

  /// Human-readable target description (e.g. "5 Ayahs", "1 Juz")
  String get targetDescription {
    if ((type == TodayTaskType.nearReview || type == TodayTaskType.oldReview) && 
        startPosition != null && 
        endPosition != null) {
      return ArabicFormatter.formatRange(startPosition!, endPosition!);
    }
    return target != null ? ArabicFormatter.formatTarget(target!) : '';
  }

  TodayTask copyWith({
    bool? isCompleted,
    String? segmentProgressId,
  }) {
    return TodayTask(
      id: id,
      type: type,
      target: target,
      startPosition: startPosition,
      endPosition: endPosition,
      segmentProgressId: segmentProgressId ?? this.segmentProgressId,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  @override
  List<Object?> get props => [id, type, target, startPosition, endPosition, segmentProgressId, isCompleted];
}
