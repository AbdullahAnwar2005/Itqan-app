import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/design/tokens/app_colors.dart';
import '../../../../core/design/tokens/app_spacing.dart';
import '../../../../core/design/tokens/app_typography.dart';
import '../../application/setup_providers.dart';
import '../widgets/setup_day_selector.dart';
import '../widgets/setup_shared_widgets.dart';

class MemorizationDaysStep extends ConsumerWidget {
  const MemorizationDaysStep({super.key, required this.onBack, required this.onNext});
  final VoidCallback onBack;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final setup = ref.watch(setupControllerProvider);
    final days = setup.memorizationDays;
    final isValid = days.isNotEmpty;

    return StepScaffold(
      title: 'أيام الحفظ',
      subtitle: 'في أي أيام من الأسبوع تود الحفظ؟',
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildPresets(ref, days),
          const SizedBox(height: AppSpacing.lg),
          SetupDaySelector(
            selectedDays: days,
            onChanged: (newDays) => ref.read(setupControllerProvider.notifier).setMemorizationDays(newDays),
          ),
          const SizedBox(height: AppSpacing.lg),
          _buildSummary(days),
          const SizedBox(height: AppSpacing.md),
          Text(
            'ابدأ بعدد أيام يمكنك الالتزام به',
            style: AppTypography.caption.copyWith(color: AppColors.textSecondary),
            textAlign: TextAlign.center,
          ),
          if (!isValid) ...[
            const SizedBox(height: AppSpacing.lg),
            Text(
              'يرجى اختيار يوم واحد على الأقل للحفظ',
              style: AppTypography.caption.copyWith(color: AppColors.error),
              textAlign: TextAlign.center,
            ),
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

  Widget _buildPresets(WidgetRef ref, Set<int> currentDays) {
    final presets = [
      (label: 'كل يوم', days: {1, 2, 3, 4, 5, 6, 7}),
      (label: 'الأحد إلى الخميس', days: {7, 1, 2, 3, 4}),
      (label: 'مخصص', days: null),
    ];

    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.sm,
      alignment: WrapAlignment.center,
      children: presets.map((p) {
        final isSelected = p.days != null 
            ? (currentDays.length == p.days!.length && currentDays.every(p.days!.contains))
            : presets.take(2).every((other) => !(currentDays.length == other.days!.length && currentDays.every(other.days!.contains)));

        return ChoiceChip(
          label: Text(p.label),
          selected: isSelected,
          onSelected: (selected) {
            if (selected && p.days != null) {
              ref.read(setupControllerProvider.notifier).setMemorizationDays(p.days!);
            }
          },
          selectedColor: AppColors.actionSecondary,
          checkmarkColor: AppColors.actionPrimary,
          labelStyle: AppTypography.label.copyWith(
            color: isSelected ? AppColors.actionPrimary : AppColors.textPrimary,
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          side: BorderSide(color: isSelected ? AppColors.actionPrimary : AppColors.borderSubtle),
        );
      }).toList(),
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
        'اخترت ${days.length} أيام في الأسبوع',
        style: AppTypography.label.copyWith(color: AppColors.actionPrimary),
        textAlign: TextAlign.center,
      ),
    );
  }
}
