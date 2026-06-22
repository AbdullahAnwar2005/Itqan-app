import 'package:equatable/equatable.dart';

import '../../plan/domain/quran_position.dart';
import '../../plan/domain/quran_range.dart';
import '../domain/user_setup.dart';
import 'previous_memorization_draft_entry.dart';

class SetupWizardState extends Equatable {
  const SetupWizardState({
    required this.memorizationTarget,
    required this.reviewTarget,
    required this.memorizationDays,
    required this.reviewSchedule,
    required this.customReviewDays,
    required this.hasPreviousMemorization,
    required this.previousMemorizationEntries,
    required this.startPosition,
    required this.suggestedStartPosition,
  });

  // Flow global fields
  final DailyTarget memorizationTarget;
  final DailyTarget reviewTarget;
  final Set<int> memorizationDays;
  final ReviewSchedule reviewSchedule;
  final Set<int> customReviewDays;

  // Previous Memorization specific fields
  final bool hasPreviousMemorization;
  final List<PreviousMemorizationDraftEntry> previousMemorizationEntries;
  final QuranPosition startPosition;
  final QuranPosition? suggestedStartPosition;

  bool get canContinueFromPreviousMemorization {
    if (!hasPreviousMemorization) return true;
    return previousMemorizationEntries.isNotEmpty;
  }

  SetupWizardState copyWith({
    DailyTarget? memorizationTarget,
    DailyTarget? reviewTarget,
    Set<int>? memorizationDays,
    ReviewSchedule? reviewSchedule,
    Set<int>? customReviewDays,
    bool? hasPreviousMemorization,
    List<PreviousMemorizationDraftEntry>? previousMemorizationEntries,
    bool clearEntries = false,
    QuranPosition? startPosition,
    QuranPosition? suggestedStartPosition,
  }) {
    return SetupWizardState(
      memorizationTarget: memorizationTarget ?? this.memorizationTarget,
      reviewTarget: reviewTarget ?? this.reviewTarget,
      memorizationDays: memorizationDays ?? this.memorizationDays,
      reviewSchedule: reviewSchedule ?? this.reviewSchedule,
      customReviewDays: customReviewDays ?? this.customReviewDays,
      hasPreviousMemorization: hasPreviousMemorization ?? this.hasPreviousMemorization,
      previousMemorizationEntries: clearEntries
          ? const []
          : (previousMemorizationEntries ?? this.previousMemorizationEntries),
      startPosition: startPosition ?? this.startPosition,
      suggestedStartPosition: suggestedStartPosition ?? this.suggestedStartPosition,
    );
  }

  /// Converts the wizard state into the domain entity [UserSetup] for persistence.
  ///
  /// [derivedRanges] must be the canonical ranges derived from
  /// [previousMemorizationEntries] by the service layer. This keeps range
  /// derivation out of the state model itself.
  UserSetup toUserSetup({required List<QuranRange> derivedRanges}) {
    return UserSetup(
      memorizationTarget: memorizationTarget,
      reviewTarget: reviewTarget,
      memorizationDays: memorizationDays,
      reviewSchedule: reviewSchedule,
      customReviewDays: customReviewDays,
      startPosition: startPosition,
      previousMemorizedRanges: derivedRanges,
    );
  }

  factory SetupWizardState.initial() {
    return const SetupWizardState(
      memorizationTarget: DailyTarget(amount: 1, unit: ProgressUnit.page),
      reviewTarget: DailyTarget(amount: 1, unit: ProgressUnit.page),
      memorizationDays: {1, 2, 3, 4, 5},
      reviewSchedule: ReviewSchedule.everyday,
      customReviewDays: {},
      hasPreviousMemorization: false,
      previousMemorizationEntries: [],
      startPosition: QuranPosition(surahNumber: 1, ayahNumber: 1),
      suggestedStartPosition: null,
    );
  }

  @override
  List<Object?> get props => [
        memorizationTarget,
        reviewTarget,
        memorizationDays,
        reviewSchedule,
        customReviewDays,
        hasPreviousMemorization,
        previousMemorizationEntries,
        startPosition,
        suggestedStartPosition,
      ];
}
