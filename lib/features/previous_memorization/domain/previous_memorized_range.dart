import 'package:equatable/equatable.dart';

enum PreviousMemorizationSource {
  manual,
  surahShortcut,
  juzShortcut,
  setupImport;

  String get persistenceKey => name;

  static PreviousMemorizationSource fromKey(String key) {
    return PreviousMemorizationSource.values.firstWhere(
      (e) => e.persistenceKey == key,
      orElse: () => PreviousMemorizationSource.manual,
    );
  }
}

class PreviousMemorizedRange extends Equatable {
  const PreviousMemorizedRange({
    required this.id,
    required this.planId,
    required this.startSurah,
    required this.startAyah,
    required this.endSurah,
    required this.endAyah,
    required this.source,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String planId;
  final int startSurah;
  final int startAyah;
  final int endSurah;
  final int endAyah;
  final PreviousMemorizationSource source;
  final DateTime createdAt;
  final DateTime updatedAt;

  @override
  List<Object?> get props => [
        id,
        planId,
        startSurah,
        startAyah,
        endSurah,
        endAyah,
        source,
        createdAt,
        updatedAt,
      ];
}
