import 'package:flutter_test/flutter_test.dart';
import 'package:itqan/features/plan/domain/quran_position.dart';
import 'package:itqan/features/previous_memorization/application/previous_memorization_import_service.dart';
import 'package:itqan/features/previous_memorization/domain/previous_memorized_range.dart';
import 'package:itqan/features/progress/domain/quran_segment_progress.dart';
import 'package:itqan/features/progress/domain/segment_progress_source.dart';
import 'package:itqan/features/progress/domain/segment_progress_status.dart';
import 'package:itqan/features/session/domain/session_rating.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:itqan/features/previous_memorization/data/previous_memorization_repository.dart';
import 'package:itqan/features/progress/data/segment_progress_repository.dart';

import 'previous_memorization_import_service_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<PreviousMemorizationRepository>(),
  MockSpec<SegmentProgressRepository>(),
])
void main() {
  late PreviousMemorizationImportService service;
  late MockPreviousMemorizationRepository mockPrevRepo;
  late MockSegmentProgressRepository mockProgressRepo;

  setUp(() {
    mockPrevRepo = MockPreviousMemorizationRepository();
    mockProgressRepo = MockSegmentProgressRepository();
    service = PreviousMemorizationImportService(mockPrevRepo, mockProgressRepo);
  });

  final dummyRange1 = PreviousMemorizedRange(
    id: '1',
    planId: 'plan1',
    startSurah: 1,
    startAyah: 1,
    endSurah: 1,
    endAyah: 7,
    source: PreviousMemorizationSource.manual,
    createdAt: DateTime(2025),
    updatedAt: DateTime(2025),
  );

  final dummyRangeMultiSurah = PreviousMemorizedRange(
    id: '2',
    planId: 'plan1',
    startSurah: 1,
    startAyah: 1,
    endSurah: 2,
    endAyah: 20,
    source: PreviousMemorizationSource.manual,
    createdAt: DateTime(2025),
    updatedAt: DateTime(2025),
  );

  test('importSingleRange creates progress with correct defaults', () async {
    when(mockProgressRepo.getSegmentProgressForRange(any, any, any, any, any))
        .thenAnswer((_) async => null);

    await service.importSingleRange('plan1', dummyRange1);

    final captured = verify(mockProgressRepo.upsertSegmentProgress(captureAny)).captured;
    expect(captured.length, 1);
    final progress = captured.first as QuranSegmentProgress;

    expect(progress.planId, 'plan1');
    expect(progress.startPosition.surahNumber, 1);
    expect(progress.startPosition.ayahNumber, 1);
    expect(progress.endPosition.surahNumber, 1);
    expect(progress.endPosition.ayahNumber, 7);
    expect(progress.status, SegmentProgressStatus.stabilizing);
    expect(progress.masteryScore, 2);
    expect(progress.lastRating, SessionRating.unrated);
    expect(progress.source, SegmentProgressSource.previousMemorization);
  });

  test('importSingleRange splits cross-surah ranges correctly', () async {
    when(mockProgressRepo.getSegmentProgressForRange(any, any, any, any, any))
        .thenAnswer((_) async => null);

    await service.importSingleRange('plan1', dummyRangeMultiSurah);

    final captured = verify(mockProgressRepo.upsertSegmentProgress(captureAny)).captured;
    expect(captured.length, 2); // Al-Fatihah and first part of Al-Baqarah

    final p1 = captured[0] as QuranSegmentProgress;
    expect(p1.startPosition.surahNumber, 1);
    expect(p1.endPosition.surahNumber, 1);
    expect(p1.endPosition.ayahNumber, 7);

    final p2 = captured[1] as QuranSegmentProgress;
    expect(p2.startPosition.surahNumber, 2);
    expect(p2.endPosition.surahNumber, 2);
    expect(p2.endPosition.ayahNumber, 20);
  });

  test('does not overwrite existing appMemorization progress', () async {
    final existingAppMemo = QuranSegmentProgress(
      id: 'existing1',
      planId: 'plan1',
      startPosition: const QuranPosition(surahNumber: 1, ayahNumber: 1),
      endPosition: const QuranPosition(surahNumber: 1, ayahNumber: 7),
      status: SegmentProgressStatus.stable,
      masteryScore: 4,
      lastRating: SessionRating.easy,
      lastPracticedAt: DateTime(2025),
      nextReviewAt: DateTime(2025),
      source: SegmentProgressSource.appMemorization,
      createdAt: DateTime(2025),
      updatedAt: DateTime(2025),
    );

    when(mockProgressRepo.getSegmentProgressForRange('plan1', 1, 1, 1, 7))
        .thenAnswer((_) async => existingAppMemo);

    await service.importSingleRange('plan1', dummyRange1);

    // Should NOT call upsert because it's appMemorization
    verifyNever(mockProgressRepo.upsertSegmentProgress(any));
  });

  test('updates existing previousMemorization progress safely', () async {
    final existingPrevMemo = QuranSegmentProgress(
      id: 'existing2',
      planId: 'plan1',
      startPosition: const QuranPosition(surahNumber: 1, ayahNumber: 1),
      endPosition: const QuranPosition(surahNumber: 1, ayahNumber: 7),
      status: SegmentProgressStatus.needsRetry,
      masteryScore: 0,
      lastRating: SessionRating.unrated,
      lastPracticedAt: DateTime(2025),
      nextReviewAt: DateTime(2025),
      source: SegmentProgressSource.previousMemorization, // Allows update
      createdAt: DateTime(2025),
      updatedAt: DateTime(2025),
    );

    when(mockProgressRepo.getSegmentProgressForRange('plan1', 1, 1, 1, 7))
        .thenAnswer((_) async => existingPrevMemo);

    await service.importSingleRange('plan1', dummyRange1);

    final captured = verify(mockProgressRepo.upsertSegmentProgress(captureAny)).captured;
    expect(captured.length, 1);
    final progress = captured.first as QuranSegmentProgress;
    expect(progress.id, 'existing2'); // Preserved ID
    expect(progress.source, SegmentProgressSource.previousMemorization);
  });
}
