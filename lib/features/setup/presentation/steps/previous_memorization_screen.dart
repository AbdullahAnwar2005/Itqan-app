import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/design/tokens/app_colors.dart';
import '../../../../core/design/tokens/app_spacing.dart';
import '../../../../core/design/tokens/app_typography.dart';

import '../../application/setup_providers.dart';
import '../widgets/setup_shared_widgets.dart';
import 'previous_memorization/previous_memorization_actions.dart';
import 'previous_memorization/previous_memorization_question.dart';
import 'previous_memorization/previous_memorization_summary.dart';

class PreviousMemorizationScreen extends ConsumerWidget {
  const PreviousMemorizationScreen({
    super.key,
    required this.onBack,
    required this.onNext,
  });

  final VoidCallback onBack;
  final VoidCallback onNext;

  void _handleNext(BuildContext context, WidgetRef ref) {
    final state = ref.read(setupControllerProvider);
    if (state.canContinueFromPreviousMemorization) {
      onNext();
    } else {
      // Show validation error only on explicit Next press
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'يرجى إضافة سورة واحدة على الأقل أو اختيار "البدء من الصفر"',
            style: AppTypography.caption.copyWith(color: Colors.white),
          ),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final setup = ref.watch(setupControllerProvider);

    return StepScaffold(
      title: 'هل لديك حفظ سابق؟',
      subtitle: 'سنستخدم هذا كمرجع للمراجعة فقط',
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const PreviousMemorizationQuestion(),
          if (setup.hasPreviousMemorization) ...[
            const SizedBox(height: AppSpacing.xl),
            const PreviousMemorizationActions(),
            const SizedBox(height: AppSpacing.xl),
            const PreviousMemorizationSummary(),
          ],
        ],
      ),
      actions: [
        PrimaryButton(
          label: 'التالي',
          onPressed: () => _handleNext(context, ref),
        ),
        SecondaryButton(label: 'رجوع', onPressed: onBack),
      ],
    );
  }
}
