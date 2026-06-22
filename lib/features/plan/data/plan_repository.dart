import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../../core/database/app_database.dart';
import '../domain/active_plan.dart';
import '../domain/day_assignment.dart';
import '../domain/plan_status.dart';
import 'plan_mappers.dart';

/// Repository responsible for plan-related database operations.
class PlanRepository {
  PlanRepository(this._db);

  final AppDatabase _db;
  final _uuid = const Uuid();

  /// Retrieves the current plan (active or paused), if any.
  Future<ActivePlanEntity?> getActivePlan() async {
    // 1. First, search for the latest active plan
    final activeQuery = _db.select(_db.activePlans)
      ..where((t) => t.status.equals(PlanStatus.active.name))
      ..orderBy([(t) => OrderingTerm(expression: t.createdAt, mode: OrderingMode.desc)])
      ..limit(1);
    
    final activeRow = await activeQuery.getSingleOrNull();
    if (activeRow != null) {
      return PlanMappers.activePlanFromDb(activeRow);
    }

    // 2. Fallback: search for the latest paused plan
    final pausedQuery = _db.select(_db.activePlans)
      ..where((t) => t.status.equals(PlanStatus.paused.name))
      ..orderBy([(t) => OrderingTerm(expression: t.createdAt, mode: OrderingMode.desc)])
      ..limit(1);

    final pausedRow = await pausedQuery.getSingleOrNull();
    if (pausedRow != null) {
      return PlanMappers.activePlanFromDb(pausedRow);
    }

    return null;
  }

  /// Creates a new active plan.
  /// Pauses any existing active or paused plans — enforces single-plan rule.
  Future<ActivePlanEntity> createActivePlan(ActivePlanEntity plan) async {
    return await _db.transaction(() async {
      await (_db.update(_db.activePlans)
            ..where((t) =>
                t.status.equals(PlanStatus.active.name) |
                t.status.equals(PlanStatus.paused.name)))
          .write(
        ActivePlansCompanion(
          status: Value(PlanStatus.paused.name),
          updatedAt: Value(DateTime.now()),
        ),
      );

      final companion = ActivePlansCompanion(
        id: Value(plan.id),
        createdAt: Value(plan.createdAt),
        updatedAt: Value(plan.updatedAt),
        status: Value(PlanStatus.active.name),
        memorizationAmount: Value(plan.memorizationTarget.amount),
        memorizationUnit: Value(plan.memorizationTarget.unit.name),
        reviewAmount: Value(plan.reviewTarget.amount),
        reviewUnit: Value(plan.reviewTarget.unit.name),
        memorizationStartSurah: Value(plan.startPosition.surahNumber),
        memorizationStartAyah: Value(plan.startPosition.ayahNumber),
        currentMemorizationSurah: Value(plan.currentPosition.surahNumber),
        currentMemorizationAyah: Value(plan.currentPosition.ayahNumber),
        memorizationDays:
            Value(PlanMappers.encodeDaySet(plan.memorizationDays)),
        reviewSchedule: Value(plan.reviewSchedule.persistenceKey),
        customReviewDays:
            Value(PlanMappers.encodeDaySet(plan.customReviewDays)),
        previousMemorizedRanges: Value(jsonEncode(
            plan.previousMemorizedRanges.map((r) => r.toMap()).toList())),
      );

      await _db.into(_db.activePlans).insert(companion);
      return plan;
    });
  }

  /// Updates an existing plan (status and current position only).
  Future<void> updateActivePlan(ActivePlanEntity plan) async {
    await (_db.update(_db.activePlans)..where((t) => t.id.equals(plan.id)))
        .write(
      ActivePlansCompanion(
        updatedAt: Value(DateTime.now()),
        status: Value(plan.status.name),
        currentMemorizationSurah: Value(plan.currentPosition.surahNumber),
        currentMemorizationAyah: Value(plan.currentPosition.ayahNumber),
      ),
    );
  }

  /// Retrieves an assignment for a specific date and plan.
  Future<DayAssignmentEntity?> getAssignmentByDate(
    String planId,
    String dateKey,
  ) async {
    final query = _db.select(_db.dayAssignments)
      ..where((t) => t.planId.equals(planId) & t.dateKey.equals(dateKey))
      ..limit(1);

    final row = await query.getSingleOrNull();
    return row != null ? PlanMappers.dayAssignmentFromDb(row) : null;
  }

  /// Persists a day assignment (insert or update on conflict).
  Future<void> saveAssignment(DayAssignmentEntity assignment) async {
    await _db.into(_db.dayAssignments).insertOnConflictUpdate(
          DayAssignmentsCompanion(
            id: Value(assignment.id),
            planId: Value(assignment.planId),
            dateKey: Value(assignment.dateKey),
            memorizationStartSurah: Value(assignment.memoStart.surahNumber),
            memorizationStartAyah: Value(assignment.memoStart.ayahNumber),
            memorizationEndSurah: Value(assignment.memoEnd.surahNumber),
            memorizationEndAyah: Value(assignment.memoEnd.ayahNumber),
            memorizationAmount: Value(assignment.memoTarget.amount),
            memorizationUnit: Value(assignment.memoTarget.unit.name),
            reviewAmount: Value(assignment.reviewTarget.amount),
            reviewUnit: Value(assignment.reviewTarget.unit.name),
            hasMemoTask: Value(assignment.hasMemoTask),
            hasReviewTask: Value(assignment.hasReviewTask),
            isMemorizationDone: Value(assignment.isMemoDone),
            isReviewDone: Value(assignment.isReviewDone),
            createdAt: Value(assignment.createdAt),
          ),
        );
  }

  /// Retrieves recent assignments for a plan, most recent first.
  Future<List<DayAssignmentEntity>> getRecentAssignments(
    String planId, {
    int limit = 30,
  }) async {
    final query = _db.select(_db.dayAssignments)
      ..where((t) => t.planId.equals(planId))
      ..orderBy([
        (t) => OrderingTerm(expression: t.dateKey, mode: OrderingMode.desc)
      ])
      ..limit(limit);

    final rows = await query.get();
    return rows.map(PlanMappers.dayAssignmentFromDb).toList();
  }

  /// Retrieves past assignments for a plan strictly before the given date key.
  Future<List<DayAssignmentEntity>> getPastAssignmentsForPlan({
    required String planId,
    required String beforeDateKey,
  }) async {
    final query = _db.select(_db.dayAssignments)
      ..where((t) => t.planId.equals(planId) & t.dateKey.isSmallerThanValue(beforeDateKey))
      ..orderBy([
        (t) => OrderingTerm(expression: t.dateKey, mode: OrderingMode.asc)
      ]);

    final rows = await query.get();
    return rows.map(PlanMappers.dayAssignmentFromDb).toList();
  }

  /// Returns true if the plan has at least one completed memorization assignment.
  Future<bool> hasCompletedMemorizationSession(String planId) async {
    final query = _db.select(_db.dayAssignments)
      ..where((t) =>
          t.planId.equals(planId) &
          t.hasMemoTask.equals(true) &
          t.isMemorizationDone.equals(true))
      ..limit(1);

    final row = await query.getSingleOrNull();
    return row != null;
  }

  String nextId() => _uuid.v4();
}
