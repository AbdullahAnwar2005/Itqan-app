import 'package:flutter_test/flutter_test.dart';
import 'package:itqan/features/plan/application/plan_service.dart';
import 'package:itqan/features/plan/data/plan_repository.dart';
import 'package:itqan/features/plan/domain/active_plan.dart';
import 'package:itqan/features/plan/domain/day_assignment.dart';
import 'package:itqan/features/plan/domain/plan_status.dart';
import 'package:itqan/features/plan/domain/quran_position.dart';
import 'package:itqan/features/progress/data/segment_progress_repository.dart';
import 'package:itqan/features/progress/domain/quran_segment_progress.dart';
import 'package:itqan/features/progress/domain/segment_progress_status.dart';
import 'package:itqan/features/progress/domain/segment_progress_source.dart';
import 'package:itqan/features/session/application/session_service.dart';
import 'package:itqan/features/session/data/session_repository.dart';
import 'package:itqan/features/session/domain/session.dart';
import 'package:itqan/features/session/domain/session_log.dart';
import 'package:itqan/features/session/domain/session_rating.dart';
import 'package:itqan/features/setup/domain/user_setup.dart';

void main() {
  late SessionService sessionService;
  late MockPlanService mockPlanService;
  late MockPlanRepository mockPlanRepository;
  late MockSessionRepository mockSessionRepository;
  late MockSegmentProgressRepository mockSegmentProgressRepository;

  setUp(() {
    mockPlanService = MockPlanService();
    mockPlanRepository = MockPlanRepository();
    mockSessionRepository = MockSessionRepository();
    mockSegmentProgressRepository = MockSegmentProgressRepository();

    sessionService = SessionService(
      planService: mockPlanService,
      planRepository: mockPlanRepository,
      sessionRepository: mockSessionRepository,
      segmentProgressRepository: mockSegmentProgressRepository,
    );
  });

  group('SessionService - Complete Session (Phase 3)', () {
    test('memorization + easy creates segment progress with stable/3', () async {
      final session = _createSession();
      final plan = _mockPlan();

      await sessionService.completeSession(session: session, plan: plan, rating: SessionRating.easy);

      expect(mockSegmentProgressRepository.upsertedSegments.length, 1);
      final segment = mockSegmentProgressRepository.upsertedSegments.first;
      expect(segment.status, SegmentProgressStatus.stable);
      expect(segment.masteryScore, 3);
      expect(mockPlanService.completeMemorizationCalled, isTrue);
    });

    test('memorization + good creates segment progress with stabilizing/2', () async {
      mockPlanService.completeMemorizationCalled = false;
      final session = _createSession();
      final plan = _mockPlan();

      await sessionService.completeSession(session: session, plan: plan, rating: SessionRating.good);

      expect(mockSegmentProgressRepository.upsertedSegments.length, 1);
      final segment = mockSegmentProgressRepository.upsertedSegments.first;
      expect(segment.status, SegmentProgressStatus.stabilizing);
      expect(segment.masteryScore, 2);
      expect(mockPlanService.completeMemorizationCalled, isTrue);
    });

    test('memorization + hard creates segment progress with weak/1', () async {
      mockPlanService.completeMemorizationCalled = false;
      final session = _createSession();
      final plan = _mockPlan();

      await sessionService.completeSession(session: session, plan: plan, rating: SessionRating.hard);

      expect(mockSegmentProgressRepository.upsertedSegments.length, 1);
      final segment = mockSegmentProgressRepository.upsertedSegments.first;
      expect(segment.status, SegmentProgressStatus.weak);
      expect(segment.masteryScore, 1);
      expect(mockPlanService.completeMemorizationCalled, isTrue);
    });

    test('memorization + again creates segment progress with needsRetry/0 and DOES NOT advance pointer', () async {
      mockPlanService.completeMemorizationCalled = false;
      final session = _createSession();
      final plan = _mockPlan();

      await sessionService.completeSession(session: session, plan: plan, rating: SessionRating.again);

      expect(mockSegmentProgressRepository.upsertedSegments.length, 1);
      final segment = mockSegmentProgressRepository.upsertedSegments.first;
      expect(segment.status, SegmentProgressStatus.needsRetry);
      expect(segment.masteryScore, 0);
      expect(mockPlanService.completeMemorizationCalled, isFalse);
    });

    test('repeated session for same range updates existing segment progress', () async {
      final session = _createSession();
      final plan = _mockPlan();
      
      final existingSegment = QuranSegmentProgress(
        id: 'existing-id',
        planId: plan.id,
        startPosition: session.assignment.memoStart,
        endPosition: session.assignment.memoEnd,
        status: SegmentProgressStatus.weak,
        masteryScore: 1,
        lastRating: SessionRating.hard,
        lastPracticedAt: DateTime.now().subtract(const Duration(days: 1)),
        nextReviewAt: DateTime.now(),
        source: SegmentProgressSource.appMemorization,
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
        updatedAt: DateTime.now().subtract(const Duration(days: 1)),
      );
      
      mockSegmentProgressRepository.existingSegment = existingSegment;

      await sessionService.completeSession(session: session, plan: plan, rating: SessionRating.good);

      expect(mockSegmentProgressRepository.upsertedSegments.length, 1);
      final segment = mockSegmentProgressRepository.upsertedSegments.first;
      expect(segment.id, 'existing-id'); // ID preserved
      expect(segment.createdAt, existingSegment.createdAt); // createdAt preserved
      expect(segment.status, SegmentProgressStatus.stabilizing); // Updated
      expect(segment.masteryScore, 2); // Updated
    });

    test('review sessions without specific range do not create segment progress', () async {
      final session = WorkSession(
        id: 'session-rev',
        type: SessionType.review,
        assignment: _mockAssignment(),
        status: SessionStatus.inProgress,
      );
      final plan = _mockPlan();

      await sessionService.completeSession(session: session, plan: plan, rating: SessionRating.hard);

      expect(mockSegmentProgressRepository.upsertedSegments.isEmpty, isTrue);
      expect(mockPlanRepository.savedAssignments.length, 1);
      expect(mockPlanRepository.savedAssignments.first.isReviewDone, isTrue);
    });

    test('near review sessions with specific range create segment progress and DO NOT advance assignment review', () async {
      mockPlanRepository.savedAssignments.clear();
      
      final session = WorkSession(
        id: 'session-near-rev',
        type: SessionType.review,
        assignment: _mockAssignment(),
        status: SessionStatus.inProgress,
        reviewStart: const QuranPosition(surahNumber: 2, ayahNumber: 1),
        reviewEnd: const QuranPosition(surahNumber: 2, ayahNumber: 5),
      );
      final plan = _mockPlan();

      await sessionService.completeSession(session: session, plan: plan, rating: SessionRating.hard);

      expect(mockSegmentProgressRepository.upsertedSegments.length, 1);
      final segment = mockSegmentProgressRepository.upsertedSegments.first;
      expect(segment.status, SegmentProgressStatus.weak);
      expect(segment.masteryScore, 1);
      expect(segment.startPosition, const QuranPosition(surahNumber: 2, ayahNumber: 1));
      
      // Old review behavior is bypassed
      expect(mockPlanRepository.savedAssignments.isEmpty, isTrue);
    });

    test('old review sessions with segmentProgressId update segment progress and PRESERVE source', () async {
      mockPlanRepository.savedAssignments.clear();
      
      final session = WorkSession(
        id: 'session-old-rev',
        type: SessionType.review,
        assignment: _mockAssignment(),
        status: SessionStatus.inProgress,
        reviewStart: const QuranPosition(surahNumber: 2, ayahNumber: 1),
        reviewEnd: const QuranPosition(surahNumber: 2, ayahNumber: 5),
        segmentProgressId: 'seg-old-1',
      );
      final plan = _mockPlan();

      final existingSegment = QuranSegmentProgress(
        id: 'seg-old-1',
        planId: plan.id,
        startPosition: session.reviewStart!,
        endPosition: session.reviewEnd!,
        status: SegmentProgressStatus.weak,
        masteryScore: 1,
        lastRating: SessionRating.hard,
        lastPracticedAt: DateTime.now().subtract(const Duration(days: 1)),
        nextReviewAt: DateTime.now(),
        source: SegmentProgressSource.previousMemorization,
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
        updatedAt: DateTime.now().subtract(const Duration(days: 1)),
      );
      mockSegmentProgressRepository.existingSegment = existingSegment;

      await sessionService.completeSession(session: session, plan: plan, rating: SessionRating.good);

      expect(mockSegmentProgressRepository.upsertedSegments.length, 1);
      final segment = mockSegmentProgressRepository.upsertedSegments.first;
      
      // Values should be updated
      expect(segment.status, SegmentProgressStatus.stabilizing);
      expect(segment.masteryScore, 2);
      
      // Source should be preserved
      expect(segment.source, SegmentProgressSource.previousMemorization);
      
      // Old review assignment is bypassed
      expect(mockPlanRepository.savedAssignments.isEmpty, isTrue);
      // pointer is not advanced
      expect(mockPlanService.completeMemorizationCalled, isFalse);
    });
  });
}

class MockPlanService implements PlanService {
  bool completeMemorizationCalled = false;

  @override
  Future<void> completeMemorization({required ActivePlanEntity plan, required DayAssignmentEntity assignment}) async {
    completeMemorizationCalled = true;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class MockPlanRepository implements PlanRepository {
  List<DayAssignmentEntity> savedAssignments = [];

  @override
  Future<void> saveAssignment(DayAssignmentEntity assignment) async {
    savedAssignments.add(assignment);
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class MockSessionRepository implements SessionRepository {
  List<SessionLogEntry> savedLogs = [];

  @override
  Future<void> saveSessionLog(SessionLogEntry entry) async {
    savedLogs.add(entry);
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class MockSegmentProgressRepository implements SegmentProgressRepository {
  List<QuranSegmentProgress> upsertedSegments = [];
  QuranSegmentProgress? existingSegment;

  @override
  Future<void> upsertSegmentProgress(QuranSegmentProgress segment) async {
    upsertedSegments.add(segment);
  }

  @override
  Future<QuranSegmentProgress?> getSegmentProgressForRange(String planId, int startSurah, int startAyah, int endSurah, int endAyah) async {
    return existingSegment;
  }
  
  @override
  Future<QuranSegmentProgress?> getSegmentProgressById(String id) async {
    if (existingSegment?.id == id) {
      return existingSegment;
    }
    return null;
  }
  
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

WorkSession _createSession() {
  return WorkSession(
    id: 'session-1',
    type: SessionType.memorization,
    assignment: _mockAssignment(),
    status: SessionStatus.inProgress,
  );
}

ActivePlanEntity _mockPlan() {
  return ActivePlanEntity(
    id: 'plan-1',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    status: PlanStatus.active,
    memorizationTarget: const DailyTarget(amount: 5, unit: ProgressUnit.ayah),
    reviewTarget: const DailyTarget(amount: 1, unit: ProgressUnit.juz),
    startPosition: const QuranPosition(surahNumber: 1, ayahNumber: 1),
    currentPosition: const QuranPosition(surahNumber: 1, ayahNumber: 1),
    memorizationDays: const {1, 2, 3, 4, 5, 6, 7},
    reviewSchedule: ReviewSchedule.everyday,
    customReviewDays: const {},
    previousMemorizedRanges: const [],
  );
}

DayAssignmentEntity _mockAssignment() {
  return DayAssignmentEntity(
    id: 'a1',
    planId: 'plan-1',
    dateKey: '2023-01-01',
    memoStart: const QuranPosition(surahNumber: 1, ayahNumber: 1),
    memoEnd: const QuranPosition(surahNumber: 1, ayahNumber: 5),
    memoTarget: const DailyTarget(amount: 5, unit: ProgressUnit.ayah),
    reviewTarget: const DailyTarget(amount: 1, unit: ProgressUnit.juz),
    isMemoDone: false,
    isReviewDone: false,
    createdAt: DateTime.now(),
  );
}
