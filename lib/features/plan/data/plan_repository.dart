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
    final query = _db.select(_db.activePlans)
      ..where((t) => t.status.equals(PlanStatus.active.name) | t.status.equals(PlanStatus.paused.name))
      ..limit(1);

    final row = await query.getSingleOrNull();
    return row != null ? PlanMappers.activePlanFromDb(row) : null;
  }

  /// Creates a new active plan.
  /// Enforces the single-active-plan rule by pausing any existing active plans.
  Future<ActivePlanEntity> createActivePlan(ActivePlanEntity plan) async {
    return await _db.transaction(() async {
      await (_db.update(_db.activePlans)
            ..where((t) => t.status.equals(PlanStatus.active.name)))
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
      );

      await _db.into(_db.activePlans).insert(companion);
      return plan;
    });
  }

  /// Updates an existing plan.
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

  /// Persists a day assignment.
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
            isMemorizationDone: Value(assignment.isMemoDone),
            isReviewDone: Value(assignment.isReviewDone),
            createdAt: Value(assignment.createdAt),
          ),
        );
  }

  /// Retrieves a list of recent assignments for a plan.
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

  String nextId() => _uuid.v4();
}
