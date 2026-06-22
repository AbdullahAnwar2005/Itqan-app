import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:itqan/core/routing/app_router.dart';
import 'package:itqan/features/today/application/today_mode_provider.dart';
import 'package:itqan/features/today/application/today_providers.dart';
import 'package:itqan/features/today/domain/today_mode.dart';
import 'package:itqan/features/today/domain/today_summary.dart';
import 'package:itqan/features/today/domain/today_task.dart';

import '../../../core/design/components/itqan_top_app_bar.dart';
import '../../../core/design/tokens/app_spacing.dart';
import '../../../core/design/tokens/app_typography.dart';
import '../../plan/application/plan_providers.dart';
import '../../plan/domain/plan_status.dart';
import 'widgets/recovery_notice_card.dart';
import 'widgets/today_primary_card.dart';
import 'widgets/today_task_item.dart';

/// Today screen — the operational home of Itqan.
///
/// Displays the user's daily progress and tasks derived from their setup.
class TodayScreen extends ConsumerWidget {
  const TodayScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summary = ref.watch(todayControllerProvider);
    final activePlanAsync = ref.watch(activePlanProvider);

    return Scaffold(
      appBar: const ItqanTopAppBar(title: 'اليوم'),
      body: summary.when(
        data: (data) {
          // If it's a rest day and there are no recovery tasks, show rest day state
          // Actually, if it's a rest day but they have missed work, maybe they should see it?
          // The prompt didn't say to override rest day, but it makes sense to show it if they want to catch up.
          // For now, keep the rest day check but show recovery notice in TodayContent.
          if (data.isRestDay &&
              (data.recoveryNotice == null ||
                  !data.recoveryNotice!.hasMissedWork))
            return const _RestDayState();

          if (data.tasks.isEmpty &&
              (data.recoveryNotice == null ||
                  !data.recoveryNotice!.hasMissedWork)) {
            return activePlanAsync.when(
              data: (plan) {
                if (plan == null) return const _NoPlanState();
                if (plan.status == PlanStatus.paused)
                  return const _PausedPlanState();
                return const _NoTasksState();
              },
              loading: () =>
                  const Center(child: CircularProgressIndicator.adaptive()),
              error: (err, _) => const Center(
                child: Text(
                  'عذراً، تعذر تحميل الخطة الحالية.',
                  style: AppTypography.bodySmall,
                ),
              ),
            );
          }
          return _TodayContent(summary: data);
        },
        loading: () =>
            const Center(child: CircularProgressIndicator.adaptive()),
        error: (err, stack) => const Center(
          child: Text(
            'عذراً، حدث خطأ أثناء تحميل البيانات.',
            style: AppTypography.bodySmall,
          ),
        ),
      ),
    );
  }
}

class _TodayContent extends ConsumerWidget {
  const _TodayContent({required this.summary});

  final TodaySummary summary;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentMode = ref.watch(todayModeProvider);

    // Reorder tasks visually if in light recovery mode
    List<TodayTask> displayTasks = List.of(summary.tasks);
    if (currentMode == TodayMode.lightRecovery) {
      displayTasks.sort((a, b) {
        if (a.type == TodayTaskType.nearReview) return -1;
        if (b.type == TodayTaskType.nearReview) return 1;
        if (a.type == TodayTaskType.memorization) return 1;
        if (b.type == TodayTaskType.memorization) return -1;
        return 0;
      });
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.xl,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (summary.recoveryNotice != null &&
              summary.recoveryNotice!.hasMissedWork) ...[
            RecoveryNoticeCard(
              notice: summary.recoveryNotice!,
              recommendation: summary.recoveryRecommendation,
              isMemorizationDeferred: summary.isMemorizationDeferred,
              onDeferMemorization: () {
                ref.read(todayControllerProvider.notifier).deferMemorizationForToday();
              },
              onCancelMemorizationDefer: () {
                ref.read(todayControllerProvider.notifier).cancelMemorizationDeferForToday();
              },
              onResolveMissedWork: () {
                ref.read(todayControllerProvider.notifier).resolveMissedWork();
              },
            ),
            const SizedBox(height: AppSpacing.xl),
          ],
          if (!summary.isRestDay) TodayPrimaryCard(summary: summary),
          const SizedBox(height: AppSpacing.xxl),
          if (summary.isMemorizationDeferred) ...[
            Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(AppSpacing.md),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.pause_circle_outline,
                    color: Theme.of(context).hintColor,
                    size: 20,
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Text(
                    'تم تأجيل الحفظ الجديد لهذا اليوم',
                    style: AppTypography.bodySmall.copyWith(
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.md),
          ],
          Text(
            'مهام اليوم',
            style: AppTypography.cardTitle,
          ),
          const SizedBox(height: AppSpacing.lg),
          ...displayTasks.map(
            (task) => TodayTaskItem(
              task: task,
              onTap: () async {
                await ref
                    .read(todayControllerProvider.notifier)
                    .startTask(task.id);
                if (context.mounted) {
                  context.goNamed(AppRoutes.session);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _NoTasksState extends StatelessWidget {
  const _NoTasksState();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.calendar_today_outlined,
              size: 48,
              color: theme.hintColor.withValues(alpha: 0.5),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              'لا توجد مهام مجدولة اليوم.',
              textAlign: TextAlign.center,
              style: AppTypography.bodyLarge.copyWith(
                color: theme.hintColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NoPlanState extends StatelessWidget {
  const _NoPlanState();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.assignment_outlined,
              size: 48,
              color: theme.hintColor.withValues(alpha: 0.5),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              'لا توجد خطة نشطة حاليًا.',
              textAlign: TextAlign.center,
              style: AppTypography.bodyLarge.copyWith(color: theme.hintColor),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              'يمكنك إعداد خطة جديدة من صفحة الخطة.',
              textAlign: TextAlign.center,
              style: AppTypography.bodySmall.copyWith(color: theme.hintColor),
            ),
          ],
        ),
      ),
    );
  }
}

class _PausedPlanState extends StatelessWidget {
  const _PausedPlanState();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.pause_circle_outline,
              size: 48,
              color: Colors.orange.withValues(alpha: 0.5),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              'خطة الحفظ متوقفة حالياً.\nيمكنك استئنافها من تبويب الخطة.',
              textAlign: TextAlign.center,
              style: AppTypography.bodyLarge.copyWith(
                color: theme.hintColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RestDayState extends StatelessWidget {
  const _RestDayState();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.self_improvement_outlined,
              size: 48,
              color: theme.hintColor.withValues(alpha: 0.4),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              'ليس لديك ورد مجدول اليوم.',
              textAlign: TextAlign.center,
              style: AppTypography.bodyLarge.copyWith(color: theme.hintColor),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              'استرح وعد غداً بإذن الله.',
              textAlign: TextAlign.center,
              style: AppTypography.bodySmall.copyWith(color: theme.hintColor),
            ),
          ],
        ),
      ),
    );
  }
}
