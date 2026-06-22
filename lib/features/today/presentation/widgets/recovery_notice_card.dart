import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/design/tokens/app_radius.dart';
import '../../../../core/design/tokens/app_spacing.dart';
import '../../../../core/design/tokens/app_typography.dart';
import '../../application/today_mode_provider.dart';
import '../../domain/recovery_notice.dart';
import '../../domain/today_mode.dart';
import '../../domain/recovery_recommendation.dart';

class RecoveryNoticeCard extends ConsumerWidget {
  const RecoveryNoticeCard({
    super.key,
    required this.notice,
    required this.isMemorizationDeferred,
    required this.onDeferMemorization,
    required this.onCancelMemorizationDefer,
    required this.onResolveMissedWork,
    this.recommendation,
  });

  final RecoveryNotice notice;
  final bool isMemorizationDeferred;
  final VoidCallback onDeferMemorization;
  final VoidCallback onCancelMemorizationDefer;
  final VoidCallback onResolveMissedWork;
  final RecoveryRecommendation? recommendation;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final currentMode = ref.watch(todayModeProvider);

    if (currentMode == TodayMode.lightRecovery) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: colorScheme.tertiaryContainer.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.info_outline, color: colorScheme.tertiary, size: 20),
                const SizedBox(width: AppSpacing.sm),
                Text(
                  'وضع الخطة الخفيفة مفعّل لهذا اليوم',
                  style: AppTypography.label.copyWith(
                    color: colorScheme.onTertiaryContainer,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              'سنركّز اليوم على التثبيت والمراجعة، ويمكنك الرجوع للخطة المعتادة متى أردت.',
              style: AppTypography.bodySmall.copyWith(
                color: colorScheme.onTertiaryContainer,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Row(
              children: [
                InkWell(
                  onTap: () => ref.read(todayModeProvider.notifier).state = TodayMode.normal,
                  child: Text(
                    'إلغاء وضع الخطة الخفيفة',
                    style: AppTypography.label.copyWith(
                      color: colorScheme.tertiary,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                const Spacer(),
                if (isMemorizationDeferred)
                  InkWell(
                    onTap: onCancelMemorizationDefer,
                    child: Text(
                      'إلغاء التأجيل',
                      style: AppTypography.label.copyWith(
                        color: colorScheme.tertiary,
                        decoration: TextDecoration.underline,
                    ),
                  ),
                )
                else
                  InkWell(
                    onTap: onDeferMemorization,
                    child: Text(
                      'تأجيل الحفظ اليوم',
                      style: AppTypography.label.copyWith(
                        color: colorScheme.tertiary,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      );
    }

    final isHeavy = recommendation?.severity == RecoverySeverity.heavy;
    final cardBgColor = isHeavy
        ? colorScheme.tertiaryContainer.withValues(alpha: 0.3)
        : colorScheme.surfaceContainerHighest.withValues(alpha: 0.5);
    final cardBorderColor = isHeavy
        ? colorScheme.tertiary.withValues(alpha: 0.3)
        : colorScheme.outlineVariant.withValues(alpha: 0.5);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: cardBgColor,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(
          color: cardBorderColor,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.restore_rounded,
                color: isHeavy ? colorScheme.tertiary : colorScheme.primary,
                size: 24,
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(
                recommendation?.title ?? 'رجوع للخطة',
                style: AppTypography.pageTitle.copyWith(
                  color: colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            recommendation?.message ??
                'لديك مهام سابقة لم تكتمل. نقترح اليوم التركيز على التثبيت والمراجعة قبل زيادة الحفظ الجديد.',
            style: AppTypography.body.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          if (recommendation != null && recommendation!.steps.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.md),
            ...recommendation!.steps.map((step) => Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.xs),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '• ',
                        style: AppTypography.bodySmall.copyWith(
                          color: colorScheme.onSurfaceVariant,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          step,
                          style: AppTypography.bodySmall.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          ],
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              _StatItem(
                label: 'أيام فائتة',
                value: notice.missedDaysCount.toString(),
              ),
              const SizedBox(width: AppSpacing.xl),
              if (notice.missedMemorizationCount > 0) ...[
                _StatItem(
                  label: 'مهام حفظ فائتة',
                  value: notice.missedMemorizationCount.toString(),
                ),
                const SizedBox(width: AppSpacing.xl),
              ],
              if (notice.missedReviewCount > 0)
                _StatItem(
                  label: 'مهام مراجعة فائتة',
                  value: notice.missedReviewCount.toString(),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          Row(
            children: [
              Expanded(
                child: FilledButton(
                  onPressed: () {
                    ref.read(todayModeProvider.notifier).state = TodayMode.lightRecovery;
                  },
                  child: const Text('خطة خفيفة اليوم'),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    ref.read(todayModeProvider.notifier).state = TodayMode.normal;
                  },
                  child: const Text('أكمل كالمعتاد'),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Center(
            child: isMemorizationDeferred
                ? InkWell(
                    onTap: onCancelMemorizationDefer,
                    child: Text(
                      'إلغاء التأجيل',
                      style: AppTypography.label.copyWith(
                        color: colorScheme.primary,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  )
                : InkWell(
                    onTap: onDeferMemorization,
                    child: Text(
                      'تأجيل الحفظ اليوم',
                      style: AppTypography.label.copyWith(
                        color: colorScheme.primary,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
          ),
          const SizedBox(height: AppSpacing.md),
          Center(
            child: InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('تجاوز المهام الفائتة؟'),
                    content: const Text(
                        'لن يتم احتساب المهام السابقة كمكتملة، لكن لن تظهر لك كتنبيه رجوع للخطة بعد الآن.'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('إلغاء'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          onResolveMissedWork();
                        },
                        child: const Text('تجاوز المهام'),
                      ),
                    ],
                  ),
                );
              },
              child: Text(
                'تجاوز المهام الفائتة',
                style: AppTypography.label.copyWith(
                  color: colorScheme.error,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  const _StatItem({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '$label: ',
          style: AppTypography.label.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        Text(
          value,
          style: AppTypography.label.copyWith(
            color: colorScheme.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
