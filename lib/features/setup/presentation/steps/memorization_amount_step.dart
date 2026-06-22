import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/design/tokens/app_spacing.dart';
import '../../application/setup_providers.dart';
import '../../application/setup_target_config.dart';
import '../../domain/user_setup.dart';
import '../widgets/setup_custom_amount_selector.dart';
import '../widgets/setup_shared_widgets.dart';

class MemorizeAmountStep extends ConsumerWidget {
  const MemorizeAmountStep({super.key, required this.onNext});
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final setup = ref.watch(setupControllerProvider);
    final isCustomMode = ref.watch(memorizationCustomModeProvider);

    return StepScaffold(
      title: 'كم تحفظ في يوم الحفظ؟',
      subtitle: 'اختر مقداراً يناسب وقتك وتركيزك اليومي',
      content: Column(
        children: [
          PresetSelector(
            presets: memorizationPresets,
            selectedTarget: setup.memorizationTarget,
            isCustomSelected: isCustomMode,
            onPresetSelected: (preset) {
              ref.read(memorizationCustomModeProvider.notifier).state = preset.isCustom;
              if (!preset.isCustom) {
                ref.read(setupControllerProvider.notifier).setMemorizationTarget(preset.target);
              }
            },
          ),
          if (isCustomMode) ...[
            const SizedBox(height: AppSpacing.lg),
            SetupCustomAmountSelector(
              amount: setup.memorizationTarget.amount,
              config: customMemorizationUnits.firstWhere((u) => u.unit == ProgressUnit.page),
              onChanged: (val) => ref.read(setupControllerProvider.notifier).setMemorizationTarget(
                DailyTarget(amount: val, unit: ProgressUnit.page),
              ),
            ),
          ],
        ],
      ),
      actions: [PrimaryButton(label: 'التالي', onPressed: onNext)],
    );
  }
}
