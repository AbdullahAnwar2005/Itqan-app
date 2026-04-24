import '../../plan/application/plan_service.dart';
import '../../plan/data/plan_repository.dart';
import '../../plan/domain/active_plan.dart';
import '../domain/session.dart';

/// Application service for session-related business logic.
/// 
/// This service coordinates between the session feature and other features
/// like Plan and Today, ensuring controlled progression.
class SessionService {
  const SessionService({
    required PlanService planService,
    required PlanRepository planRepository,
  }) : _planService = planService,
       _planRepository = planRepository;

  final PlanService _planService;
  final PlanRepository _planRepository;

  /// Completes a session and updates the relevant plan/assignment data.
  Future<void> completeSession({
    required WorkSession session,
    required ActivePlanEntity plan,
  }) async {
    if (session.type == SessionType.memorization) {
      await _planService.toggleMemorization(
        plan: plan,
        assignment: session.assignment,
        isDone: true,
      );
    } else if (session.type == SessionType.review) {
      final updatedAssignment = session.assignment.copyWith(
        isReviewDone: true,
      );
      await _planRepository.saveAssignment(updatedAssignment);
    }
  }
}
