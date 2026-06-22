import 'package:drift/drift.dart';

/// Database table for storing session execution logs and quality signals.
class SessionLogs extends Table {
  TextColumn get id => text()();
  TextColumn get assignmentId => text()();
  TextColumn get planId => text()();
  TextColumn get sessionType => text()();
  
  IntColumn get startSurah => integer().nullable()();
  IntColumn get startAyah => integer().nullable()();
  IntColumn get endSurah => integer().nullable()();
  IntColumn get endAyah => integer().nullable()();
  
  TextColumn get rating => text()();
  
  DateTimeColumn get completedAt => dateTime()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
