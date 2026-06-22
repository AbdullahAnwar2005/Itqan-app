import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:itqan/features/plan/domain/quran_position.dart';
import 'package:itqan/features/progress/data/segment_progress_repository.dart';
import 'package:itqan/features/progress/domain/quran_segment_progress.dart';
import 'package:itqan/features/progress/domain/segment_progress_status.dart';
import 'package:itqan/features/session/domain/session_rating.dart';
import 'package:itqan/features/today/application/near_review_service.dart';
import 'package:itqan/features/today/domain/today_task.dart';
import 'package:itqan/features/progress/domain/segment_progress_source.dart';
import 'package:mockito/annotations.dart';

import 'old_review_service_test.mocks.dart';

void main() {
  late MockSegmentProgressRepository mockRepository;
  late NearReviewService service;

  setUp(() {
    mockRepository = MockSegmentProgressRepository();
    service = NearReviewService(mockRepository);
  });

  test('getNearReviewTasks maps due segments to TodayTasks correctly', () async {
    final now = DateTime.now();
    final segment = QuranSegmentProgress(
      id: 'seg-1',
      planId: 'plan-1',
      startPosition: const QuranPosition(surahNumber: 2, ayahNumber: 1),
      endPosition: const QuranPosition(surahNumber: 2, ayahNumber: 5),
      status: SegmentProgressStatus.weak,
      masteryScore: 1,
      lastRating: SessionRating.hard,
      lastPracticedAt: now.subtract(const Duration(days: 1)),
      nextReviewAt: now.subtract(const Duration(days: 1)),
      source: SegmentProgressSource.appMemorization,
      createdAt: now,
      updatedAt: now,
    );
    
    when(mockRepository.getDueSegmentsForPlan(
      planId: anyNamed('planId'),
      date: anyNamed('date'),
      source: SegmentProgressSource.appMemorization,
      limit: anyNamed('limit'),
    )).thenAnswer((_) async => [segment]);

    final tasks = await service.getNearReviewTasks(planId: 'plan-1');

    expect(tasks.length, 1);
    expect(tasks.first.type, TodayTaskType.nearReview);
    expect(tasks.first.id, 'nearReview_seg-1');
    expect(tasks.first.startPosition, const QuranPosition(surahNumber: 2, ayahNumber: 1));
    expect(tasks.first.endPosition, const QuranPosition(surahNumber: 2, ayahNumber: 5));
    expect(tasks.first.segmentProgressId, 'seg-1');
    expect(tasks.first.isCompleted, isFalse);
    
    verify(mockRepository.getDueSegmentsForPlan(
      planId: 'plan-1',
      date: anyNamed('date'),
      source: SegmentProgressSource.appMemorization,
      limit: 1,
    )).called(1);
  });

  test('getNearReviewTasks returns empty list when no segments are due', () async {
    when(mockRepository.getDueSegmentsForPlan(
      planId: anyNamed('planId'),
      date: anyNamed('date'),
      source: SegmentProgressSource.appMemorization,
      limit: anyNamed('limit'),
    )).thenAnswer((_) async => []);

    final tasks = await service.getNearReviewTasks(planId: 'plan-1');

    expect(tasks.isEmpty, isTrue);
  });
}

