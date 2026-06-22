import 'package:equatable/equatable.dart';

import '../../plan/domain/quran_position.dart';

/// A user-facing draft entry representing previously memorized Quran content.
///
/// This is onboarding-only application data. It captures *what the user added*
/// (a whole surah, a partial surah, or a juz) so the UI can render it
/// exactly as the user thinks of it.
///
/// Range derivation (to [QuranRange]) is handled by
/// [PreviousMemorizationService], not by the entry itself.
sealed class PreviousMemorizationDraftEntry extends Equatable {
  const PreviousMemorizationDraftEntry({required this.id});

  /// Unique identifier for this draft entry.
  final String id;
}

/// A previously memorized surah — whole or partial.
///
/// When [isWholeSurah] is true, [fromAyah] and [toAyah] are ignored.
class PreviousSurahEntry extends PreviousMemorizationDraftEntry {
  const PreviousSurahEntry({
    required super.id,
    required this.surahNumber,
    required this.isWholeSurah,
    this.fromAyah,
    this.toAyah,
  });

  final int surahNumber;
  final bool isWholeSurah;

  /// First ayah (inclusive). Only meaningful when [isWholeSurah] is false.
  final int? fromAyah;

  /// Last ayah (inclusive). Only meaningful when [isWholeSurah] is false.
  final int? toAyah;

  @override
  List<Object?> get props => [id, surahNumber, isWholeSurah, fromAyah, toAyah];
}

/// How much of a surah segment inside a Juz is memorized.
enum MemorizationCoverageType {
  /// The full segment (segmentStart → segmentEnd) is memorized.
  full,

  /// Only a partial ayah range within the segment is memorized.
  partial,

  /// This segment is not memorized at all.
  none,
}

/// Per-surah coverage detail inside a customized [PreviousJuzEntry].
///
/// Each segment represents the portion of a surah that belongs to the Juz.
/// [segmentStart] and [segmentEnd] define the Juz's boundaries within that surah
/// and are read-only (derived from [JuzMetadata]).
class JuzSurahCoverage extends Equatable {
  const JuzSurahCoverage({
    required this.surahNumber,
    required this.segmentStart,
    required this.segmentEnd,
    required this.type,
    this.fromAyah,
    this.toAyah,
  });

  final int surahNumber;

  /// The first ayah of this surah that belongs to the Juz (inclusive).
  final QuranPosition segmentStart;

  /// The last ayah of this surah that belongs to the Juz (inclusive).
  final QuranPosition segmentEnd;

  /// Whether this segment is fully memorized, partially, or not at all.
  final MemorizationCoverageType type;

  /// First memorized ayah (inclusive). Only meaningful when [type] is [MemorizationCoverageType.partial].
  final int? fromAyah;

  /// Last memorized ayah (inclusive). Only meaningful when [type] is [MemorizationCoverageType.partial].
  final int? toAyah;

  @override
  List<Object?> get props => [surahNumber, segmentStart, segmentEnd, type, fromAyah, toAyah];
}

/// A previously memorized juz (stored as one logical unit).
///
/// When [customizedCoverage] is null, the entire Juz is memorized.
/// When provided, only segments with [MemorizationCoverageType.full] or
/// [MemorizationCoverageType.partial] produce [QuranRange] objects.
class PreviousJuzEntry extends PreviousMemorizationDraftEntry {
  const PreviousJuzEntry({
    required super.id,
    required this.juzNumber,
    this.customizedCoverage,
  });

  final int juzNumber;

  /// Per-surah coverage customization. Null means full Juz.
  final List<JuzSurahCoverage>? customizedCoverage;

  /// Whether this Juz entry has been customized (some segments marked partial or none).
  bool get isCustomized => customizedCoverage != null;

  @override
  List<Object?> get props => [id, juzNumber, customizedCoverage];
}

/// Coverage detail for a surah inside a [PreviousBulkSurahEntry].
class SurahCoverage extends Equatable {
  const SurahCoverage({
    required this.surahNumber,
    required this.type,
    this.fromAyah,
    this.toAyah,
  });

  final int surahNumber;
  final MemorizationCoverageType type;

  /// First memorized ayah (inclusive). Only meaningful when [type] is [MemorizationCoverageType.partial].
  final int? fromAyah;

  /// Last memorized ayah (inclusive). Only meaningful when [type] is [MemorizationCoverageType.partial].
  final int? toAyah;

  @override
  List<Object?> get props => [surahNumber, type, fromAyah, toAyah];
}

/// Multiple surahs added together as a single entry.
///
/// Used for the bulk-select UX. Each surah in [surahCoverages] can be
/// fully or partially memorized.
class PreviousBulkSurahEntry extends PreviousMemorizationDraftEntry {
  const PreviousBulkSurahEntry({
    required super.id,
    required this.surahCoverages,
  });

  /// List of surah coverages.
  final List<SurahCoverage> surahCoverages;

  @override
  List<Object?> get props => [id, surahCoverages];
}
