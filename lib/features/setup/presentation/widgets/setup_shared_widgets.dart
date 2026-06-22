import 'package:flutter/material.dart';
import 'package:itqan/features/setup/application/setup_target_config.dart';
import 'package:itqan/features/setup/domain/user_setup.dart';
import '../../../../core/design/tokens/app_colors.dart';
import '../../../../core/design/tokens/app_spacing.dart';
import '../../../../core/design/tokens/app_typography.dart';

class SetupProgressBar extends StatelessWidget {
  const SetupProgressBar(
      {super.key, required this.current, required this.total});
  final int current;
  final int total;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Row(
        children: List.generate(
            total,
            (i) => Expanded(
                  child: Container(
                    height: 4,
                    margin: EdgeInsetsDirectional.only(
                        end: i < total - 1 ? AppSpacing.xs : 0),
                    decoration: BoxDecoration(
                      color: i <= current
                          ? AppColors.actionPrimary
                          : AppColors.borderSubtle,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                )),
      ),
    );
  }
}

class StepScaffold extends StatelessWidget {
  const StepScaffold({
    super.key,
    required this.title,
    required this.subtitle,
    required this.content,
    required this.actions,
  });
  final String title;
  final String subtitle;
  final Widget content;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: AppSpacing.xl),
          Text(title,
              style: AppTypography.sectionTitle
                  .copyWith(color: AppColors.textPrimary)),
          const SizedBox(height: AppSpacing.xs),
          Text(subtitle,
              style:
                  AppTypography.body.copyWith(color: AppColors.textSecondary)),
          const SizedBox(height: AppSpacing.xxl),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  content,
                  const SizedBox(height: 120),
                ],
              ),
            ),
          ),
          ...actions,
          const SizedBox(height: AppSpacing.lg),
        ],
      ),
    );
  }
}

class ChoiceCard extends StatelessWidget {
  const ChoiceCard({
    super.key,
    required this.label,
    this.subtitle,
    required this.selected,
    required this.onTap,
    this.enabled = true,
  });
  final String label;
  final String? subtitle;
  final bool selected;
  final VoidCallback onTap;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Opacity(
        opacity: enabled ? 1.0 : 0.5,
        child: Container(
          margin: const EdgeInsets.only(bottom: AppSpacing.sm),
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color:
                selected ? AppColors.actionSecondary : AppColors.surfacePrimary,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color:
                  selected ? AppColors.actionPrimary : AppColors.borderSubtle,
              width: selected ? 2 : 1,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: AppTypography.label.copyWith(
                        color: selected
                            ? AppColors.actionPrimary
                            : AppColors.textPrimary,
                      ),
                    ),
                    if (subtitle != null)
                      Text(
                        subtitle!,
                        style: AppTypography.caption
                            .copyWith(color: AppColors.textSecondary),
                      ),
                  ],
                ),
              ),
              if (selected)
                const Icon(Icons.check_circle,
                    color: AppColors.actionPrimary, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class PresetSelector extends StatelessWidget {
  const PresetSelector({
    super.key,
    required this.presets,
    required this.selectedTarget,
    required this.onPresetSelected,
    required this.isCustomSelected,
  });
  final List<TargetPreset> presets;
  final DailyTarget selectedTarget;
  final ValueChanged<TargetPreset> onPresetSelected;
  final bool isCustomSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: presets.map<Widget>((TargetPreset p) {
        final isSelected = p.isCustom ? isCustomSelected : (!isCustomSelected && p.target == selectedTarget);

        return ChoiceCard(
          label: p.labelAr,
          subtitle: p.descriptionAr,
          selected: isSelected,
          onTap: () => onPresetSelected(p),
        );
      }).toList(),
    );
  }
}

class PrimaryButton extends StatelessWidget {
  const PrimaryButton(
      {super.key, required this.label, required this.onPressed});
  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) => SizedBox(
        width: double.infinity,
        child: ElevatedButton(onPressed: onPressed, child: Text(label)),
      );
}

class SecondaryButton extends StatelessWidget {
  const SecondaryButton(
      {super.key, required this.label, required this.onPressed});
  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) => SizedBox(
        width: double.infinity,
        child: TextButton(onPressed: onPressed, child: Text(label)),
      );
}

class QuickChipSelector extends StatelessWidget {
  const QuickChipSelector({
    super.key,
    required this.chips,
    required this.selectedValue,
    required this.onSelected,
    required this.moreLabel,
    required this.isMoreSelected,
    required this.onMoreSelected,
  });

  final List<({String label, double value})> chips;
  final double selectedValue;
  final ValueChanged<double> onSelected;
  final String moreLabel;
  final bool isMoreSelected;
  final VoidCallback onMoreSelected;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.sm,
      alignment: WrapAlignment.center,
      children: [
        ...chips.map((chip) {
          final isSelected = !isMoreSelected && selectedValue == chip.value;
          return _Chip(
            label: chip.label,
            selected: isSelected,
            onTap: () => onSelected(chip.value),
          );
        }),
        _Chip(
          label: moreLabel,
          selected: isMoreSelected,
          onTap: onMoreSelected,
        ),
      ],
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({required this.label, required this.selected, required this.onTap});
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
        decoration: BoxDecoration(
          color: selected ? AppColors.actionSecondary : AppColors.surfacePrimary,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected ? AppColors.actionPrimary : AppColors.borderSubtle,
            width: selected ? 2 : 1,
          ),
        ),
        child: Text(
          label,
          style: AppTypography.label.copyWith(
            color: selected ? AppColors.actionPrimary : AppColors.textPrimary,
          ),
        ),
      ),
    );
  }
}
