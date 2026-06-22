import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:itqan/core/database/app_database.dart';
import 'package:itqan/features/plan/domain/quran_position.dart';
import 'package:itqan/features/progress/data/segment_progress_repository.dart';
import 'package:itqan/features/progress/domain/quran_segment_progress.dart';
import 'package:itqan/features/progress/domain/segment_progress_status.dart';
import 'package:itqan/features/session/domain/session_rating.dart';
import 'package:itqan/features/progress/domain/segment_progress_source.dart';

void main() {
  late AppDatabase db;
  late SegmentProgressRepository repository;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    repository = SegmentProgressRepository(db);
  });

  tearDown(() async {
    await db.close();
  });

  group('SegmentProgressRepository - getDueSegmentsForPlan', () {
    test('selects due segments correctly and orders by priority', () async {
      final now = DateTime(2024, 1, 1, 12, 0, 0);
      final planId = 'plan-1';

      // Not due
      await repository.upsertSegmentProgress(
        QuranSegmentProgress(
          id: '1',
          planId: planId,
          startPosition: const QuranPosition(surahNumber: 1, ayahNumber: 1),
          endPosition: const QuranPosition(surahNumber: 1, ayahNumber: 5),
          status: SegmentProgressStatus.stable,
          masteryScore: 3,
          lastRating: SessionRating.easy,
          lastPracticedAt: now.subtract(const Duration(days: 1)),
          nextReviewAt: now.add(const Duration(days: 1)), // Due tomorrow
          source: SegmentProgressSource.appMemorization,
          createdAt: now,
          updatedAt: now,
        ),
      );

      // Due - needsRetry (highest priority)
      await repository.upsertSegmentProgress(
        QuranSegmentProgress(
          id: '2',
          planId: planId,
          startPosition: const QuranPosition(surahNumber: 2, ayahNumber: 1),
          endPosition: const QuranPosition(surahNumber: 2, ayahNumber: 10),
          status: SegmentProgressStatus.needsRetry,
          masteryScore: 0,
          lastRating: SessionRating.again,
          lastPracticedAt: now,
          nextReviewAt: now, // Due today
          source: SegmentProgressSource.appMemorization,
          createdAt: now,
          updatedAt: now,
        ),
      );

      // Due - weak (second priority)
      await repository.upsertSegmentProgress(
        QuranSegmentProgress(
          id: '3',
          planId: planId,
          startPosition: const QuranPosition(surahNumber: 3, ayahNumber: 1),
          endPosition: const QuranPosition(surahNumber: 3, ayahNumber: 5),
          status: SegmentProgressStatus.weak,
          masteryScore: 1,
          lastRating: SessionRating.hard,
          lastPracticedAt: now.subtract(const Duration(days: 1)),
          nextReviewAt: now.subtract(const Duration(days: 1)), // Due yesterday
          source: SegmentProgressSource.appMemorization,
          createdAt: now,
          updatedAt: now,
        ),
      );

      final dueSegments = await repository.getDueSegmentsForPlan(
        planId: planId,
        date: now,
        limit: 5,
      );

      expect(dueSegments.length, 2); // '1' is not due
      expect(dueSegments[0].id, '2'); // needsRetry comes first
      expect(dueSegments[1].id, '3'); // weak comes next
    });
  });
}
