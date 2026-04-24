import 'package:drift/drift.dart';
import 'package:itqan/core/database/tables/active_plans_table.dart';

/// Represents the generated daily work for a given plan on a specific day.
class DayAssignments extends Table {
  TextColumn get id => text()();

  TextColumn get planId => text().references(ActivePlans, #id)();

  TextColumn get dateKey => text()(); // local date, format YYYY-MM-DD

  IntColumn get memorizationStartSurah => integer()();

  IntColumn get memorizationStartAyah => integer()();

  IntColumn get memorizationEndSurah => integer()();

  IntColumn get memorizationEndAyah => integer()();

  RealColumn get memorizationAmount => real()();

  TextColumn get memorizationUnit => text()();

  RealColumn get reviewAmount => real()();

  TextColumn get reviewUnit => text()();

  BoolColumn get isMemorizationDone =>
      boolean().withDefault(const Constant(false))();

  BoolColumn get isReviewDone => boolean().withDefault(const Constant(false))();

  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<String> get customConstraints => [
        'UNIQUE (plan_id, date_key)',
      ];
}
