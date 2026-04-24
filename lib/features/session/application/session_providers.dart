import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../plan/application/plan_providers.dart';
import '../../plan/domain/day_assignment.dart';
import '../domain/session.dart';
import 'session_service.dart';

/// Manages the active session state.
/// 
/// Orchestrates the session lifecycle and delegates persistence and 
/// complex logic to [SessionService].
class SessionController extends Notifier<WorkSession?> {
  @override
  WorkSession? build() {
    return null;
  }

  /// Starts a new session for a specific assignment and type.
  void startSession(DayAssignmentEntity assignment, SessionType type) {
    state = WorkSession(
      id: const Uuid().v4(),
      type: type,
      assignment: assignment,
      status: SessionStatus.inProgress,
      startedAt: DateTime.now(),
    );
  }

  /// Completes the active session and updates persistence via [SessionService].
  Future<void> completeSession() async {
    final current = state;
    if (current == null || current.status != SessionStatus.inProgress) return;

    final plan = await ref.read(activePlanProvider.future);
    if (plan == null) return;

    await ref.read(sessionServiceProvider).completeSession(
      session: current,
      plan: plan,
    );

    state = current.copyWith(
      status: SessionStatus.completed,
      endedAt: DateTime.now(),
    );

    // Refresh related data
    ref.invalidate(todayAssignmentProvider);
    ref.invalidate(activePlanProvider);
  }

  /// Cancels the active session without saving progress.
  void cancelSession() {
    final current = state;
    if (current == null) return;

    state = current.copyWith(
      status: SessionStatus.canceled,
      endedAt: DateTime.now(),
    );
  }

  /// Resets the session state (clears it).
  void reset() {
    state = null;
  }
}

/// Provides the [SessionService] instance.
final sessionServiceProvider = Provider<SessionService>((ref) {
  return SessionService(
    planService: ref.watch(planServiceProvider),
    planRepository: ref.watch(planRepositoryProvider),
  );
});

/// Provides the active [WorkSession].
final sessionControllerProvider =
    NotifierProvider<SessionController, WorkSession?>(SessionController.new);
