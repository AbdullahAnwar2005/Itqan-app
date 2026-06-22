import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:itqan/features/plan/domain/quran_position.dart';
import 'package:itqan/features/progress/data/segment_progress_repository.dart';
import 'package:itqan/features/progress/domain/quran_segment_progress.dart';
import 'package:itqan/features/progress/domain/segment_progress_source.dart';
import 'package:itqan/features/progress/domain/segment_progress_status.dart';
import 'package:itqan/features/session/domain/session_rating.dart';
import 'package:itqan/features/today/application/old_review_service.dart';
import 'package:itqan/features/today/domain/today_task.dart';
import 'package:mockito/annotations.dart';

import 'old_review_service_test.mocks.dart';

@GenerateMocks([SegmentProgressRepository])
void main() {
  late MockSegmentProgressRepository mockRepository;
  late OldReviewService service;

  setUp(() {
    mockRepository = MockSegmentProgressRepository();
    service = OldReviewService(mockRepository);
  });

  final testDate = DateTime(2026, 6, 19, 12, 0);

  final testProgress = QuranSegmentProgress(
    id: 'seg_old_1',
    planId: 'plan_1',
    startPosition: const QuranPosition(surahNumber: 2, ayahNumber: 1),
    endPosition: const QuranPosition(surahNumber: 2, ayahNumber: 5),
    status: SegmentProgressStatus.needsRetry,
    masteryScore: 0,
    lastRating: SessionRating.unrated,
    lastPracticedAt: DateTime(0),
    nextReviewAt: testDate.subtract(const Duration(hours: 1)),
    source: SegmentProgressSource.previousMemorization,
    createdAt: testDate,
    updatedAt: testDate,
  );

  test('fetches old review tasks from previous memorization', () async {
    when(mockRepository.getDueSegmentsForPlan(
      planId: 'plan_1',
      date: testDate,
      source: SegmentProgressSource.previousMemorization,
      limit: 1,
    )).thenAnswer((_) async => [testProgress]);

    final tasks = await service.getOldReviewTasks(
      planId: 'plan_1',
      date: testDate,
    );

    expect(tasks.length, 1);
    expect(tasks.first.type, TodayTaskType.oldReview);
    expect(tasks.first.segmentProgressId, 'seg_old_1');
    expect(tasks.first.startPosition!.surahNumber, 2);
  });

  test('returns empty if no due old review segments', () async {
    when(mockRepository.getDueSegmentsForPlan(
      planId: 'plan_1',
      date: testDate,
      source: SegmentProgressSource.previousMemorization,
      limit: 1,
    )).thenAnswer((_) async => []);

    final tasks = await service.getOldReviewTasks(
      planId: 'plan_1',
      date: testDate,
    );

    expect(tasks.isEmpty, true);
  });
}
