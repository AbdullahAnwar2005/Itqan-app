import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/design/tokens/app_colors.dart';
import '../../../../core/design/tokens/app_spacing.dart';
import '../../../../core/design/tokens/app_typography.dart';
import '../../application/setup_providers.dart';
import '../../domain/user_setup.dart';
import '../widgets/setup_day_selector.dart';
import '../widgets/setup_shared_widgets.dart';

class ReviewScheduleStep extends ConsumerWidget {
  const ReviewScheduleStep({super.key, required this.onBack, required this.onNext});
  final VoidCallback onBack;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final setup = ref.watch(setupControllerProvider);
    final isCustom = setup.reviewSchedule == ReviewSchedule.custom;
    final isValid = !isCustom || setup.customReviewDays.isNotEmpty;

    return StepScaffold(
      title: 'أيام المراجعة',
      subtitle: 'متى تود مراجعة ما حفظته؟',
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ...ReviewSchedule.values.map((s) => ChoiceCard(
            label: s.labelAr,
            selected: setup.reviewSchedule == s,
            onTap: () => ref.read(setupControllerProvider.notifier).setReviewSchedule(s),
          )),
          if (isCustom) ...[
            const SizedBox(height: AppSpacing.lg),
            SetupDaySelector(
              selectedDays: setup.customReviewDays,
              onChanged: (days) => ref.read(setupControllerProvider.notifier).setReviewSchedule(
                ReviewSchedule.custom,
                customDays: days,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            _buildSummary(setup.customReviewDays),
            if (!isValid) ...[
              const SizedBox(height: AppSpacing.lg),
              Text(
                'يرجى اختيار يوم واحد على الأقل للمراجعة',
                style: AppTypography.caption.copyWith(color: AppColors.error),
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ],
      ),
      actions: [
        PrimaryButton(
          label: 'التالي',
          onPressed: isValid ? onNext : null,
        ),
        SecondaryButton(label: 'رجوع', onPressed: onBack),
      ],
    );
  }

  Widget _buildSummary(Set<int> days) {
    if (days.isEmpty) return const SizedBox.shrink();
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.actionSecondary.withAlpha(20),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        'اخترت ${days.length} أيام في الأسبوع للمراجعة المخصصة',
        style: AppTypography.label.copyWith(color: AppColors.actionPrimary),
        textAlign: TextAlign.center,
      ),
    );
  }
}
