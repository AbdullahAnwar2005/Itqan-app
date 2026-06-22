import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../progress/data/segment_progress_repository.dart';
import '../../progress/domain/quran_segment_progress.dart';
import '../../session/application/session_providers.dart';
import '../domain/today_task.dart';
import '../../progress/domain/segment_progress_source.dart';

/// Service responsible for orchestrating the generation of near review tasks.
class NearReviewService {
  const NearReviewService(this._segmentProgressRepository);

  final SegmentProgressRepository _segmentProgressRepository;

  /// Fetches due segments for the given [planId] and maps them to [TodayTask]s.
  Future<List<TodayTask>> getNearReviewTasks({
    required String planId,
    int limit = 1,
  }) async {
    final dueSegments = await _segmentProgressRepository.getDueSegmentsForPlan(
      planId: planId,
      date: DateTime.now(),
      source: SegmentProgressSource.appMemorization,
      limit: limit,
    );

    return dueSegments.map((segment) {
      return TodayTask(
        id: 'nearReview_${segment.id}',
        type: TodayTaskType.nearReview,
        startPosition: segment.startPosition,
        endPosition: segment.endPosition,
        segmentProgressId: segment.id,
        isCompleted: false, // Near review tasks are generated fresh unless validated against session logs
      );
    }).toList();
  }
}

/// Provides the [NearReviewService].
final nearReviewServiceProvider = Provider<NearReviewService>((ref) {
  return NearReviewService(ref.watch(segmentProgressRepositoryProvider));
});
