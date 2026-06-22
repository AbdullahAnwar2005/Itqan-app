import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/database/app_database.dart';
import '../../../core/database/database_provider.dart';
import '../domain/recovery_resolution.dart';

class RecoveryResolutionRepository {
  const RecoveryResolutionRepository(this._db);

  final AppDatabase _db;

  Future<RecoveryResolution?> getResolution({required String planId}) async {
    final query = _db.select(_db.recoveryResolutions)..where((t) => t.planId.equals(planId));
    final row = await query.getSingleOrNull();
    
    if (row == null) return null;

    return RecoveryResolution(
      planId: row.planId,
      resolvedBeforeDateKey: row.resolvedBeforeDateKey,
      resolvedAt: row.resolvedAt,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
    );
  }

  Future<void> resolveMissedWorkBefore({
    required String planId,
    required String resolvedBeforeDateKey,
  }) async {
    final now = DateTime.now();

    await _db.into(_db.recoveryResolutions).insertOnConflictUpdate(
      RecoveryResolutionsCompanion(
        planId: Value(planId),
        resolvedBeforeDateKey: Value(resolvedBeforeDateKey),
        resolvedAt: Value(now),
        createdAt: Value(now), // Drift will ignore this on update if we used a raw insert, but insertOnConflictUpdate updates all fields unless specified.
        updatedAt: Value(now),
      ),
    );
  }
}

final recoveryResolutionRepositoryProvider = Provider<RecoveryResolutionRepository>((ref) {
  return RecoveryResolutionRepository(ref.watch(databaseProvider));
});
