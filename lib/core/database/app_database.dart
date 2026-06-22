import 'dart:convert';
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:itqan/core/database/tables/active_plans_table.dart';
import 'package:itqan/core/database/tables/day_assignments_table.dart';
import 'package:itqan/core/database/tables/session_logs_table.dart';
import 'package:itqan/core/database/tables/quran_segment_progresses_table.dart';
import 'package:itqan/core/database/tables/previous_memorized_ranges_table.dart';
import 'package:itqan/core/database/tables/today_adjustments_table.dart';
import 'package:itqan/core/database/tables/recovery_resolutions_table.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'app_database.g.dart';

@DriftDatabase(tables: [ActivePlans, DayAssignments, SessionLogs, QuranSegmentProgresses, PreviousMemorizedRanges, TodayAdjustments, RecoveryResolutions])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());
  AppDatabase.forTesting(super.e);

  @override
  int get schemaVersion => 9;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
        },
        onUpgrade: (m, from, to) async {
          if (from < 2) {
            await m.addColumn(activePlans, activePlans.memorizationDays);
            await m.addColumn(activePlans, activePlans.reviewSchedule);
            await m.addColumn(activePlans, activePlans.customReviewDays);
            await m.addColumn(activePlans, activePlans.previousMemorizedRanges);
            await m.addColumn(dayAssignments, dayAssignments.hasMemoTask);
            await m.addColumn(dayAssignments, dayAssignments.hasReviewTask);
          }
          if (from < 3) {
            // Schema v3: Multiple previous ranges stored as JSON.
            // 1. Add the new JSON column.
            await m.addColumn(activePlans, activePlans.previousMemorizedRanges);

            // 2. Data migration from old columns to JSON.
            // We use a custom statement to select the old columns and update the new one.
            final allPlans = await select(activePlans).get();
            for (final plan in allPlans) {
              // We need to access the old columns that are no longer in the generated class.
              // Drift provides 'customSelect' for this.
              final row = await customSelect(
                'SELECT previous_range_from_surah, previous_range_from_ayah, '
                'previous_range_to_surah, previous_range_to_ayah FROM active_plans WHERE id = ?',
                variables: [Variable.withString(plan.id)],
              ).getSingleOrNull();

              if (row != null) {
                final fromSurah = row.readNullable<int>('previous_range_from_surah');
                final fromAyah = row.readNullable<int>('previous_range_from_ayah');
                final toSurah = row.readNullable<int>('previous_range_to_surah');
                final toAyah = row.readNullable<int>('previous_range_to_ayah');

                if (fromSurah != null && fromAyah != null && toSurah != null && toAyah != null) {
                  final rangeJson = jsonEncode([
                    {
                      'from': {'surahNumber': fromSurah, 'ayahNumber': fromAyah},
                      'to': {'surahNumber': toSurah, 'ayahNumber': toAyah}
                    }
                  ]);
                  await (update(activePlans)..where((t) => t.id.equals(plan.id)))
                      .write(ActivePlansCompanion(previousMemorizedRanges: Value(rangeJson)));
                }
              }
            }
          }
          if (from < 4) {
            await m.createTable(sessionLogs);
          }
          if (from < 5) {
            await m.createTable(quranSegmentProgresses);
          }
          if (from < 6) {
            await m.createTable(previousMemorizedRanges);
          }
          if (from < 7) {
            await m.addColumn(quranSegmentProgresses, quranSegmentProgresses.source);
          }
          if (from < 8) {
            await m.createTable(todayAdjustments);
          }
          if (from < 9) {
            await m.createTable(recoveryResolutions);
          }
        },
      );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'itqan.sqlite'));
    return NativeDatabase(file);
  });
}
