import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/juz_metadata.dart';
import '../../../core/constants/quran_metadata.dart';
import '../../plan/domain/quran_position.dart';
import '../../plan/domain/quran_range.dart';
import 'previous_memorization_draft_entry.dart';

/// Thrown when a new range overlaps with an existing memorized range.
class RangeOverlapException implements Exception {
  const RangeOverlapException();
  @override
  String toString() => 'هذا الجزء مضاف مسبقًا أو يتداخل مع جزء محفوظ لديك';
}

/// Thrown when a range's start is after its end.
class InvalidRangeException implements Exception {
  const InvalidRangeException();
  @override
  String toString() => 'نهاية الآيات يجب أن تكون بعد بدايتها';
}

/// Thrown when a partial range is outside the allowed segment bounds.
class OutOfBoundsException implements Exception {
  const OutOfBoundsException();
  @override
  String toString() => 'الآيات المحددة خارج نطاق الجزء المسموح';
}

class PreviousMemorizationService {
  // ── Range derivation from draft entries ───────────────────────────────────

  /// Derives canonical [QuranRange] list from a single draft entry.
  List<QuranRange> rangesFromEntry(PreviousMemorizationDraftEntry entry) {
    return switch (entry) {
      PreviousSurahEntry() => _rangesFromSurahEntry(entry),
      PreviousJuzEntry() => _rangesFromJuzEntry(entry),
      PreviousBulkSurahEntry() => _rangesFromBulkSurahEntry(entry),
    };
  }

  /// Derives canonical [QuranRange] list from all draft entries.
  List<QuranRange> rangesFromEntries(List<PreviousMemorizationDraftEntry> entries) {
    final ranges = entries.expand((e) => rangesFromEntry(e)).toList();
    return normalizeAndSortRanges(ranges);
  }

  List<QuranRange> _rangesFromSurahEntry(PreviousSurahEntry entry) {
    final int startAyah;
    final int endAyah;
    if (entry.isWholeSurah) {
      startAyah = 1;
      endAyah = QuranMetadata.getAyahCount(entry.surahNumber);
    } else {
      startAyah = entry.fromAyah ?? 1;
      endAyah = entry.toAyah ?? QuranMetadata.getAyahCount(entry.surahNumber);
    }
    return [
      QuranRange(
        from: QuranPosition(surahNumber: entry.surahNumber, ayahNumber: startAyah),
        to: QuranPosition(surahNumber: entry.surahNumber, ayahNumber: endAyah),
      ),
    ];
  }

  List<QuranRange> _rangesFromJuzEntry(PreviousJuzEntry entry) {
    final coverage = entry.customizedCoverage;
    if (coverage == null) {
      // Full Juz — delegate to JuzMetadata
      return JuzMetadata.getByNumber(entry.juzNumber).getRanges();
    }

    // Customized — derive ranges per segment based on coverage type
    final ranges = <QuranRange>[];
    for (final seg in coverage) {
      switch (seg.type) {
        case MemorizationCoverageType.full:
          ranges.add(QuranRange(from: seg.segmentStart, to: seg.segmentEnd));
        case MemorizationCoverageType.partial:
          final from = seg.fromAyah ?? seg.segmentStart.ayahNumber;
          final to = seg.toAyah ?? seg.segmentEnd.ayahNumber;
          ranges.add(QuranRange(
            from: QuranPosition(surahNumber: seg.surahNumber, ayahNumber: from),
            to: QuranPosition(surahNumber: seg.surahNumber, ayahNumber: to),
          ));
        case MemorizationCoverageType.none:
          // No range produced
          break;
      }
    }
    return ranges;
  }

  List<QuranRange> _rangesFromBulkSurahEntry(PreviousBulkSurahEntry entry) {
    final ranges = <QuranRange>[];
    for (final coverage in entry.surahCoverages) {
      switch (coverage.type) {
        case MemorizationCoverageType.full:
          final totalAyahs = QuranMetadata.getAyahCount(coverage.surahNumber);
          ranges.add(QuranRange(
            from: QuranPosition(surahNumber: coverage.surahNumber, ayahNumber: 1),
            to: QuranPosition(surahNumber: coverage.surahNumber, ayahNumber: totalAyahs),
          ));
        case MemorizationCoverageType.partial:
          final from = coverage.fromAyah ?? 1;
          final to = coverage.toAyah ?? QuranMetadata.getAyahCount(coverage.surahNumber);
          ranges.add(QuranRange(
            from: QuranPosition(surahNumber: coverage.surahNumber, ayahNumber: from),
            to: QuranPosition(surahNumber: coverage.surahNumber, ayahNumber: to),
          ));
        case MemorizationCoverageType.none:
          break;
      }
    }
    return ranges;
  }

  // ── Juz segment utilities ────────────────────────────────────────────────


  /// Builds the default (all-full) coverage list for a Juz.
  ///
  /// Each item corresponds to one surah segment within the Juz.
  List<JuzSurahCoverage> buildDefaultCoverage(int juzNumber) {
    final juz = JuzMetadata.getByNumber(juzNumber);
    final ranges = juz.getRanges();
    return ranges.map((r) => JuzSurahCoverage(
      surahNumber: r.from.surahNumber,
      segmentStart: r.from,
      segmentEnd: r.to,
      type: MemorizationCoverageType.full,
    )).toList();
  }

  /// Validates that all partial coverage entries have valid ayah bounds.
  void validateCoverage(List<JuzSurahCoverage> coverage) {
    for (final seg in coverage) {
      if (seg.type == MemorizationCoverageType.partial) {
        final from = seg.fromAyah;
        final to = seg.toAyah;
        if (from == null || to == null) {
          throw const InvalidRangeException();
        }
        if (to < from) {
          throw const InvalidRangeException();
        }
        // Must be within segment bounds
        if (from < seg.segmentStart.ayahNumber || to > seg.segmentEnd.ayahNumber) {
          throw const OutOfBoundsException();
        }
      }
    }
  }

  /// Validates that all partial coverage entries have valid ayah bounds.
  void validateSurahCoverage(List<SurahCoverage> coverage) {
    for (final seg in coverage) {
      if (seg.type == MemorizationCoverageType.partial) {
        final from = seg.fromAyah;
        final to = seg.toAyah;
        if (from == null || to == null) {
          throw const InvalidRangeException();
        }
        if (to < from) {
          throw const InvalidRangeException();
        }
        final totalAyahs = QuranMetadata.getAyahCount(seg.surahNumber);
        if (from < 1 || to > totalAyahs) {
          throw const OutOfBoundsException();
        }
      }
    }
  }

  // ── Validation ────────────────────────────────────────────────────────────

  /// Validates a partial-surah ayah range.
  void validateRange(int fromAyah, int toAyah) {
    if (toAyah < fromAyah) {
      throw const InvalidRangeException();
    }
  }

  /// Validates that a new entry does not overlap with any existing entries.
  void validateEntryNoOverlap(
    List<PreviousMemorizationDraftEntry> existingEntries,
    PreviousMemorizationDraftEntry newEntry,
  ) {
    final existingRanges = rangesFromEntries(existingEntries);
    final newRanges = rangesFromEntry(newEntry);

    for (final newRange in newRanges) {
      final overlaps = existingRanges.any((r) => r.overlapsWith(newRange));
      if (overlaps) {
        throw const RangeOverlapException();
      }
    }
  }

  /// Validates that an updated entry does not overlap with other entries
  /// (excluding the entry being updated, identified by [entryId]).
  void validateEntryNoOverlapExcluding(
    List<PreviousMemorizationDraftEntry> allEntries,
    String entryId,
    PreviousMemorizationDraftEntry updatedEntry,
  ) {
    final otherEntries = allEntries.where((e) => e.id != entryId).toList();
    validateEntryNoOverlap(otherEntries, updatedEntry);
  }

  // ── Utilities ─────────────────────────────────────────────────────────────

  /// Normalizes and sorts ranges in Quran order.
  List<QuranRange> normalizeAndSortRanges(List<QuranRange> ranges) {
    final sorted = List<QuranRange>.from(ranges);
    sorted.sort((a, b) => a.from.compareTo(b.from));
    return sorted;
  }

  /// Calculates suggested start position based on provided ranges.
  QuranPosition suggestStartPosition(List<QuranRange> ranges) {
    if (ranges.isEmpty) return const QuranPosition(surahNumber: 1, ayahNumber: 1);

    // Find the latest range in Quran order
    QuranPosition latestEnd = ranges.first.to;
    for (final range in ranges) {
      if (range.to.surahNumber > latestEnd.surahNumber ||
          (range.to.surahNumber == latestEnd.surahNumber &&
              range.to.ayahNumber > latestEnd.ayahNumber)) {
        latestEnd = range.to;
      }
    }
    return _nextPosition(latestEnd);
  }

  QuranPosition _nextPosition(QuranPosition current) {
    final ayahsInSurah = QuranMetadata.getAyahCount(current.surahNumber);
    if (current.ayahNumber < ayahsInSurah) {
      return QuranPosition(
        surahNumber: current.surahNumber,
        ayahNumber: current.ayahNumber + 1,
      );
    }
    if (current.surahNumber < 114) {
      return QuranPosition(
        surahNumber: current.surahNumber + 1,
        ayahNumber: 1,
      );
    }
    return current; // End of Quran
  }

  // ── Availability checks ──────────────────────────────────────────────────

  /// Determines how much of a Juz is already covered by existing entries.
  MemorizationAvailabilityInfo getJuzAvailability({
    required int juzNumber,
    required List<PreviousMemorizationDraftEntry> entries,
  }) {
    final juzRanges = JuzMetadata.getByNumber(juzNumber).getRanges();
    return _computeAvailability(juzRanges, rangesFromEntries(entries));
  }

  /// Determines how much of a Surah is already covered by existing entries.
  MemorizationAvailabilityInfo getSurahAvailability({
    required int surahNumber,
    required List<PreviousMemorizationDraftEntry> entries,
  }) {
    final totalAyahs = QuranMetadata.getAyahCount(surahNumber);
    final surahRange = QuranRange(
      from: QuranPosition(surahNumber: surahNumber, ayahNumber: 1),
      to: QuranPosition(surahNumber: surahNumber, ayahNumber: totalAyahs),
    );
    return _computeAvailability([surahRange], rangesFromEntries(entries));
  }

  /// Computes availability by counting how many ayahs from [targetRanges]
  /// are covered by [existingRanges].
  MemorizationAvailabilityInfo _computeAvailability(
    List<QuranRange> targetRanges,
    List<QuranRange> existingRanges,
  ) {
    int totalAyahs = 0;
    int coveredAyahs = 0;

    for (final target in targetRanges) {
      final surah = target.from.surahNumber;
      final tFrom = target.from.ayahNumber;
      final tTo = target.to.ayahNumber;
      totalAyahs += tTo - tFrom + 1;

      // Collect existing ranges for this surah
      final sameSuprah = existingRanges
          .where((r) => r.from.surahNumber == surah)
          .toList();

      for (int ayah = tFrom; ayah <= tTo; ayah++) {
        final isCovered = sameSuprah.any(
          (r) => ayah >= r.from.ayahNumber && ayah <= r.to.ayahNumber,
        );
        if (isCovered) coveredAyahs++;
      }
    }

    if (totalAyahs == 0) {
      return const MemorizationAvailabilityInfo(
        status: MemorizationAvailability.available,
      );
    }

    if (coveredAyahs == 0) {
      return const MemorizationAvailabilityInfo(
        status: MemorizationAvailability.available,
      );
    }

    if (coveredAyahs >= totalAyahs) {
      return const MemorizationAvailabilityInfo(
        status: MemorizationAvailability.fullyCovered,
        message: 'مضاف مسبقًا',
      );
    }

    return const MemorizationAvailabilityInfo(
      status: MemorizationAvailability.partiallyCovered,
      message: 'مضاف جزئيًا',
    );
  }
}

final previousMemorizationServiceProvider = Provider<PreviousMemorizationService>((ref) {
  return PreviousMemorizationService();
});

/// Availability status for a Juz or Surah relative to existing entries.
enum MemorizationAvailability {
  /// Not covered by any existing entry.
  available,

  /// Some ayahs are covered but not all.
  partiallyCovered,

  /// Every ayah is already covered.
  fullyCovered,
}

/// Availability status with an optional Arabic display message.
class MemorizationAvailabilityInfo {
  const MemorizationAvailabilityInfo({
    required this.status,
    this.message,
  });

  final MemorizationAvailability status;
  final String? message;
}
