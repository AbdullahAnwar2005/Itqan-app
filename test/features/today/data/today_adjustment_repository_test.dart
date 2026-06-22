import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:itqan/core/database/app_database.dart';
import 'package:itqan/features/today/data/today_adjustment_repository.dart';

void main() {
  late AppDatabase db;
  late TodayAdjustmentRepository repository;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    repository = TodayAdjustmentRepository(db);
  });

  tearDown(() async {
    await db.close();
  });

  group('TodayAdjustmentRepository', () {
    test('no row means deferMemorization is false', () async {
      final adjustment = await repository.getAdjustment(
        planId: 'plan-1',
        dateKey: '2023-10-01',
      );

      expect(adjustment.planId, 'plan-1');
      expect(adjustment.dateKey, '2023-10-01');
      expect(adjustment.deferMemorization, isFalse);
    });

    test('setting deferMemorization true persists for same plan/date', () async {
      await repository.setDeferMemorization(
        planId: 'plan-1',
        dateKey: '2023-10-01',
        defer: true,
      );

      final adjustment = await repository.getAdjustment(
        planId: 'plan-1',
        dateKey: '2023-10-01',
      );

      expect(adjustment.deferMemorization, isTrue);
    });

    test('setting deferMemorization false undoes the defer (deletes row)', () async {
      // First set to true
      await repository.setDeferMemorization(
        planId: 'plan-1',
        dateKey: '2023-10-01',
        defer: true,
      );

      // Then set to false
      await repository.setDeferMemorization(
        planId: 'plan-1',
        dateKey: '2023-10-01',
        defer: false,
      );

      final adjustment = await repository.getAdjustment(
        planId: 'plan-1',
        dateKey: '2023-10-01',
      );

      expect(adjustment.deferMemorization, isFalse);
      
      // Verify row is deleted
      final rows = await db.select(db.todayAdjustments).get();
      expect(rows.isEmpty, isTrue);
    });

    test('composite primary key prevents duplicate rows for same plan/date', () async {
      // Set to true multiple times
      await repository.setDeferMemorization(
        planId: 'plan-1',
        dateKey: '2023-10-01',
        defer: true,
      );
      
      await repository.setDeferMemorization(
        planId: 'plan-1',
        dateKey: '2023-10-01',
        defer: true,
      );

      final rows = await db.select(db.todayAdjustments).get();
      expect(rows.length, 1);
      expect(rows.first.deferMemorization, isTrue);
    });
    
    test('adjustments are isolated per plan and date', () async {
      await repository.setDeferMemorization(
        planId: 'plan-1',
        dateKey: '2023-10-01',
        defer: true,
      );
      
      // Different date
      final otherDate = await repository.getAdjustment(
        planId: 'plan-1',
        dateKey: '2023-10-02',
      );
      expect(otherDate.deferMemorization, isFalse);
      
      // Different plan
      final otherPlan = await repository.getAdjustment(
        planId: 'plan-2',
        dateKey: '2023-10-01',
      );
      expect(otherPlan.deferMemorization, isFalse);
    });
  });
}
