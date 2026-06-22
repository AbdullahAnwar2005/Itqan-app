import 'package:drift/drift.dart';

@DataClassName('TodayAdjustmentEntity')
class TodayAdjustments extends Table {
  TextColumn get planId => text()();
  TextColumn get dateKey => text()();
  BoolColumn get deferMemorization => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {planId, dateKey};
}
