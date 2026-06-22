import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../progress/data/segment_progress_repository.dart';
import '../../progress/domain/segment_progress_source.dart';
import '../domain/today_task.dart';

class OldReviewService {
  const OldReviewService(this._repository);

  final SegmentProgressRepository _repository;

  Future<List<TodayTask>> getOldReviewTasks({
    required String planId,
    required DateTime date,
  }) async {
    final segments = await _repository.getDueSegmentsForPlan(
      planId: planId,
      date: date,
      source: SegmentProgressSource.previousMemorization,
      limit: 1, // Start with 1 as requested
    );

    return segments.map((s) {
      return TodayTask(
        id: 'oldReview_${s.id}',
        type: TodayTaskType.oldReview,
        startPosition: s.startPosition,
        endPosition: s.endPosition,
        segmentProgressId: s.id,
        isCompleted: false,
      );
    }).toList();
  }
}
