import 'package:equatable/equatable.dart';
import '../../../core/constants/quran_metadata.dart';

import 'quran_position.dart';

/// A contiguous range of Quran content within a SINGLE surah.
///
/// Used to represent previously memorized content that can serve as a
/// review baseline. This is ALWAYS explicit — it is never inferred
/// from [startPosition] or any other field.
class QuranRange extends Equatable {
  QuranRange({
    required this.from,
    required this.to,
  }) : assert(from.surahNumber == to.surahNumber, 'QuranRange must be within a single surah');

  /// The first ayah in the range (inclusive).
  final QuranPosition from;

  /// The last ayah in the range (inclusive).
  final QuranPosition to;

  /// Returns true if this range represents the entire surah.
  bool get isFullSurah =>
      from.ayahNumber == 1 && to.ayahNumber == QuranMetadata.getAyahCount(from.surahNumber);

  /// Returns true if this range overlaps with [other] within the same surah.
  bool overlapsWith(QuranRange other) {
    if (from.surahNumber != other.from.surahNumber) return false;
    return from.ayahNumber <= other.to.ayahNumber && to.ayahNumber >= other.from.ayahNumber;
  }

  /// Returns a beautiful Arabic label for the range.
  /// Example: "الفاتحة (كاملة)" or "البقرة (الآيات 1–57)"
  String formatArabic() {
    final surahName = QuranMetadata.getSurahName(from.surahNumber);
    if (isFullSurah) {
      return '$surahName (كاملة)';
    }
    return '$surahName (الآيات ${from.ayahNumber}–${to.ayahNumber})';
  }

  @override
  List<Object?> get props => [from, to];

  Map<String, dynamic> toMap() => {
        'from': from.toMap(),
        'to': to.toMap(),
      };

  factory QuranRange.fromMap(Map<String, dynamic> map) => QuranRange(
        from: QuranPosition.fromMap(map['from'] as Map<String, dynamic>),
        to: QuranPosition.fromMap(map['to'] as Map<String, dynamic>),
      );

  @override
  String toString() => 'QuranRange(from: $from, to: $to)';
}
