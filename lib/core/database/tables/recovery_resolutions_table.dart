import 'package:drift/drift.dart';

@DataClassName('RecoveryResolutionEntity')
class RecoveryResolutions extends Table {
  TextColumn get planId => text()();
  TextColumn get resolvedBeforeDateKey => text()();
  DateTimeColumn get resolvedAt => dateTime()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {planId};
}
