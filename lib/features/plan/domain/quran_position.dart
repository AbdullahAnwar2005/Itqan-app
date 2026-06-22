import 'package:equatable/equatable.dart';

/// Represents a specific point in the Quran by surah and ayah number.
class QuranPosition extends Equatable implements Comparable<QuranPosition> {
  const QuranPosition({
    required this.surahNumber,
    required this.ayahNumber,
  });

  final int surahNumber;
  final int ayahNumber;

  @override
  int compareTo(QuranPosition other) {
    if (surahNumber != other.surahNumber) {
      return surahNumber.compareTo(other.surahNumber);
    }
    return ayahNumber.compareTo(other.ayahNumber);
  }

  bool isBefore(QuranPosition other) => compareTo(other) < 0;
  bool isAfter(QuranPosition other) => compareTo(other) > 0;
  bool isAtOrBefore(QuranPosition other) => compareTo(other) <= 0;
  bool isAtOrAfter(QuranPosition other) => compareTo(other) >= 0;

  @override
  List<Object?> get props => [surahNumber, ayahNumber];

  QuranPosition copyWith({
    int? surahNumber,
    int? ayahNumber,
  }) {
    return QuranPosition(
      surahNumber: surahNumber ?? this.surahNumber,
      ayahNumber: ayahNumber ?? this.ayahNumber,
    );
  }

  Map<String, dynamic> toMap() => {
        'surahNumber': surahNumber,
        'ayahNumber': ayahNumber,
      };

  factory QuranPosition.fromMap(Map<String, dynamic> map) => QuranPosition(
        surahNumber: map['surahNumber'] as int,
        ayahNumber: map['ayahNumber'] as int,
      );

  @override
  String toString() => 'Surah $surahNumber, Ayah $ayahNumber';
}
