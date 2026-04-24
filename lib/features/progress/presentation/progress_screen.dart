import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/design/components/itqan_top_app_bar.dart';
import '../../../core/design/tokens/app_spacing.dart';
import '../../../core/design/tokens/app_typography.dart';
import '../../../core/design/theme/itqan_theme_extension.dart';
import '../../../core/design/tokens/app_radius.dart';
import '../../../core/utils/arabic_formatter.dart';
import '../application/progress_providers.dart';
import '../domain/progress_models.dart';

class ProgressScreen extends ConsumerWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summaryAsync = ref.watch(progressSummaryProvider);

    return Scaffold(
      appBar: const ItqanTopAppBar(title: 'تقدمي'),
      body: summaryAsync.when(
        data: (summary) => summary == null
            ? const _NoProgressState()
            : _ProgressContent(summary: summary),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Error: $err')),
      ),
    );
  }
}

class _ProgressContent extends StatelessWidget {
  const _ProgressContent({required this.summary});

  final ProgressSummary summary;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _MemorizationPositionCard(snapshot: summary.memorization),
          const SizedBox(height: AppSpacing.lg),
          _RecentExecutionCard(activity: summary.recentActivity),
          const SizedBox(height: AppSpacing.lg),
          _ConsistencyCard(consistency: summary.consistency),
        ],
      ),
    );
  }
}

class _MemorizationPositionCard extends StatelessWidget {
  const _MemorizationPositionCard({required this.snapshot});

  final MemorizationProgressSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final itqanTheme = theme.extension<ItqanThemeExtension>()!;

    return Card(
      elevation: 0,
      color: theme.cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.lg),
        side: BorderSide(color: theme.dividerColor.withOpacity(0.1)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.menu_book_rounded, color: itqanTheme.memorizeActive),
                const SizedBox(width: AppSpacing.sm),
                Text('أين وصلت الآن؟', style: AppTypography.cardTitle),
              ],
            ),
            const SizedBox(height: AppSpacing.xl),
            _PositionStep(
              label: 'بدأت من',
              position: snapshot.startPosition,
              isActive: false,
            ),
            const _StepDivider(),
            _PositionStep(
              label: 'وصلت إلى',
              position: snapshot.currentPosition,
              isActive: true,
              color: itqanTheme.memorizeActive,
            ),
          ],
        ),
      ),
    );
  }
}

class _RecentExecutionCard extends StatelessWidget {
  const _RecentExecutionCard({required this.activity});

  final RecentActivitySummary activity;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final itqanTheme = theme.extension<ItqanThemeExtension>()!;

    return Card(
      elevation: 0,
      color: theme.cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.lg),
        side: BorderSide(color: theme.dividerColor.withOpacity(0.1)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('الإنجاز في الأيام السبعة الأخيرة',
                style: AppTypography.cardTitle),
            const SizedBox(height: AppSpacing.lg),
            _MetricRow(
              label: 'مهام حفظ منجزة',
              value: '${activity.completedMemorizationTasks}',
              icon: Icons.check_circle_outline,
              color: itqanTheme.memorizeActive,
            ),
            const SizedBox(height: AppSpacing.md),
            _MetricRow(
              label: 'مهام مراجعة منجزة',
              value: '${activity.completedReviewTasks}',
              icon: Icons.history,
              color: itqanTheme.reviewDue,
            ),
            const SizedBox(height: AppSpacing.md),
            _MetricRow(
              label: 'أيام مكتملة كلياً',
              value: '${activity.completedDays}',
              icon: Icons.calendar_today,
              color: itqanTheme.completed,
            ),
          ],
        ),
      ),
    );
  }
}

class _ConsistencyCard extends StatelessWidget {
  const _ConsistencyCard({required this.consistency});

  final ConsistencySummary consistency;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final itqanTheme = theme.extension<ItqanThemeExtension>()!;

    return Card(
      elevation: 0,
      color: theme.cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.lg),
        side: BorderSide(color: theme.dividerColor.withOpacity(0.1)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('الاستمرارية', style: AppTypography.cardTitle),
            const SizedBox(height: AppSpacing.lg),
            Row(
              children: [
                Expanded(
                  child: _BigMetric(
                    label: 'السلسلة الحالية',
                    value:
                        ArabicFormatter.formatDays(consistency.currentStreak),
                    color: itqanTheme.memorizeActive,
                  ),
                ),
                Container(
                    width: 1,
                    height: 40,
                    color: theme.dividerColor.withOpacity(0.2)),
                Expanded(
                  child: _BigMetric(
                    label: 'الأيام المكتملة',
                    value:
                        '${(consistency.completionRateRecent * 7).toInt()} من 7',
                    unit: 'أيام',
                    color: itqanTheme.completed,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _PositionStep extends StatelessWidget {
  const _PositionStep({
    required this.label,
    required this.position,
    required this.isActive,
    this.color,
  });

  final String label;
  final dynamic position;
  final bool isActive;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive ? color : theme.disabledColor.withOpacity(0.3),
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,
                style:
                    AppTypography.bodySmall.copyWith(color: theme.hintColor)),
            Text(
              ArabicFormatter.formatPosition(position),
              style: AppTypography.label.copyWith(
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _StepDivider extends StatelessWidget {
  const _StepDivider();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          const EdgeInsets.only(left: 5), // Align with center of 12px circle
      height: 20,
      width: 2,
      color: Theme.of(context).dividerColor.withOpacity(0.1),
    );
  }
}

class _MetricRow extends StatelessWidget {
  const _MetricRow({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20, color: color.withOpacity(0.7)),
        const SizedBox(width: AppSpacing.sm),
        Expanded(child: Text(label, style: AppTypography.bodySmall)),
        Text(value,
            style: AppTypography.label
                .copyWith(color: color, fontWeight: FontWeight.bold)),
      ],
    );
  }
}

class _BigMetric extends StatelessWidget {
  const _BigMetric({
    required this.label,
    required this.value,
    this.unit,
    required this.color,
  });

  final String label;
  final String value;
  final String? unit;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Text(label,
            style: AppTypography.bodySmall.copyWith(color: theme.hintColor)),
        const SizedBox(height: AppSpacing.xs),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(value,
                style: AppTypography.cardTitle
                    .copyWith(color: color, fontSize: 24)),
            if (unit != null) ...[
              const SizedBox(width: AppSpacing.xs),
              Text(unit!,
                  style:
                      AppTypography.bodySmall.copyWith(color: theme.hintColor)),
            ],
          ],
        ),
      ],
    );
  }
}

class _NoProgressState extends StatelessWidget {
  const _NoProgressState();

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
              Icons.bar_chart_rounded,
              size: 48,
              color: theme.hintColor.withOpacity(0.5),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              'ابدأ خطتك ونفذ مهامك لتظهر إحصائيات تقدمك هنا.',
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
