import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:itqan/core/constants/quran_metadata.dart';
import 'package:itqan/core/database/app_database.dart';
import 'package:itqan/core/database/database_provider.dart';
import 'package:itqan/features/plan/domain/quran_position.dart';
import 'package:itqan/features/previous_memorization/domain/previous_memorized_range.dart';

final previousMemorizationRepositoryProvider = Provider<PreviousMemorizationRepository>(
  (ref) => PreviousMemorizationRepository(ref.watch(databaseProvider)),
);

class PreviousMemorizationRepository {
  const PreviousMemorizationRepository(this._db);

  final AppDatabase _db;

  Future<void> addRange(PreviousMemorizedRange range) async {
    _validateBounds(range);
    await _validateNoOverlap(range.planId, range, excludeId: null);

    await _db.into(_db.previousMemorizedRanges).insert(
          PreviousMemorizedRangesCompanion.insert(
            id: range.id,
            planId: range.planId,
            startSurah: range.startSurah,
            startAyah: range.startAyah,
            endSurah: range.endSurah,
            endAyah: range.endAyah,
            source: range.source.persistenceKey,
            createdAt: range.createdAt,
            updatedAt: range.updatedAt,
          ),
        );
  }

  Future<void> updateRange(PreviousMemorizedRange range) async {
    _validateBounds(range);
    await _validateNoOverlap(range.planId, range, excludeId: range.id);

    await (_db.update(_db.previousMemorizedRanges)..where((t) => t.id.equals(range.id))).write(
      PreviousMemorizedRangesCompanion(
        startSurah: Value(range.startSurah),
        startAyah: Value(range.startAyah),
        endSurah: Value(range.endSurah),
        endAyah: Value(range.endAyah),
        source: Value(range.source.persistenceKey),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<void> deleteRange(String id) async {
    await (_db.delete(_db.previousMemorizedRanges)..where((t) => t.id.equals(id))).go();
  }

  Future<List<PreviousMemorizedRange>> getRangesForPlan(String planId) async {
    final records = await (_db.select(_db.previousMemorizedRanges)
          ..where((t) => t.planId.equals(planId))
          ..orderBy([
            (t) => OrderingTerm(expression: t.startSurah),
            (t) => OrderingTerm(expression: t.startAyah),
          ]))
        .get();

    return records.map(_mapEntityToDomain).toList();
  }

  Stream<List<PreviousMemorizedRange>> watchRangesForPlan(String planId) {
    return (_db.select(_db.previousMemorizedRanges)
          ..where((t) => t.planId.equals(planId))
          ..orderBy([
            (t) => OrderingTerm(expression: t.startSurah),
            (t) => OrderingTerm(expression: t.startAyah),
          ]))
        .watch()
        .map((records) => records.map(_mapEntityToDomain).toList());
  }

  PreviousMemorizedRange _mapEntityToDomain(PreviousMemorizedRangeEntity entity) {
    return PreviousMemorizedRange(
      id: entity.id,
      planId: entity.planId,
      startSurah: entity.startSurah,
      startAyah: entity.startAyah,
      endSurah: entity.endSurah,
      endAyah: entity.endAyah,
      source: PreviousMemorizationSource.fromKey(entity.source),
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  void _validateBounds(PreviousMemorizedRange range) {
    if (range.startSurah < 1 || range.startSurah > 114) {
      throw const FormatException('Invalid start surah');
    }
    if (range.endSurah < 1 || range.endSurah > 114) {
      throw const FormatException('Invalid end surah');
    }
    
    final startAyahs = QuranMetadata.getAyahCount(range.startSurah);
    if (range.startAyah < 1 || range.startAyah > startAyahs) {
      throw const FormatException('Invalid start ayah');
    }

    final endAyahs = QuranMetadata.getAyahCount(range.endSurah);
    if (range.endAyah < 1 || range.endAyah > endAyahs) {
      throw const FormatException('Invalid end ayah');
    }

    final startPos = QuranPosition(surahNumber: range.startSurah, ayahNumber: range.startAyah);
    final endPos = QuranPosition(surahNumber: range.endSurah, ayahNumber: range.endAyah);

    if (startPos.compareTo(endPos) > 0) {
      throw const FormatException('Start position must be before or equal to end position');
    }
  }

  Future<void> _validateNoOverlap(String planId, PreviousMemorizedRange newRange, {String? excludeId}) async {
    final existing = await getRangesForPlan(planId);
    
    final newStart = QuranPosition(surahNumber: newRange.startSurah, ayahNumber: newRange.startAyah);
    final newEnd = QuranPosition(surahNumber: newRange.endSurah, ayahNumber: newRange.endAyah);

    for (final range in existing) {
      if (excludeId != null && range.id == excludeId) continue;

      final existingStart = QuranPosition(surahNumber: range.startSurah, ayahNumber: range.startAyah);
      final existingEnd = QuranPosition(surahNumber: range.endSurah, ayahNumber: range.endAyah);

      // Overlap condition: start1 <= end2 && start2 <= end1
      if (newStart.compareTo(existingEnd) <= 0 && existingStart.compareTo(newEnd) <= 0) {
        throw const FormatException('The specified range overlaps with an existing memorized range.');
      }
    }
  }
}
