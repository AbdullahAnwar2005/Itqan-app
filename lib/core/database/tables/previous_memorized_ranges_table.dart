import 'package:drift/drift.dart';

@DataClassName('PreviousMemorizedRangeEntity')
class PreviousMemorizedRanges extends Table {
  TextColumn get id => text()();
  TextColumn get planId => text()();
  IntColumn get startSurah => integer()();
  IntColumn get startAyah => integer()();
  IntColumn get endSurah => integer()();
  IntColumn get endAyah => integer()();
  TextColumn get source => text()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
  
  @override
  List<Set<Column>> get uniqueKeys => [];
}
