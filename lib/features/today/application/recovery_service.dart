import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../plan/data/plan_repository.dart';
import '../../plan/application/plan_providers.dart';
import '../data/recovery_resolution_repository.dart';
import '../domain/recovery_notice.dart';
import 'package:intl/intl.dart';

/// Service responsible for detecting missed past assignments.
class RecoveryService {
  const RecoveryService(this._planRepository, this._resolutionRepository);

  final PlanRepository _planRepository;
  final RecoveryResolutionRepository _resolutionRepository;

  /// Inspects past assignments for the given [planId] and returns a [RecoveryNotice]
  /// if there are uncompleted tasks. Only considers assignments strictly before today
  /// and strictly after the latest recovery resolution cutoff.
  Future<RecoveryNotice?> getRecoveryNotice({required String planId}) async {
    final now = DateTime.now();
    final todayDateKey = DateFormat('yyyy-MM-dd').format(now);

    final pastAssignments = await _planRepository.getPastAssignmentsForPlan(
      planId: planId,
      beforeDateKey: todayDateKey,
    );

    final resolution = await _resolutionRepository.getResolution(planId: planId);
    final cutoffDateKey = resolution?.resolvedBeforeDateKey;

    int missedDaysCount = 0;
    int missedMemoCount = 0;
    int missedReviewCount = 0;

    for (final assignment in pastAssignments) {
      if (cutoffDateKey != null && assignment.dateKey.compareTo(cutoffDateKey) <= 0) {
        continue;
      }

      bool isDayMissed = false;

      if (assignment.hasMemoTask && !assignment.isMemoDone) {
        missedMemoCount++;
        isDayMissed = true;
      }

      if (assignment.hasReviewTask && !assignment.isReviewDone) {
        missedReviewCount++;
        isDayMissed = true;
      }

      if (isDayMissed) {
        missedDaysCount++;
      }
    }

    if (missedDaysCount > 0) {
      return RecoveryNotice(
        hasMissedWork: true,
        missedDaysCount: missedDaysCount,
        missedMemorizationCount: missedMemoCount,
        missedReviewCount: missedReviewCount,
      );
    }

    return null;
  }
}

/// Provides the [RecoveryService].
final recoveryServiceProvider = Provider<RecoveryService>((ref) {
  return RecoveryService(
    ref.watch(planRepositoryProvider),
    ref.watch(recoveryResolutionRepositoryProvider),
  );
});
