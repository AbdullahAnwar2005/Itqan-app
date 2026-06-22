import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:itqan/core/database/app_database.dart';
import 'package:itqan/features/previous_memorization/data/previous_memorization_repository.dart';
import 'package:itqan/features/previous_memorization/domain/previous_memorized_range.dart';

void main() {
  late AppDatabase db;
  late PreviousMemorizationRepository repository;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    repository = PreviousMemorizationRepository(db);
  });

  tearDown(() async {
    await db.close();
  });

  PreviousMemorizedRange createRange({
    required String id,
    int startSurah = 1,
    int startAyah = 1,
    int endSurah = 1,
    int endAyah = 7,
  }) {
    return PreviousMemorizedRange(
      id: id,
      planId: 'plan1',
      startSurah: startSurah,
      startAyah: startAyah,
      endSurah: endSurah,
      endAyah: endAyah,
      source: PreviousMemorizationSource.manual,
      createdAt: DateTime(2024),
      updatedAt: DateTime(2024),
    );
  }

  test('addRange saves a range and getRangesForPlan retrieves it', () async {
    final range = createRange(id: '1');
    await repository.addRange(range);

    final retrieved = await repository.getRangesForPlan('plan1');
    expect(retrieved, hasLength(1));
    expect(retrieved.first.id, '1');
    expect(retrieved.first.startSurah, 1);
  });

  test('deleteRange removes the range', () async {
    final range = createRange(id: '1');
    await repository.addRange(range);
    
    await repository.deleteRange('1');

    final retrieved = await repository.getRangesForPlan('plan1');
    expect(retrieved, isEmpty);
  });

  test('updateRange modifies the existing range', () async {
    final range = createRange(id: '1');
    await repository.addRange(range);

    final updatedRange = PreviousMemorizedRange(
      id: '1',
      planId: 'plan1',
      startSurah: 2,
      startAyah: 1,
      endSurah: 2,
      endAyah: 286,
      source: PreviousMemorizationSource.manual,
      createdAt: range.createdAt,
      updatedAt: DateTime.now(),
    );

    await repository.updateRange(updatedRange);

    final retrieved = await repository.getRangesForPlan('plan1');
    expect(retrieved, hasLength(1));
    expect(retrieved.first.startSurah, 2);
    expect(retrieved.first.endSurah, 2);
  });

  test('invalid bounds are rejected', () async {
    // Start surah out of bounds
    expect(
      () => repository.addRange(createRange(id: '1', startSurah: 115)),
      throwsA(isA<FormatException>()),
    );

    // End surah out of bounds
    expect(
      () => repository.addRange(createRange(id: '1', endSurah: 0)),
      throwsA(isA<FormatException>()),
    );

    // Invalid start ayah for Al-Fatiha
    expect(
      () => repository.addRange(createRange(id: '1', startSurah: 1, startAyah: 8)),
      throwsA(isA<FormatException>()),
    );

    // Start > End
    expect(
      () => repository.addRange(createRange(id: '1', startSurah: 2, endSurah: 1)),
      throwsA(isA<FormatException>()),
    );
  });

  test('overlapping ranges are rejected on add', () async {
    final range1 = createRange(id: '1', startSurah: 2, startAyah: 1, endSurah: 2, endAyah: 50);
    await repository.addRange(range1);

    // Exact duplicate
    final duplicate = createRange(id: '2', startSurah: 2, startAyah: 1, endSurah: 2, endAyah: 50);
    expect(() => repository.addRange(duplicate), throwsA(isA<FormatException>()));

    // Partial overlap at the end
    final overlap1 = createRange(id: '3', startSurah: 2, startAyah: 40, endSurah: 2, endAyah: 60);
    expect(() => repository.addRange(overlap1), throwsA(isA<FormatException>()));

    // Partial overlap at the start
    final overlap2 = createRange(id: '4', startSurah: 1, startAyah: 1, endSurah: 2, endAyah: 10);
    expect(() => repository.addRange(overlap2), throwsA(isA<FormatException>()));
    
    // Fully contained inside
    final overlap3 = createRange(id: '5', startSurah: 2, startAyah: 10, endSurah: 2, endAyah: 20);
    expect(() => repository.addRange(overlap3), throwsA(isA<FormatException>()));

    // Wrapping completely around
    final overlap4 = createRange(id: '6', startSurah: 1, startAyah: 1, endSurah: 3, endAyah: 10);
    expect(() => repository.addRange(overlap4), throwsA(isA<FormatException>()));
  });

  test('non-overlapping ranges are saved successfully', () async {
    final range1 = createRange(id: '1', startSurah: 2, startAyah: 1, endSurah: 2, endAyah: 50);
    await repository.addRange(range1);

    final adjacentRange = createRange(id: '2', startSurah: 2, startAyah: 51, endSurah: 2, endAyah: 100);
    await repository.addRange(adjacentRange); // Should not throw

    final retrieved = await repository.getRangesForPlan('plan1');
    expect(retrieved, hasLength(2));
  });

  test('updating a range to not overlap itself is allowed', () async {
    final range1 = createRange(id: '1', startSurah: 2, startAyah: 1, endSurah: 2, endAyah: 50);
    await repository.addRange(range1);

    final range2 = createRange(id: '2', startSurah: 3, startAyah: 1, endSurah: 3, endAyah: 10);
    await repository.addRange(range2);

    // Update range1 to expand but not overlap range2
    final updatedRange1 = PreviousMemorizedRange(
      id: '1',
      planId: 'plan1',
      startSurah: 2,
      startAyah: 1,
      endSurah: 2,
      endAyah: 100,
      source: PreviousMemorizationSource.manual,
      createdAt: range1.createdAt,
      updatedAt: DateTime.now(),
    );

    await repository.updateRange(updatedRange1); // Should not throw
    final retrieved = await repository.getRangesForPlan('plan1');
    expect(retrieved.firstWhere((r) => r.id == '1').endAyah, 100);

    // Update range1 to overlap range2
    final overlapRange1 = PreviousMemorizedRange(
      id: '1',
      planId: 'plan1',
      startSurah: 2,
      startAyah: 1,
      endSurah: 3,
      endAyah: 5,
      source: PreviousMemorizationSource.manual,
      createdAt: range1.createdAt,
      updatedAt: DateTime.now(),
    );

    expect(() => repository.updateRange(overlapRange1), throwsA(isA<FormatException>()));
  });
}
