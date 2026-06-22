import 'package:drift/drift.dart';
import '../../../core/database/app_database.dart';
import '../../plan/domain/quran_position.dart';
import '../../session/domain/session_rating.dart';
import '../domain/quran_segment_progress.dart';
import '../domain/segment_progress_source.dart';
import '../domain/segment_progress_status.dart';

class SegmentProgressRepository {
  SegmentProgressRepository(this._db);

  final AppDatabase _db;

  /// Upserts a QuranSegmentProgress based on its unique constraint
  /// (planId, startSurah, startAyah, endSurah, endAyah).
  Future<void> upsertSegmentProgress(QuranSegmentProgress segment) async {
    await _db.into(_db.quranSegmentProgresses).insertOnConflictUpdate(
          QuranSegmentProgressesCompanion.insert(
            id: segment.id,
            planId: segment.planId,
            startSurah: segment.startPosition.surahNumber,
            startAyah: segment.startPosition.ayahNumber,
            endSurah: segment.endPosition.surahNumber,
            endAyah: segment.endPosition.ayahNumber,
            status: segment.status.name,
            masteryScore: segment.masteryScore,
            lastRating: segment.lastRating.name,
            lastPracticedAt: segment.lastPracticedAt,
            nextReviewAt: segment.nextReviewAt,
            source: Value(segment.source.persistenceKey),
            createdAt: segment.createdAt,
            updatedAt: segment.updatedAt,
          ),
        );
  }

  /// Retrieves an existing segment progress if it exists.
  Future<QuranSegmentProgress?> getSegmentProgressForRange(
    String planId,
    int startSurah,
    int startAyah,
    int endSurah,
    int endAyah,
  ) async {
    final row = await (_db.select(_db.quranSegmentProgresses)
          ..where((t) =>
              t.planId.equals(planId) &
              t.startSurah.equals(startSurah) &
              t.startAyah.equals(startAyah) &
              t.endSurah.equals(endSurah) &
              t.endAyah.equals(endAyah)))
        .getSingleOrNull();

    if (row == null) return null;

    return QuranSegmentProgress(
      id: row.id,
      planId: row.planId,
      startPosition: QuranPosition(surahNumber: row.startSurah, ayahNumber: row.startAyah),
      endPosition: QuranPosition(surahNumber: row.endSurah, ayahNumber: row.endAyah),
      status: SegmentProgressStatus.fromKey(row.status),
      masteryScore: row.masteryScore,
      lastRating: SessionRating.fromKey(row.lastRating),
      lastPracticedAt: row.lastPracticedAt,
      nextReviewAt: row.nextReviewAt,
      source: SegmentProgressSource.fromKey(row.source),
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
    );
  }

  /// Retrieves an existing segment progress by its ID.
  Future<QuranSegmentProgress?> getSegmentProgressById(String id) async {
    final row = await (_db.select(_db.quranSegmentProgresses)
          ..where((t) => t.id.equals(id)))
        .getSingleOrNull();

    if (row == null) return null;

    return QuranSegmentProgress(
      id: row.id,
      planId: row.planId,
      startPosition: QuranPosition(surahNumber: row.startSurah, ayahNumber: row.startAyah),
      endPosition: QuranPosition(surahNumber: row.endSurah, ayahNumber: row.endAyah),
      status: SegmentProgressStatus.fromKey(row.status),
      masteryScore: row.masteryScore,
      lastRating: SessionRating.fromKey(row.lastRating),
      lastPracticedAt: row.lastPracticedAt,
      nextReviewAt: row.nextReviewAt,
      source: SegmentProgressSource.fromKey(row.source),
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
    );
  }

  /// Retrieves due segment progress records for the active plan.
  Future<List<QuranSegmentProgress>> getDueSegmentsForPlan({
    required String planId,
    required DateTime date,
    SegmentProgressSource? source,
    int limit = 3,
  }) async {
    final endOfDay = DateTime(date.year, date.month, date.day, 23, 59, 59);

    final query = _db.select(_db.quranSegmentProgresses)
      ..where((t) {
        var expr = t.planId.equals(planId) & t.nextReviewAt.isSmallerOrEqualValue(endOfDay);
        if (source != null) {
          expr = expr & t.source.equals(source.persistenceKey);
        }
        return expr;
      })
      ..orderBy([
        (t) => OrderingTerm(
            expression: const CustomExpression<int>('''
              CASE 
                WHEN status = 'needsRetry' THEN 1
                WHEN status = 'weak' THEN 2
                WHEN status = 'stabilizing' THEN 3
                WHEN status = 'stable' THEN 4
                ELSE 5
              END
            '''),
            mode: OrderingMode.asc),
        (t) => OrderingTerm(expression: t.nextReviewAt, mode: OrderingMode.asc),
      ])
      ..limit(limit);

    final rows = await query.get();

    return rows.map((row) {
      return QuranSegmentProgress(
        id: row.id,
        planId: row.planId,
        startPosition: QuranPosition(surahNumber: row.startSurah, ayahNumber: row.startAyah),
        endPosition: QuranPosition(surahNumber: row.endSurah, ayahNumber: row.endAyah),
        status: SegmentProgressStatus.fromKey(row.status),
        masteryScore: row.masteryScore,
        lastRating: SessionRating.fromKey(row.lastRating),
        lastPracticedAt: row.lastPracticedAt,
        nextReviewAt: row.nextReviewAt,
        source: SegmentProgressSource.fromKey(row.source),
        createdAt: row.createdAt,
        updatedAt: row.updatedAt,
      );
    }).toList();
  }

  /// Retrieves all segment progress records for the given plan.
  Future<List<QuranSegmentProgress>> getAllSegmentsForPlan(String planId) async {
    final rows = await (_db.select(_db.quranSegmentProgresses)
          ..where((t) => t.planId.equals(planId)))
        .get();

    return rows.map((row) {
      return QuranSegmentProgress(
        id: row.id,
        planId: row.planId,
        startPosition: QuranPosition(surahNumber: row.startSurah, ayahNumber: row.startAyah),
        endPosition: QuranPosition(surahNumber: row.endSurah, ayahNumber: row.endAyah),
        status: SegmentProgressStatus.fromKey(row.status),
        masteryScore: row.masteryScore,
        lastRating: SessionRating.fromKey(row.lastRating),
        lastPracticedAt: row.lastPracticedAt,
        nextReviewAt: row.nextReviewAt,
        source: SegmentProgressSource.fromKey(row.source),
        createdAt: row.createdAt,
        updatedAt: row.updatedAt,
      );
    }).toList();
  }
}
