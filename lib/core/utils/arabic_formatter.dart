import '../../features/setup/domain/user_setup.dart';
import '../../features/plan/domain/quran_position.dart';
import '../constants/quran_metadata.dart';

/// A utility class to format daily targets into natural Arabic strings.
/// 
/// Handles singular, dual, and plural forms for Quran-related units.
class ArabicFormatter {
  const ArabicFormatter._();

  /// Formats a [DailyTarget] into a product-clean Arabic string.
  static String formatTarget(DailyTarget target) {
    final amount = target.amount;
    final unit = target.unit;

    // Handle special case: 0.5 (Half)
    if (amount == 0.5) {
      return switch (unit) {
        ProgressUnit.ayah => 'نصف آية',
        ProgressUnit.page => 'نصف صفحة',
        ProgressUnit.hizb => 'نصف حزب',
        ProgressUnit.juz => 'نصف جزء',
      };
    }

    // Handle integers
    final count = amount.toInt();
    
    // Fallback for non-integer, non-0.5 values (though unlikely in current scope)
    if (amount != count.toDouble()) {
      return '$amount ${unit.label}';
    }

    return switch (unit) {
      ProgressUnit.ayah => _formatAyah(count),
      ProgressUnit.page => _formatPage(count),
      ProgressUnit.hizb => _formatHizb(count),
      ProgressUnit.juz => _formatJuz(count),
    };
  }
  
  /// Formats a [QuranPosition] (e.g., "سورة البقرة، آية 5").
  static String formatPosition(QuranPosition position) {
    final surahName = QuranMetadata.getSurahName(position.surahNumber);
    return '$surahName، آية ${position.ayahNumber}';
  }

  /// Formats a range of positions (e.g., "من الفاتحة، آية 1 إلى الفاتحة، آية 5").
  static String formatRange(QuranPosition start, QuranPosition end) {
    final startStr = formatPosition(start);
    final endStr = formatPosition(end);

    if (start.surahNumber == end.surahNumber) {
      if (start.ayahNumber == end.ayahNumber) return startStr;
      final surahName = QuranMetadata.getSurahName(start.surahNumber);
      return '$surahName: آية ${start.ayahNumber} - ${end.ayahNumber}';
    }

    return 'من $startStr إلى $endStr';
  }

  /// Formats a count of days into proper Arabic (e.g., "يوم واحد", "يومان", "5 أيام").
  static String formatDays(int count) {
    if (count == 0) return '0 يوم';
    if (count == 1) return 'يوم واحد';
    if (count == 2) return 'يومان';
    if (count >= 3 && count <= 10) return '$count أيام';
    return '$count يومًا';
  }

  static String _formatAyah(int count) {
    if (count == 1) return 'آية واحدة';
    if (count == 2) return 'آيتان';
    if (count >= 3 && count <= 10) return '$count آيات';
    return '$count آية';
  }

  static String _formatPage(int count) {
    if (count == 1) return 'صفحة واحدة';
    if (count == 2) return 'صفحتان';
    if (count >= 3 && count <= 10) return '$count صفحات';
    return '$count صفحة';
  }

  static String _formatHizb(int count) {
    if (count == 1) return 'حزب واحد';
    if (count == 2) return 'حزبان';
    if (count >= 3 && count <= 10) return '$count أحزاب';
    return '$count حزب';
  }

  static String _formatJuz(int count) {
    if (count == 1) return 'جزء واحد';
    if (count == 2) return 'جزآن';
    if (count >= 3 && count <= 10) return '$count أجزاء';
    return '$count جزء';
  }
}

extension ProgressUnitX on ProgressUnit {
  String get label {
    return switch (this) {
      ProgressUnit.ayah => 'آية',
      ProgressUnit.page => 'صفحة',
      ProgressUnit.hizb => 'حزب',
      ProgressUnit.juz => 'جزء',
    };
  }
}
