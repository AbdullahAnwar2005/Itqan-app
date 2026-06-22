import '../../../application/previous_memorization_draft_entry.dart';
import '../../../../../core/constants/juz_metadata.dart';
import '../../../../../core/constants/quran_metadata.dart';

/// Presentation-only helper that produces Arabic display labels
/// for [PreviousMemorizationDraftEntry] instances.
///
/// Keeps formatting logic out of the data model.
class DraftEntryFormatter {
  const DraftEntryFormatter._();

  /// Primary label for the entry.
  ///
  /// Examples:
  /// - "سورة الفاتحة"
  /// - "الجزء ١"
  /// - "سور متعددة"
  static String titleForEntry(PreviousMemorizationDraftEntry entry) {
    return switch (entry) {
      PreviousSurahEntry(:final surahNumber) =>
        'سورة ${QuranMetadata.getSurahName(surahNumber)}',
      PreviousJuzEntry(:final juzNumber) =>
        'الجزء $juzNumber',
      PreviousBulkSurahEntry() =>
        'سور متعددة',
    };
  }

  /// Secondary label with detail.
  ///
  /// Examples:
  /// - "كاملة"
  /// - "الآيات 53–111"
  /// - "كامل — من الفاتحة 1 إلى البقرة 141"
  /// - "مخصص: ٥ سور كاملة، ٣ نطاقات جزئية، سورة غير محفوظة"
  /// - "٥ سور كاملة: الإخلاص، الفلق، الناس..."
  static String subtitleForEntry(PreviousMemorizationDraftEntry entry) {
    return switch (entry) {
      PreviousSurahEntry(:final isWholeSurah, :final fromAyah, :final toAyah) =>
        isWholeSurah ? 'كاملة' : 'الآيات $fromAyah–$toAyah',
      PreviousJuzEntry(:final juzNumber, :final customizedCoverage) =>
        customizedCoverage == null
          ? _fullJuzSubtitle(juzNumber)
          : _customizedJuzSubtitle(customizedCoverage),
      PreviousBulkSurahEntry(:final surahCoverages) =>
        _bulkSurahSubtitle(surahCoverages),
    };
  }

  static String _fullJuzSubtitle(int juzNumber) {
    return 'كامل — ${JuzMetadata.getByNumber(juzNumber).formatBoundary()}';
  }

  static String _customizedJuzSubtitle(List<JuzSurahCoverage> coverage) {
    int fullCount = 0;
    int partialCount = 0;
    int noneCount = 0;

    for (final seg in coverage) {
      switch (seg.type) {
        case MemorizationCoverageType.full:
          fullCount++;
        case MemorizationCoverageType.partial:
          partialCount++;
        case MemorizationCoverageType.none:
          noneCount++;
      }
    }

    final parts = <String>[];
    if (fullCount > 0) {
      parts.add('$fullCount ${fullCount == 1 ? 'سورة كاملة' : 'سور كاملة'}');
    }
    if (partialCount > 0) {
      parts.add('$partialCount ${partialCount == 1 ? 'نطاق جزئي' : 'نطاقات جزئية'}');
    }
    if (noneCount > 0) {
      parts.add('$noneCount ${noneCount == 1 ? 'سورة غير محفوظة' : 'سور غير محفوظة'}');
    }

    return 'مخصص: ${parts.join('، ')}';
  }

  static String _bulkSurahSubtitle(List<SurahCoverage> coverages) {
    final active = coverages.where((c) => c.type != MemorizationCoverageType.none).toList();
    final count = active.length;
    
    final fullCount = active.where((c) => c.type == MemorizationCoverageType.full).length;
    final partialCount = active.where((c) => c.type == MemorizationCoverageType.partial).length;

    final String countLabel;
    if (partialCount == 0) {
      countLabel = count == 1 ? 'سورة كاملة' : '$count سور كاملة';
    } else {
      final parts = <String>[];
      if (fullCount > 0) {
        parts.add('$fullCount ${fullCount == 1 ? 'كاملة' : 'كاملة'}');
      }
      if (partialCount > 0) {
        parts.add('$partialCount ${partialCount == 1 ? 'آيات محددة' : 'آيات محددة'}');
      }
      countLabel = '$count محفوظات: ${parts.join('، ')}';
    }

    // Show up to 3 surah names as a preview
    const maxPreview = 3;
    final previewNames = active
        .take(maxPreview)
        .map((c) => QuranMetadata.getSurahName(c.surahNumber))
        .join('، ');

    if (count <= maxPreview) {
      return '$countLabel: $previewNames';
    }
    return '$countLabel، منها: $previewNames...';
  }
}
