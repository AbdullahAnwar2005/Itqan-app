import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/design/tokens/app_spacing.dart';
import '../../application/setup_providers.dart';
import '../../application/setup_target_config.dart';
import '../../domain/user_setup.dart';
import '../widgets/setup_custom_amount_selector.dart';
import '../widgets/setup_shared_widgets.dart';

class ReviewAmountStep extends ConsumerWidget {
  const ReviewAmountStep({super.key, required this.onBack, required this.onNext});
  final VoidCallback onBack;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final setup = ref.watch(setupControllerProvider);
    final isCustomMode = ref.watch(reviewCustomModeProvider);

    return StepScaffold(
      title: 'كم تراجع في يوم المراجعة؟',
      subtitle: 'المراجعة المنتظمة هي سر التثبيت',
      content: Column(
        children: [
          PresetSelector(
            presets: reviewPresets,
            selectedTarget: setup.reviewTarget,
            isCustomSelected: isCustomMode,
            onPresetSelected: (preset) {
              ref.read(reviewCustomModeProvider.notifier).state = preset.isCustom;
              if (!preset.isCustom) {
                ref.read(setupControllerProvider.notifier).setReviewTarget(preset.target);
              }
            },
          ),
          if (isCustomMode) ...[
            const SizedBox(height: AppSpacing.lg),
            SetupCustomAmountSelector(
              amount: setup.reviewTarget.amount,
              config: customReviewUnits.firstWhere((u) => u.unit == ProgressUnit.page),
              onChanged: (val) => ref.read(setupControllerProvider.notifier).setReviewTarget(
                DailyTarget(amount: val, unit: ProgressUnit.page),
              ),
            ),
          ],
        ],
      ),
      actions: [
        PrimaryButton(label: 'التالي', onPressed: onNext),
        SecondaryButton(label: 'رجوع', onPressed: onBack),
      ],
    );
  }
}
