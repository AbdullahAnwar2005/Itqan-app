import 'package:flutter/material.dart';
import '../../../../core/design/tokens/app_radius.dart';
import '../../../../core/design/tokens/app_spacing.dart';
import '../../../../core/design/tokens/app_typography.dart';
import '../../../../core/design/theme/itqan_theme_extension.dart';
import '../../domain/today_task.dart';

class TodayTaskItem extends StatelessWidget {
  const TodayTaskItem({
    super.key,
    required this.task,
    required this.onTap,
  });

  final TodayTask task;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final itqanTheme = theme.extension<ItqanThemeExtension>()!;

    final taskColor = task.type == TodayTaskType.memorization
        ? itqanTheme.memorizeActive
        : itqanTheme.reviewDue;

    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(
          color: task.isCompleted
              ? itqanTheme.completed.withValues(alpha: 0.3)
              : theme.dividerColor.withValues(alpha: 0.08),
          width: 1,
        ),
        boxShadow: [
          if (!task.isCompleted)
            BoxShadow(
              color: theme.shadowColor.withValues(alpha: 0.03),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
        ],
      ),
      child: InkWell(
        onTap: task.isCompleted ? null : onTap,
        borderRadius: BorderRadius.circular(AppRadius.md),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Row(
            children: [
              _TaskTypeIndicator(
                type: task.type,
                activeColor: taskColor,
              ),
              const SizedBox(width: AppSpacing.lg),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.title,
                      style: AppTypography.label.copyWith(
                        color: task.isCompleted
                            ? theme.disabledColor
                            : theme.colorScheme.onSurface,
                        decoration: task.isCompleted
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      task.targetDescription,
                      style: AppTypography.bodySmall.copyWith(
                        color: theme.hintColor,
                      ),
                    ),
                  ],
                ),
              ),
              _CompletionAffordance(
                isCompleted: task.isCompleted,
                activeColor: itqanTheme.completed,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TaskTypeIndicator extends StatelessWidget {
  const _TaskTypeIndicator({
    required this.type,
    required this.activeColor,
  });

  final TodayTaskType type;
  final Color activeColor;

  @override
  Widget build(BuildContext context) {
    return Icon(
      type == TodayTaskType.memorization
          ? Icons.menu_book_rounded
          : Icons.history_rounded,
      color: activeColor.withValues(alpha: 0.8),
      size: 20,
    );
  }
}

class _CompletionAffordance extends StatelessWidget {
  const _CompletionAffordance({
    required this.isCompleted,
    required this.activeColor,
  });

  final bool isCompleted;
  final Color activeColor;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isCompleted ? activeColor : Colors.transparent,
        border: Border.all(
          color: isCompleted ? activeColor : activeColor.withValues(alpha: 0.3),
          width: 2,
        ),
      ),
      child: isCompleted
          ? const Icon(
              Icons.check,
              color: Colors.white,
              size: 16,
            )
          : null,
    );
  }
}
