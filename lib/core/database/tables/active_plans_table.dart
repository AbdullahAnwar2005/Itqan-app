import 'package:drift/drift.dart';

/// Represents the user's currently active memorization/review plan.
class ActivePlans extends Table {
  TextColumn get id => text()();

  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  TextColumn get status => text()();

  RealColumn get memorizationAmount => real()();
  TextColumn get memorizationUnit => text()();

  RealColumn get reviewAmount => real()();
  TextColumn get reviewUnit => text()();

  IntColumn get memorizationStartSurah => integer()();
  IntColumn get memorizationStartAyah => integer()();

  IntColumn get currentMemorizationSurah => integer()();
  IntColumn get currentMemorizationAyah => integer()();

  // --- Schedule fields (added in schema v2) ---

  /// Comma-separated weekday ints (1=Mon … 7=Sun). e.g. "1,2,3,4,5"
  TextColumn get memorizationDays =>
      text().withDefault(const Constant('1,2,3,4,5'))();

  /// Persistence key of [ReviewSchedule] enum.
  TextColumn get reviewSchedule =>
      text().withDefault(const Constant('everyday'))();

  /// Comma-separated custom review days. Empty string if not custom.
  TextColumn get customReviewDays => text().withDefault(const Constant(''))();

  // --- Previous memorized ranges (added in schema v3) ---
  // Stores JSON-encoded List<QuranRange>. Defaults to empty list "[]".
  TextColumn get previousMemorizedRanges =>
      text().withDefault(const Constant('[]'))();

  @override
  Set<Column> get primaryKey => {id};
}
