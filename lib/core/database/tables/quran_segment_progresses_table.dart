import 'package:drift/drift.dart';

/// Database table for tracking the mastery state of specific Quran segments.
class QuranSegmentProgresses extends Table {
  TextColumn get id => text()();
  TextColumn get planId => text()();
  IntColumn get startSurah => integer()();
  IntColumn get startAyah => integer()();
  IntColumn get endSurah => integer()();
  IntColumn get endAyah => integer()();
  
  TextColumn get status => text()();
  IntColumn get masteryScore => integer()();
  TextColumn get lastRating => text()();
  
  DateTimeColumn get lastPracticedAt => dateTime()();
  DateTimeColumn get nextReviewAt => dateTime()();
  TextColumn get source => text().withDefault(const Constant('appMemorization'))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<Set<Column>> get uniqueKeys => [
        {planId, startSurah, startAyah, endSurah, endAyah}
      ];
}
