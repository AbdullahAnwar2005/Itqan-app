import 'package:uuid/uuid.dart';

import '../../plan/application/plan_service.dart';
import '../../plan/data/plan_repository.dart';
import '../../plan/domain/active_plan.dart';
import '../../progress/application/segment_progress_policy.dart';
import '../../progress/data/segment_progress_repository.dart';
import '../../progress/domain/quran_segment_progress.dart';
import '../../progress/domain/segment_progress_source.dart';
import '../data/session_repository.dart';
import '../domain/session.dart';
import '../domain/session_log.dart';
import '../domain/session_rating.dart';

/// Application service for session-related business logic.
///
/// This service coordinates between the session feature and other features
/// like Plan and Today, ensuring controlled progression.
class SessionService {
  const SessionService({
    required PlanService planService,
    required PlanRepository planRepository,
    required SessionRepository sessionRepository,
    required SegmentProgressRepository segmentProgressRepository,
  })  : _planService = planService,
        _planRepository = planRepository,
        _sessionRepository = sessionRepository,
        _segmentProgressRepository = segmentProgressRepository;

  final PlanService _planService;
  final PlanRepository _planRepository;
  final SessionRepository _sessionRepository;
  final SegmentProgressRepository _segmentProgressRepository;
  final SegmentProgressPolicy _policy = const SegmentProgressPolicy();

  /// Completes a session and updates the relevant plan/assignment data.
  Future<void> completeSession({
    required WorkSession session,
    required ActivePlanEntity plan,
    required SessionRating rating,
  }) async {
    final now = DateTime.now();

    // 1. Write the session log
    final logEntry = SessionLogEntry(
      id: const Uuid().v4(),
      assignmentId: session.assignment.id,
      planId: plan.id,
      sessionType: session.type,
      startPosition: session.type == SessionType.memorization
          ? session.assignment.memoStart
          : session.reviewStart,
      endPosition: session.type == SessionType.memorization
          ? session.assignment.memoEnd
          : session.reviewEnd,
      rating: rating,
      completedAt: now,
      createdAt: now,
    );
    await _sessionRepository.saveSessionLog(logEntry);

    // 2. Rating-aware completion behavior
    if (session.type == SessionType.memorization) {
      // Upsert QuranSegmentProgress based on rating using policy
      final decision = _policy.fromRating(rating, now);

      final existingProgress =
          await _segmentProgressRepository.getSegmentProgressForRange(
        plan.id,
        session.assignment.memoStart.surahNumber,
        session.assignment.memoStart.ayahNumber,
        session.assignment.memoEnd.surahNumber,
        session.assignment.memoEnd.ayahNumber,
      );

      final progressId = existingProgress?.id ?? const Uuid().v4();
      final createdAt = existingProgress?.createdAt ?? now;

      final segmentProgress = QuranSegmentProgress(
        id: progressId,
        planId: plan.id,
        startPosition: session.assignment.memoStart,
        endPosition: session.assignment.memoEnd,
        status: decision.status,
        masteryScore: decision.masteryScore,
        lastRating: rating,
        lastPracticedAt: now,
        nextReviewAt: decision.nextReviewAt,
        source: SegmentProgressSource.appMemorization,
        createdAt: createdAt,
        updatedAt: now,
      );

      await _segmentProgressRepository.upsertSegmentProgress(segmentProgress);

      if (rating == SessionRating.again) {
        // If the user selects "again" (لم أتمكن), we only log the attempt.
        // We do NOT mark the assignment as done, and we do NOT advance the pointer.
        return;
      }

      // For easy, good, hard: mark done and advance pointer
      await _planService.completeMemorization(
        plan: plan,
        assignment: session.assignment,
      );
    } else if (session.type == SessionType.review) {
      if (session.reviewStart != null && session.reviewEnd != null) {
        // This is a Specific Near Review task
        final decision = _policy.fromRating(rating, now);

        QuranSegmentProgress? existingProgress;
        if (session.segmentProgressId != null) {
          existingProgress = await _segmentProgressRepository
              .getSegmentProgressById(session.segmentProgressId!);
        }

        if (existingProgress == null) {
          existingProgress =
              await _segmentProgressRepository.getSegmentProgressForRange(
            plan.id,
            session.reviewStart!.surahNumber,
            session.reviewStart!.ayahNumber,
            session.reviewEnd!.surahNumber,
            session.reviewEnd!.ayahNumber,
          );
        }

        final progressId = existingProgress?.id ?? const Uuid().v4();
        final createdAt = existingProgress?.createdAt ?? now;
        final source =
            existingProgress?.source ?? SegmentProgressSource.appMemorization;

        final segmentProgress = QuranSegmentProgress(
          id: progressId,
          planId: plan.id,
          startPosition: session.reviewStart!,
          endPosition: session.reviewEnd!,
          status: decision.status,
          masteryScore: decision.masteryScore,
          lastRating: rating,
          lastPracticedAt: now,
          nextReviewAt: decision.nextReviewAt,
          source: source,
          createdAt: createdAt,
          updatedAt: now,
        );

        await _segmentProgressRepository.upsertSegmentProgress(segmentProgress);
      } else {
        // Keep current behavior for old generic review
        // Guard against duplicate review completion
        if (session.assignment.isReviewDone) return;

        final updatedAssignment = session.assignment.copyWith(
          isReviewDone: true,
        );
        await _planRepository.saveAssignment(updatedAssignment);
      }
    }
  }
}
