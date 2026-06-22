import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/design/tokens/app_colors.dart';
import '../../../../../core/design/tokens/app_spacing.dart';
import '../../../../../core/design/tokens/app_typography.dart';
import '../../../../../core/utils/arabic_formatter.dart';
import '../../../application/setup_providers.dart';

class SuggestedStartPositionCard extends ConsumerWidget {
  const SuggestedStartPositionCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final setup = ref.watch(setupControllerProvider);
    final suggested = setup.suggestedStartPosition;

    if (suggested == null || !setup.hasPreviousMemorization) {
      return const SizedBox.shrink();
    }

    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.actionSecondary.withAlpha(20),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.actionSecondary.withAlpha(50)),
      ),
      child: Row(
        children: [
          const Icon(Icons.lightbulb_outline, color: AppColors.actionPrimary),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('البداية المقترحة لك', style: AppTypography.label),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  ArabicFormatter.formatPosition(suggested),
                  style: AppTypography.caption,
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {
              ref.read(setupControllerProvider.notifier).useSuggestedStartPosition();
            },
            child: const Text('استخدام'),
          ),
        ],
      ),
    );
  }
}
