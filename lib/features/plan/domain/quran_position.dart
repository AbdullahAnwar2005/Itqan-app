import 'package:equatable/equatable.dart';

/// Represents a specific point in the Quran by surah and ayah number.
class QuranPosition extends Equatable {
  const QuranPosition({
    required this.surahNumber,
    required this.ayahNumber,
  });

  final int surahNumber;
  final int ayahNumber;

  @override
  List<Object?> get props => [surahNumber, ayahNumber];

  @override
  String toString() => 'Surah $surahNumber, Ayah $ayahNumber';
}
