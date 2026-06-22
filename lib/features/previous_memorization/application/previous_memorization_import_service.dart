import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:itqan/core/constants/quran_metadata.dart';
import 'package:itqan/features/plan/domain/quran_position.dart';
import 'package:itqan/features/previous_memorization/data/previous_memorization_repository.dart';
import 'package:itqan/features/previous_memorization/domain/previous_memorized_range.dart';
import 'package:itqan/features/progress/data/segment_progress_repository.dart';
import 'package:itqan/features/progress/domain/quran_segment_progress.dart';
import 'package:itqan/features/progress/domain/segment_progress_source.dart';
import 'package:itqan/features/progress/domain/segment_progress_status.dart';
import 'package:itqan/features/session/application/session_providers.dart';
import 'package:itqan/features/session/domain/session_rating.dart';

final previousMemorizationImportServiceProvider =
    Provider<PreviousMemorizationImportService>((ref) {
  return PreviousMemorizationImportService(
    ref.watch(previousMemorizationRepositoryProvider),
    ref.watch(segmentProgressRepositoryProvider),
  );
});

class PreviousMemorizationImportService {
  const PreviousMemorizationImportService(this._prevRepo, this._progressRepo);

  final PreviousMemorizationRepository _prevRepo;
  final SegmentProgressRepository _progressRepo;

  Future<void> importRangesForPlan(String planId) async {
    final ranges = await _prevRepo.getRangesForPlan(planId);
    await _importRanges(planId, ranges);
  }

  Future<void> importSingleRange(
      String planId, PreviousMemorizedRange range) async {
    await _importRanges(planId, [range]);
  }

  Future<void> _importRanges(
      String planId, List<PreviousMemorizedRange> ranges) async {
    for (final range in ranges) {
      final segments = _splitRangeBySurah(planId, range);

      for (final segment in segments) {
        final existing = await _progressRepo.getSegmentProgressForRange(
          planId,
          segment.startPosition.surahNumber,
          segment.startPosition.ayahNumber,
          segment.endPosition.surahNumber,
          segment.endPosition.ayahNumber,
        );

        // Do not overwrite actual app memorization progress
        if (existing != null &&
            existing.source == SegmentProgressSource.appMemorization) {
          continue;
        }

        // Keep ID if we are updating an existing imported record
        final idToUse = existing?.id ?? segment.id;

        await _progressRepo.upsertSegmentProgress(
          segment.copyWith(id: idToUse),
        );
      }
    }
  }

  List<QuranSegmentProgress> _splitRangeBySurah(
      String planId, PreviousMemorizedRange range) {
    final segments = <QuranSegmentProgress>[];

    if (range.startSurah == range.endSurah) {
      segments.add(_createProgress(
        planId,
        QuranPosition(
            surahNumber: range.startSurah, ayahNumber: range.startAyah),
        QuranPosition(surahNumber: range.endSurah, ayahNumber: range.endAyah),
      ));
    } else {
      // 1. First surah part
      segments.add(_createProgress(
        planId,
        QuranPosition(
            surahNumber: range.startSurah, ayahNumber: range.startAyah),
        QuranPosition(
          surahNumber: range.startSurah,
          ayahNumber: QuranMetadata.getAyahCount(range.startSurah),
        ),
      ));

      // 2. Intermediate full surahs
      for (int s = range.startSurah + 1; s < range.endSurah; s++) {
        segments.add(_createProgress(
          planId,
          QuranPosition(surahNumber: s, ayahNumber: 1),
          QuranPosition(
              surahNumber: s, ayahNumber: QuranMetadata.getAyahCount(s)),
        ));
      }

      // 3. Last surah part
      segments.add(_createProgress(
        planId,
        QuranPosition(surahNumber: range.endSurah, ayahNumber: 1),
        QuranPosition(surahNumber: range.endSurah, ayahNumber: range.endAyah),
      ));
    }

    return segments;
  }

  QuranSegmentProgress _createProgress(
      String planId, QuranPosition start, QuranPosition end) {
    return QuranSegmentProgress(
      id: 'import_${DateTime.now().millisecondsSinceEpoch}_${start.hashCode}_${end.hashCode}',
      planId: planId,
      startPosition: start,
      endPosition: end,
      status: SegmentProgressStatus.stabilizing,
      masteryScore: 2,
      lastRating: SessionRating.unrated,
      lastPracticedAt: DateTime.fromMillisecondsSinceEpoch(0),
      nextReviewAt: DateTime.now().add(const Duration(days: 1)),
      source: SegmentProgressSource.previousMemorization,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }
}
