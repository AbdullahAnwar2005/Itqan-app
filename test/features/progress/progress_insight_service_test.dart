import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:itqan/core/database/app_database.dart';
import 'package:itqan/features/plan/application/plan_providers.dart';
import 'package:itqan/features/plan/domain/quran_position.dart';
import 'package:itqan/features/progress/application/progress_insight_service.dart';
import 'package:itqan/features/progress/application/progress_providers.dart';
import 'package:itqan/features/progress/data/segment_progress_repository.dart';
import 'package:itqan/features/progress/domain/quran_segment_progress.dart';
import 'package:itqan/features/progress/domain/segment_progress_source.dart';
import 'package:itqan/features/progress/domain/segment_progress_status.dart';
import 'package:itqan/features/session/data/session_repository.dart';
import 'package:itqan/features/session/domain/session.dart';
import 'package:itqan/features/session/domain/session_log.dart';
import 'package:itqan/features/session/domain/session_rating.dart';

void main() {
  late AppDatabase db;
  late SegmentProgressRepository segmentRepo;
  late SessionRepository sessionRepo;
  late ProgressInsightService service;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    segmentRepo = SegmentProgressRepository(db);
    sessionRepo = SessionRepository(db);
    service = ProgressInsightService(
      segmentProgressRepository: segmentRepo,
      sessionRepository: sessionRepo,
    );
  });

  tearDown(() async {
    await db.close();
  });

  group('ProgressInsightService Tests', () {
    test('empty data returns safe zero values', () async {
      final now = DateTime(2024, 1, 15, 12, 0, 0);
      final summary = await service.getSummary(planId: 'plan-1', now: now);

      expect(summary.totalTrackedSegments, 0);
      expect(summary.stableCount, 0);
      expect(summary.stabilizingCount, 0);
      expect(summary.learningCount, 0);
      expect(summary.weakCount, 0);
      expect(summary.needsRetryCount, 0);
      expect(summary.dueTodayCount, 0);
      expect(summary.dueSoonCount, 0);
      expect(summary.appMemorizationCount, 0);
      expect(summary.previousMemorizationCount, 0);
      expect(summary.recentSessionCount, 0);
      expect(summary.lastSessionAt, isNull);
      expect(summary.ratingBreakdown.easyCount, 0);
      expect(summary.ratingBreakdown.goodCount, 0);
      expect(summary.ratingBreakdown.hardCount, 0);
      expect(summary.ratingBreakdown.againCount, 0);
      expect(summary.ratingBreakdown.unratedCount, 0);
      expect(summary.prioritySegments, isEmpty);
    });

    test('status and source counts are calculated correctly', () async {
      final now = DateTime(2024, 1, 15, 12, 0, 0);
      final planId = 'plan-1';

      // Insert segments with varying statuses and sources
      final statuses = [
        SegmentProgressStatus.stable,
        SegmentProgressStatus.stabilizing,
        SegmentProgressStatus.learning,
        SegmentProgressStatus.weak,
        SegmentProgressStatus.needsRetry,
      ];
      final sources = [
        SegmentProgressSource.appMemorization,
        SegmentProgressSource.previousMemorization,
        SegmentProgressSource.appMemorization,
        SegmentProgressSource.appMemorization,
        SegmentProgressSource.previousMemorization,
      ];

      for (int i = 0; i < 5; i++) {
        await segmentRepo.upsertSegmentProgress(
          QuranSegmentProgress(
            id: 'seg-$i',
            planId: planId,
            startPosition: QuranPosition(surahNumber: i + 1, ayahNumber: 1),
            endPosition: QuranPosition(surahNumber: i + 1, ayahNumber: 5),
            status: statuses[i],
            masteryScore: 50,
            lastRating: SessionRating.good,
            lastPracticedAt: now,
            nextReviewAt: now.add(const Duration(days: 5)),
            source: sources[i],
            createdAt: now,
            updatedAt: now,
          ),
        );
      }

      final summary = await service.getSummary(planId: planId, now: now);

      expect(summary.totalTrackedSegments, 5);
      expect(summary.stableCount, 1);
      expect(summary.stabilizingCount, 1);
      expect(summary.learningCount, 1);
      expect(summary.weakCount, 1);
      expect(summary.needsRetryCount, 1);
      expect(summary.appMemorizationCount, 3);
      expect(summary.previousMemorizationCount, 2);
    });

    test('dueTodayCount and dueSoonCount boundaries are correct and exclude each other', () async {
      final now = DateTime(2024, 1, 15, 12, 0, 0);
      final planId = 'plan-1';

      // endOfToday is 2024-01-15 23:59:59.999
      // endOfThreeDays is 2024-01-18 23:59:59.999
      final times = [
        now.subtract(const Duration(days: 1)), // Due today (past due) -> dueToday
        DateTime(2024, 1, 15, 23, 59, 59, 999), // Due today (exact boundary) -> dueToday
        DateTime(2024, 1, 16, 0, 0, 0, 0), // Due soon (start of tomorrow) -> dueSoon
        DateTime(2024, 1, 18, 23, 59, 59, 999), // Due soon (end of day 3 boundary) -> dueSoon
        DateTime(2024, 1, 19, 0, 0, 0, 0), // Not due soon (day 4) -> neither
      ];

      for (int i = 0; i < times.length; i++) {
        await segmentRepo.upsertSegmentProgress(
          QuranSegmentProgress(
            id: 'seg-$i',
            planId: planId,
            startPosition: QuranPosition(surahNumber: i + 1, ayahNumber: 1),
            endPosition: QuranPosition(surahNumber: i + 1, ayahNumber: 5),
            status: SegmentProgressStatus.stable,
            masteryScore: 50,
            lastRating: SessionRating.good,
            lastPracticedAt: now,
            nextReviewAt: times[i],
            source: SegmentProgressSource.appMemorization,
            createdAt: now,
            updatedAt: now,
          ),
        );
      }

      final summary = await service.getSummary(planId: planId, now: now);

      // seg-0, seg-1 are due today
      expect(summary.dueTodayCount, 2);
      // seg-2, seg-3 are due soon (between endOfToday and endOfThreeDays)
      expect(summary.dueSoonCount, 2);
    });

    test('recentSessionCount only counts last 7 days and ratingBreakdown is correct', () async {
      final now = DateTime(2024, 1, 15, 12, 0, 0);
      final planId = 'plan-1';

      // 7 days ago is 2024-01-08 12:00:00
      final logTimes = [
        now.subtract(const Duration(days: 8)), // Outside
        now.subtract(const Duration(days: 7)), // Inside (exact boundary)
        now.subtract(const Duration(days: 3)), // Inside
        now, // Inside
      ];
      final ratings = [
        SessionRating.easy,
        SessionRating.easy,
        SessionRating.good,
        SessionRating.hard,
      ];

      for (int i = 0; i < logTimes.length; i++) {
        await sessionRepo.saveSessionLog(
          SessionLogEntry(
            id: 'log-$i',
            assignmentId: 'assign-$i',
            planId: planId,
            sessionType: SessionType.memorization,
            rating: ratings[i],
            completedAt: logTimes[i],
            createdAt: logTimes[i],
          ),
        );
      }

      final summary = await service.getSummary(planId: planId, now: now);

      expect(summary.recentSessionCount, 3);
      expect(summary.ratingBreakdown.easyCount, 1); // log-1 (log-0 is outside)
      expect(summary.ratingBreakdown.goodCount, 1); // log-2
      expect(summary.ratingBreakdown.hardCount, 1); // log-3
      expect(summary.ratingBreakdown.againCount, 0);
      expect(summary.ratingBreakdown.unratedCount, 0);
    });

    test('lastSessionAt scan all logs including those outside recent 7 days window', () async {
      final now = DateTime(2024, 1, 15, 12, 0, 0);
      final planId = 'plan-1';
      final completedAt = now.subtract(const Duration(days: 30));

      await sessionRepo.saveSessionLog(
        SessionLogEntry(
          id: 'old-log',
          assignmentId: 'assign-old',
          planId: planId,
          sessionType: SessionType.memorization,
          rating: SessionRating.easy,
          completedAt: completedAt,
          createdAt: completedAt,
        ),
      );

      final summary = await service.getSummary(planId: planId, now: now);

      expect(summary.recentSessionCount, 0); // Outside 7 days
      expect(summary.lastSessionAt, completedAt); // Still captures the oldest log
    });

    test('prioritySegments prioritizes needsRetry, then weak, then oldest nextReviewAt, with max 5 limit', () async {
      final now = DateTime(2024, 1, 15, 12, 0, 0);
      final planId = 'plan-1';

      // 7 segments:
      // seg-0: needsRetry, nextReviewAt = Jan 15 -> Should be index 1 of needsRetry
      // seg-1: weak, nextReviewAt = Jan 14 -> Should be index 1 of weak
      // seg-2: needsRetry, nextReviewAt = Jan 13 -> Should be index 0 of needsRetry (oldest nextReviewAt)
      // seg-3: stable, nextReviewAt = Jan 12 -> Should not be in priority list at all
      // seg-4: weak, nextReviewAt = Jan 16 -> Should be index 2 of weak
      // seg-5: needsRetry, nextReviewAt = Jan 17 -> Should be index 2 of needsRetry
      // seg-6: weak, nextReviewAt = Jan 11 -> Should be index 0 of weak
      final statuses = [
        SegmentProgressStatus.needsRetry,
        SegmentProgressStatus.weak,
        SegmentProgressStatus.needsRetry,
        SegmentProgressStatus.stable,
        SegmentProgressStatus.weak,
        SegmentProgressStatus.needsRetry,
        SegmentProgressStatus.weak,
      ];
      final nextReviews = [
        DateTime(2024, 1, 15),
        DateTime(2024, 1, 14),
        DateTime(2024, 1, 13),
        DateTime(2024, 1, 12),
        DateTime(2024, 1, 16),
        DateTime(2024, 1, 17),
        DateTime(2024, 1, 11),
      ];

      for (int i = 0; i < 7; i++) {
        await segmentRepo.upsertSegmentProgress(
          QuranSegmentProgress(
            id: 'seg-$i',
            planId: planId,
            startPosition: QuranPosition(surahNumber: i + 1, ayahNumber: 1),
            endPosition: QuranPosition(surahNumber: i + 1, ayahNumber: 5),
            status: statuses[i],
            masteryScore: 50,
            lastRating: SessionRating.good,
            lastPracticedAt: now,
            nextReviewAt: nextReviews[i],
            source: SegmentProgressSource.appMemorization,
            createdAt: now,
            updatedAt: now,
          ),
        );
      }

      final summary = await service.getSummary(planId: planId, now: now);

      // Stable is excluded. Total candidate items: 6 (seg-0, seg-1, seg-2, seg-4, seg-5, seg-6).
      // Max limit is 5.
      expect(summary.prioritySegments.length, 5);

      // Expected order:
      // NeedsRetry first:
      // 1. seg-2 (needsRetry, Jan 13)
      // 2. seg-0 (needsRetry, Jan 15)
      // 3. seg-5 (needsRetry, Jan 17)
      // Weak next:
      // 4. seg-6 (weak, Jan 11)
      // 5. seg-1 (weak, Jan 14)
      // (seg-4 weak, Jan 16 is truncated due to limit)
      expect(summary.prioritySegments[0].segmentProgressId, 'seg-2');
      expect(summary.prioritySegments[1].segmentProgressId, 'seg-0');
      expect(summary.prioritySegments[2].segmentProgressId, 'seg-5');
      expect(summary.prioritySegments[3].segmentProgressId, 'seg-6');
      expect(summary.prioritySegments[4].segmentProgressId, 'seg-1');
    });

    test('progressInsightSummaryProvider returns null safely when no active plan exists', () async {
      final container = ProviderContainer(
        overrides: [
          activePlanProvider.overrideWith((ref) => null),
        ],
      );
      addTearDown(container.dispose);

      final summary = await container.read(progressInsightSummaryProvider.future);
      expect(summary, isNull);
    });
  });
}
