import '../../features/plan/domain/quran_position.dart';
import '../../features/plan/domain/quran_range.dart';
import 'quran_metadata.dart';

/// Metadata for the 30 Juz of the Quran.
class JuzInfo {
  const JuzInfo({
    required this.juzNumber,
    required this.start,
    required this.end,
  });

  final int juzNumber;
  final QuranPosition start;
  final QuranPosition end;

  /// Returns a list of [QuranRange] entries that cover this Juz.
  /// Splits the Juz across surah boundaries to maintain single-surah invariant.
  List<QuranRange> getRanges() {
    final ranges = <QuranRange>[];

    if (start.surahNumber == end.surahNumber) {
      ranges.add(QuranRange(from: start, to: end));
    } else {
      // 1. First surah part
      ranges.add(QuranRange(
        from: start,
        to: QuranPosition(
          surahNumber: start.surahNumber,
          ayahNumber: QuranMetadata.getAyahCount(start.surahNumber),
        ),
      ));

      // 2. Intermediate full surahs
      for (int s = start.surahNumber + 1; s < end.surahNumber; s++) {
        ranges.add(QuranRange(
          from: QuranPosition(surahNumber: s, ayahNumber: 1),
          to: QuranPosition(surahNumber: s, ayahNumber: QuranMetadata.getAyahCount(s)),
        ));
      }

      // 3. Last surah part
      ranges.add(QuranRange(
        from: QuranPosition(surahNumber: end.surahNumber, ayahNumber: 1),
        to: end,
      ));
    }

    return ranges;
  }
  
  /// Returns a display boundary subtitle.
  /// Example: "من البقرة 142 إلى البقرة 252"
  String formatBoundary() {
    final startSurah = QuranMetadata.getSurahName(start.surahNumber);
    final endSurah = QuranMetadata.getSurahName(end.surahNumber);
    return 'من $startSurah ${start.ayahNumber} إلى $endSurah ${end.ayahNumber}';
  }
}

class JuzMetadata {
  const JuzMetadata._();

  static const List<JuzInfo> juzList = [
    JuzInfo(juzNumber: 1, start: QuranPosition(surahNumber: 1, ayahNumber: 1), end: QuranPosition(surahNumber: 2, ayahNumber: 141)),
    JuzInfo(juzNumber: 2, start: QuranPosition(surahNumber: 2, ayahNumber: 142), end: QuranPosition(surahNumber: 2, ayahNumber: 252)),
    JuzInfo(juzNumber: 3, start: QuranPosition(surahNumber: 2, ayahNumber: 253), end: QuranPosition(surahNumber: 3, ayahNumber: 92)),
    JuzInfo(juzNumber: 4, start: QuranPosition(surahNumber: 3, ayahNumber: 93), end: QuranPosition(surahNumber: 4, ayahNumber: 23)),
    JuzInfo(juzNumber: 5, start: QuranPosition(surahNumber: 4, ayahNumber: 24), end: QuranPosition(surahNumber: 4, ayahNumber: 147)),
    JuzInfo(juzNumber: 6, start: QuranPosition(surahNumber: 4, ayahNumber: 148), end: QuranPosition(surahNumber: 5, ayahNumber: 81)),
    JuzInfo(juzNumber: 7, start: QuranPosition(surahNumber: 5, ayahNumber: 82), end: QuranPosition(surahNumber: 6, ayahNumber: 110)),
    JuzInfo(juzNumber: 8, start: QuranPosition(surahNumber: 6, ayahNumber: 111), end: QuranPosition(surahNumber: 7, ayahNumber: 87)),
    JuzInfo(juzNumber: 9, start: QuranPosition(surahNumber: 7, ayahNumber: 88), end: QuranPosition(surahNumber: 8, ayahNumber: 40)),
    JuzInfo(juzNumber: 10, start: QuranPosition(surahNumber: 8, ayahNumber: 41), end: QuranPosition(surahNumber: 9, ayahNumber: 92)),
    JuzInfo(juzNumber: 11, start: QuranPosition(surahNumber: 9, ayahNumber: 93), end: QuranPosition(surahNumber: 11, ayahNumber: 5)),
    JuzInfo(juzNumber: 12, start: QuranPosition(surahNumber: 11, ayahNumber: 6), end: QuranPosition(surahNumber: 12, ayahNumber: 52)),
    JuzInfo(juzNumber: 13, start: QuranPosition(surahNumber: 12, ayahNumber: 53), end: QuranPosition(surahNumber: 14, ayahNumber: 52)),
    JuzInfo(juzNumber: 14, start: QuranPosition(surahNumber: 15, ayahNumber: 1), end: QuranPosition(surahNumber: 16, ayahNumber: 128)),
    JuzInfo(juzNumber: 15, start: QuranPosition(surahNumber: 17, ayahNumber: 1), end: QuranPosition(surahNumber: 18, ayahNumber: 74)),
    JuzInfo(juzNumber: 16, start: QuranPosition(surahNumber: 18, ayahNumber: 75), end: QuranPosition(surahNumber: 20, ayahNumber: 135)),
    JuzInfo(juzNumber: 17, start: QuranPosition(surahNumber: 21, ayahNumber: 1), end: QuranPosition(surahNumber: 22, ayahNumber: 78)),
    JuzInfo(juzNumber: 18, start: QuranPosition(surahNumber: 23, ayahNumber: 1), end: QuranPosition(surahNumber: 24, ayahNumber: 64)),
    JuzInfo(juzNumber: 19, start: QuranPosition(surahNumber: 25, ayahNumber: 1), end: QuranPosition(surahNumber: 27, ayahNumber: 55)),
    JuzInfo(juzNumber: 20, start: QuranPosition(surahNumber: 27, ayahNumber: 56), end: QuranPosition(surahNumber: 29, ayahNumber: 45)),
    JuzInfo(juzNumber: 21, start: QuranPosition(surahNumber: 29, ayahNumber: 46), end: QuranPosition(surahNumber: 33, ayahNumber: 30)),
    JuzInfo(juzNumber: 22, start: QuranPosition(surahNumber: 33, ayahNumber: 31), end: QuranPosition(surahNumber: 36, ayahNumber: 27)),
    JuzInfo(juzNumber: 23, start: QuranPosition(surahNumber: 36, ayahNumber: 28), end: QuranPosition(surahNumber: 39, ayahNumber: 31)),
    JuzInfo(juzNumber: 24, start: QuranPosition(surahNumber: 39, ayahNumber: 32), end: QuranPosition(surahNumber: 41, ayahNumber: 46)),
    JuzInfo(juzNumber: 25, start: QuranPosition(surahNumber: 41, ayahNumber: 47), end: QuranPosition(surahNumber: 45, ayahNumber: 37)),
    JuzInfo(juzNumber: 26, start: QuranPosition(surahNumber: 46, ayahNumber: 1), end: QuranPosition(surahNumber: 51, ayahNumber: 30)),
    JuzInfo(juzNumber: 27, start: QuranPosition(surahNumber: 51, ayahNumber: 31), end: QuranPosition(surahNumber: 57, ayahNumber: 29)),
    JuzInfo(juzNumber: 28, start: QuranPosition(surahNumber: 58, ayahNumber: 1), end: QuranPosition(surahNumber: 66, ayahNumber: 12)),
    JuzInfo(juzNumber: 29, start: QuranPosition(surahNumber: 67, ayahNumber: 1), end: QuranPosition(surahNumber: 77, ayahNumber: 50)),
    JuzInfo(juzNumber: 30, start: QuranPosition(surahNumber: 78, ayahNumber: 1), end: QuranPosition(surahNumber: 114, ayahNumber: 6)),
  ];

  static JuzInfo getByNumber(int number) => juzList[number - 1];
}
