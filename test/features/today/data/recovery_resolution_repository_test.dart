import 'package:flutter_test/flutter_test.dart';
import 'package:drift/native.dart';
import 'package:itqan/core/database/app_database.dart';
import 'package:itqan/features/today/data/recovery_resolution_repository.dart';

void main() {
  late AppDatabase db;
  late RecoveryResolutionRepository repository;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    repository = RecoveryResolutionRepository(db);
  });

  tearDown(() async {
    await db.close();
  });

  group('RecoveryResolutionRepository', () {
    test('getResolution returns null when no resolution exists', () async {
      final resolution = await repository.getResolution(planId: 'plan1');
      expect(resolution, isNull);
    });

    test('resolveMissedWorkBefore saves resolution and getResolution retrieves it', () async {
      await repository.resolveMissedWorkBefore(
        planId: 'plan1',
        resolvedBeforeDateKey: '2023-10-01',
      );

      final resolution = await repository.getResolution(planId: 'plan1');
      
      expect(resolution, isNotNull);
      expect(resolution!.planId, 'plan1');
      expect(resolution.resolvedBeforeDateKey, '2023-10-01');
    });

    test('resolveMissedWorkBefore updates existing resolution', () async {
      await repository.resolveMissedWorkBefore(
        planId: 'plan1',
        resolvedBeforeDateKey: '2023-10-01',
      );

      await repository.resolveMissedWorkBefore(
        planId: 'plan1',
        resolvedBeforeDateKey: '2023-10-05',
      );

      final resolution = await repository.getResolution(planId: 'plan1');
      
      expect(resolution, isNotNull);
      expect(resolution!.resolvedBeforeDateKey, '2023-10-05');
      
      // Ensure only one row exists
      final rows = await db.select(db.recoveryResolutions).get();
      expect(rows.length, 1);
    });
  });
}
