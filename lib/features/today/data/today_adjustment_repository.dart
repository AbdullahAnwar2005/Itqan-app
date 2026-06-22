import 'package:drift/drift.dart' as drift;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:itqan/core/database/app_database.dart';
import 'package:itqan/core/database/database_provider.dart';
import 'package:itqan/features/today/domain/today_adjustment.dart';

final todayAdjustmentRepositoryProvider =
    Provider<TodayAdjustmentRepository>((ref) {
  return TodayAdjustmentRepository(ref.watch(databaseProvider));
});

class TodayAdjustmentRepository {
  final AppDatabase _db;

  TodayAdjustmentRepository(this._db);

  /// Retrieves the today adjustment for the given planId and dateKey.
  /// If no row exists, returns a default model where deferMemorization is false.
  Future<TodayAdjustment> getAdjustment(
      {required String planId, required String dateKey}) async {
    final row = await (_db.select(_db.todayAdjustments)
          ..where((t) => t.planId.equals(planId) & t.dateKey.equals(dateKey)))
        .getSingleOrNull();

    if (row == null) {
      return TodayAdjustment(
        planId: planId,
        dateKey: dateKey,
        deferMemorization: false,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
    }

    return TodayAdjustment(
      planId: row.planId,
      dateKey: row.dateKey,
      deferMemorization: row.deferMemorization,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
    );
  }

  /// Sets or unsets the deferMemorization flag for today.
  /// Preferred behavior:
  /// - If defer == true, insert or update the row.
  /// - If defer == false, delete the row to keep the table clean ("no row = default false").
  Future<void> setDeferMemorization({
    required String planId,
    required String dateKey,
    required bool defer,
  }) async {
    if (defer) {
      final now = DateTime.now();
      await _db.into(_db.todayAdjustments).insertOnConflictUpdate(
            TodayAdjustmentsCompanion.insert(
              planId: planId,
              dateKey: dateKey,
              deferMemorization: const drift.Value(true),
              createdAt: now,
              updatedAt: now,
            ),
          );
    } else {
      await (_db.delete(_db.todayAdjustments)
            ..where((t) => t.planId.equals(planId) & t.dateKey.equals(dateKey)))
          .go();
    }
  }
}
