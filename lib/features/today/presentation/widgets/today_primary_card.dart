import 'package:flutter/material.dart';
import '../../../../core/design/tokens/app_radius.dart';
import '../../../../core/design/tokens/app_spacing.dart';
import '../../../../core/design/tokens/app_typography.dart';
import '../../domain/today_summary.dart';
import '../../domain/today_task.dart';

class TodayPrimaryCard extends StatelessWidget {
  const TodayPrimaryCard({
    super.key,
    required this.summary,
  });

  final TodaySummary summary;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    // Find specific tasks to show targets
    final memoTask = summary.tasks.where((t) => t.type == TodayTaskType.memorization).firstOrNull;
    final reviewTask = summary.tasks.where((t) => t.type == TodayTaskType.review).firstOrNull;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            theme.colorScheme.primary.withValues(alpha: 0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(AppRadius.lg),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.primary.withValues(alpha: 0.2),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'ورد اليوم',
                style: AppTypography.cardTitle.copyWith(
                  color: theme.colorScheme.onPrimary,
                ),
              ),
              if (summary.allCompleted)
                Icon(
                  Icons.stars_rounded,
                  color: theme.colorScheme.onPrimary,
                  size: 24,
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.xl),
          if (memoTask != null)
            _TargetRow(
              label: 'مقرر الحفظ',
              target: memoTask.targetDescription,
              isCompleted: memoTask.isCompleted,
              onPrimaryColor: theme.colorScheme.onPrimary,
            ),
          if (reviewTask != null) ...[
            const SizedBox(height: AppSpacing.md),
            _TargetRow(
              label: 'مراجعة اليوم',
              target: reviewTask.targetDescription,
              isCompleted: reviewTask.isCompleted,
              onPrimaryColor: theme.colorScheme.onPrimary,
            ),
          ],
          const SizedBox(height: AppSpacing.xl),
          _ProgressBar(
            progress: summary.progress,
            backgroundColor: theme.colorScheme.onPrimary.withValues(alpha: 0.15),
            foregroundColor: theme.colorScheme.onPrimary,
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                summary.allCompleted ? 'أتممت وردك اليوم!' : 'نسبة الإنجاز',
                style: AppTypography.label.copyWith(
                  color: theme.colorScheme.onPrimary.withValues(alpha: 0.9),
                ),
              ),
              Text(
                '${(summary.progress * 100).toInt()}%',
                style: AppTypography.label.copyWith(
                  color: theme.colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TargetRow extends StatelessWidget {
  const _TargetRow({
    required this.label,
    required this.target,
    required this.isCompleted,
    required this.onPrimaryColor,
  });

  final String label;
  final String target;
  final bool isCompleted;
  final Color onPrimaryColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: AppTypography.body.copyWith(
              color: onPrimaryColor.withValues(alpha: 0.8),
            ),
          ),
        ),
        Text(
          target,
          style: AppTypography.label.copyWith(
            color: onPrimaryColor,
            decoration: isCompleted ? TextDecoration.lineThrough : null,
          ),
        ),
        if (isCompleted) ...[
          const SizedBox(width: AppSpacing.xs),
          Icon(
            Icons.check_circle_outline_rounded,
            color: onPrimaryColor.withValues(alpha: 0.7),
            size: 14,
          ),
        ],
      ],
    );
  }
}

class _ProgressBar extends StatelessWidget {
  const _ProgressBar({
    required this.progress,
    required this.backgroundColor,
    required this.foregroundColor,
  });

  final double progress;
  final Color backgroundColor;
  final Color foregroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 8,
      width: double.infinity,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(AppRadius.full),
      ),
      child: FractionallySizedBox(
        alignment: AlignmentDirectional.centerStart,
        widthFactor: progress.clamp(0.0, 1.0),
        child: Container(
          decoration: BoxDecoration(
            color: foregroundColor,
            borderRadius: BorderRadius.circular(AppRadius.full),
            boxShadow: [
              BoxShadow(
                color: foregroundColor.withValues(alpha: 0.4),
                blurRadius: 4,
                offset: const Offset(0, 0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
