import 'package:equatable/equatable.dart';

import '../../plan/domain/quran_position.dart';
import '../../plan/domain/quran_range.dart';

/// Supported units for progress and target tracking.
enum ProgressUnit {
  ayah,
  page,
  hizb,
  juz,
}

/// A target quantity combined with its unit of measurement.
///
/// Represents how much the user commits to do on an active day
/// (memorization day or review day), not necessarily every calendar day.
class DailyTarget extends Equatable {
  const DailyTarget({
    required this.amount,
    required this.unit,
  });

  final double amount;
  final ProgressUnit unit;

  @override
  List<Object?> get props => [amount, unit];
}

/// Which days the user performs review.
///
/// - [sameAsMemorization]: Review only on memorization days.
/// - [everyday]: Review every day of the week.
/// - [custom]: Review on a custom-selected set of days.
enum ReviewSchedule {
  sameAsMemorization,
  everyday,
  custom;

  String get labelAr {
    return switch (this) {
      ReviewSchedule.sameAsMemorization => 'نفس أيام الحفظ',
      ReviewSchedule.everyday => 'كل يوم',
      ReviewSchedule.custom => 'مخصص',
    };
  }

  String get persistenceKey {
    return switch (this) {
      ReviewSchedule.sameAsMemorization => 'sameAsMemorization',
      ReviewSchedule.everyday => 'everyday',
      ReviewSchedule.custom => 'custom',
    };
  }

  static ReviewSchedule fromKey(String key) {
    return ReviewSchedule.values.firstWhere(
      (e) => e.persistenceKey == key,
      orElse: () => ReviewSchedule.everyday,
    );
  }
}

/// Pace / intensity preference — kept for legacy data reading only.
///
/// This enum is no longer used in new logic. It exists solely so that
/// existing stored data can be read and migrated without crashing.
/// Do NOT use [MemorizationIntensity] in any new code path.
@Deprecated('Replaced by weekly schedule (memorizationDays + reviewSchedule). '
    'Kept only for legacy data migration.')
enum MemorizationIntensity {
  relaxed,
  moderate,
  intensive;

  String get persistenceKey {
    return switch (this) {
      MemorizationIntensity.relaxed => 'relaxed',
      MemorizationIntensity.moderate => 'moderate',
      MemorizationIntensity.intensive => 'intensive',
    };
  }

  static MemorizationIntensity fromKey(String key) {
    return MemorizationIntensity.values.firstWhere(
      (e) => e.persistenceKey == key,
      orElse: () => MemorizationIntensity.moderate,
    );
  }
}

/// Minimum user setup data needed before any plan can be generated.
///
/// ## Field semantics
/// - [memorizationTarget] — how much the user memorizes *on a memorization day*.
/// - [reviewTarget] — how much the user reviews *on a review day*.
/// - [memorizationDays] — which weekdays (1=Mon … 7=Sun) the user memorizes on.
/// - [reviewSchedule] — which days the user reviews (relative to memorization days or absolute).
/// - [customReviewDays] — populated only when [reviewSchedule] is [ReviewSchedule.custom].
/// - [startPosition] — explicit start of new memorization in Itqan. NEVER inferred from [previousMemorizedRange].
/// - [previousMemorizedRange] — optional range of content already memorized before using Itqan.
///   Used ONLY as the review baseline. Has NO relationship to [startPosition].
///
/// This entity is immutable. Use [copyWith] to produce updated instances.
class UserSetup extends Equatable {
  const UserSetup({
    required this.memorizationTarget,
    required this.reviewTarget,
    required this.memorizationDays,
    required this.reviewSchedule,
    required this.customReviewDays,
    required this.startPosition,
    required this.previousMemorizedRanges,
  });

  final DailyTarget memorizationTarget;
  final DailyTarget reviewTarget;

  /// Days of week (1=Monday … 7=Sunday) on which memorization is scheduled.
  final Set<int> memorizationDays;

  /// How review days are determined.
  final ReviewSchedule reviewSchedule;

  /// Active only when [reviewSchedule] is [ReviewSchedule.custom].
  final Set<int> customReviewDays;

  /// Where new memorization begins in Itqan.
  ///
  /// IMPORTANT: This value has no relationship to [previousMemorizedRange].
  /// Starting from surah 3 does NOT imply surahs 1–2 are memorized.
  final QuranPosition startPosition;

  /// Previously memorized content (before using Itqan) to use as review baseline.
  ///
  /// IMPORTANT: This is ONLY used for review generation.
  /// It does NOT affect [startPosition] or new memorization progression.
  final List<QuranRange> previousMemorizedRanges;

  /// Resolves the effective set of review weekdays based on [reviewSchedule].
  Set<int> get effectiveReviewDays {
    return switch (reviewSchedule) {
      ReviewSchedule.sameAsMemorization => memorizationDays,
      ReviewSchedule.everyday => {1, 2, 3, 4, 5, 6, 7},
      ReviewSchedule.custom => customReviewDays,
    };
  }

  UserSetup copyWith({
    DailyTarget? memorizationTarget,
    DailyTarget? reviewTarget,
    Set<int>? memorizationDays,
    ReviewSchedule? reviewSchedule,
    Set<int>? customReviewDays,
    QuranPosition? startPosition,
    List<QuranRange>? previousMemorizedRanges,
    bool clearPreviousRanges = false,
  }) {
    return UserSetup(
      memorizationTarget: memorizationTarget ?? this.memorizationTarget,
      reviewTarget: reviewTarget ?? this.reviewTarget,
      memorizationDays: memorizationDays ?? this.memorizationDays,
      reviewSchedule: reviewSchedule ?? this.reviewSchedule,
      customReviewDays: customReviewDays ?? this.customReviewDays,
      startPosition: startPosition ?? this.startPosition,
      previousMemorizedRanges: clearPreviousRanges
          ? const []
          : (previousMemorizedRanges ?? this.previousMemorizedRanges),
    );
  }

  @override
  List<Object?> get props => [
        memorizationTarget,
        reviewTarget,
        memorizationDays,
        reviewSchedule,
        customReviewDays,
        startPosition,
        previousMemorizedRanges,
      ];
}
