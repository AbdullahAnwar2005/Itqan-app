import '../../../core/database/app_database.dart';
import '../../setup/domain/user_setup.dart';
import '../domain/active_plan.dart';
import '../domain/day_assignment.dart';
import '../domain/plan_status.dart';
import '../domain/quran_position.dart';

/// Mappers to convert between database rows and domain entities.
class PlanMappers {
  const PlanMappers._();

  static ActivePlanEntity activePlanFromDb(ActivePlan data) {
    return ActivePlanEntity(
      id: data.id,
      createdAt: data.createdAt,
      updatedAt: data.updatedAt,
      status: PlanStatus.fromString(data.status),
      memorizationTarget: DailyTarget(
        amount: data.memorizationAmount,
        unit: ProgressUnit.values.firstWhere(
          (e) => e.name == data.memorizationUnit,
        ),
      ),
      reviewTarget: DailyTarget(
        amount: data.reviewAmount,
        unit: ProgressUnit.values.firstWhere(
          (e) => e.name == data.reviewUnit,
        ),
      ),
      startPosition: QuranPosition(
        surahNumber: data.memorizationStartSurah,
        ayahNumber: data.memorizationStartAyah,
      ),
      currentPosition: QuranPosition(
        surahNumber: data.currentMemorizationSurah,
        ayahNumber: data.currentMemorizationAyah,
      ),
    );
  }

  static DayAssignmentEntity dayAssignmentFromDb(DayAssignment data) {
    return DayAssignmentEntity(
      id: data.id,
      planId: data.planId,
      dateKey: data.dateKey,
      memoStart: QuranPosition(
        surahNumber: data.memorizationStartSurah,
        ayahNumber: data.memorizationStartAyah,
      ),
      memoEnd: QuranPosition(
        surahNumber: data.memorizationEndSurah,
        ayahNumber: data.memorizationEndAyah,
      ),
      memoTarget: DailyTarget(
        amount: data.memorizationAmount,
        unit: ProgressUnit.values.firstWhere(
          (e) => e.name == data.memorizationUnit,
        ),
      ),
      reviewTarget: DailyTarget(
        amount: data.reviewAmount,
        unit: ProgressUnit.values.firstWhere(
          (e) => e.name == data.reviewUnit,
        ),
      ),
      isMemoDone: data.isMemorizationDone,
      isReviewDone: data.isReviewDone,
      createdAt: data.createdAt,
    );
  }
}
