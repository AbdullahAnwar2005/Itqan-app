import 'package:drift/drift.dart';

/// Represents the user's currently active memorization/review plan.
class ActivePlans extends Table {
  TextColumn get id => text()();

  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  TextColumn get status => text()(); // mapped to PlanStatus enum centrally

  RealColumn get memorizationAmount => real()();

  TextColumn get memorizationUnit => text()();

  RealColumn get reviewAmount => real()();

  TextColumn get reviewUnit => text()();

  IntColumn get memorizationStartSurah => integer()();

  IntColumn get memorizationStartAyah => integer()();

  IntColumn get currentMemorizationSurah => integer()();

  IntColumn get currentMemorizationAyah => integer()();

  @override
  Set<Column> get primaryKey => {id};
}
