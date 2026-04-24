import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:itqan/core/routing/app_router.dart';
import 'package:itqan/features/today/application/today_providers.dart';
import 'package:itqan/features/today/domain/today_summary.dart';

import '../../../core/design/components/itqan_top_app_bar.dart';
import '../../../core/design/tokens/app_spacing.dart';
import '../../../core/design/tokens/app_typography.dart';
import '../../plan/application/plan_providers.dart';
import '../../plan/domain/plan_status.dart';
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
        data: (data) => data.tasks.isEmpty
            ? activePlanAsync.when(
                data: (plan) {
                  if (plan == null) return const _NoPlanState();
                  if (plan.status == PlanStatus.paused) return const _PausedPlanState();
                  return const _NoTasksState();
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, _) => Center(child: Text('Error: $err')),
              )
            : _TodayContent(summary: data),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
}

class _TodayContent extends ConsumerWidget {
  const _TodayContent({required this.summary});

  final TodaySummary summary;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.xl,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TodayPrimaryCard(summary: summary),
          const SizedBox(height: AppSpacing.xxl),
          Text(
            'مهام اليوم',
            style: AppTypography.cardTitle,
          ),
          const SizedBox(height: AppSpacing.lg),
          ...summary.tasks.map(
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
              color: theme.hintColor.withOpacity(0.5),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              'لا توجد مهام مجدولة لليوم.',
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
              color: theme.hintColor.withOpacity(0.5),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              'لم تقم بإنشاء خطة حفظ بعد.\nيرجى الانتقال لتبويب الخطة للبدء.',
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
              color: Colors.orange.withOpacity(0.5),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              'خطتك متوقفة حالياً.\nيمكنك استئنافها من تبويب الخطة.',
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
