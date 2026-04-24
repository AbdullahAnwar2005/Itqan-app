import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/design/tokens/app_colors.dart';
import '../../../core/design/tokens/app_spacing.dart';
import '../../../core/design/tokens/app_typography.dart';
import '../../../core/routing/app_router.dart';
import '../application/setup_providers.dart';
import '../application/setup_target_config.dart';
import '../domain/user_setup.dart';

/// Multi-step user setup screen.
///
/// Three steps:
/// 1. Memorization capacity — ayahs per day
/// 2. Review capacity — hizb-parts per day
/// 3. Intensity preference
///
/// State is managed by [SetupController]. Widgets are thin — no logic here.
/// On completion, [SetupController.save] persists data and the router redirect
/// picks up [isSetupCompleteProvider] → true and navigates to Today.
class SetupScreen extends ConsumerStatefulWidget {
  const SetupScreen({super.key});

  @override
  ConsumerState<SetupScreen> createState() => _SetupScreenState();
}

class _SetupScreenState extends ConsumerState<SetupScreen> {
  final PageController _pageController = PageController();
  int _currentStep = 0;
  static const int _totalSteps = 3;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextStep() {
    if (_currentStep < _totalSteps - 1) {
      setState(() => _currentStep++);
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _prevStep() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> _finish() async {
    await ref.read(setupControllerProvider.notifier).save(ref);
    if (mounted) context.goNamed(AppRoutes.today);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfacePrimary,
      body: SafeArea(
        child: Column(
          children: [
            _SetupProgressBar(current: _currentStep, total: _totalSteps),
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _MemorizeCapacityStep(onNext: _nextStep),
                  _ReviewCapacityStep(onBack: _prevStep, onNext: _nextStep),
                  _IntensityStep(onBack: _prevStep, onFinish: _finish),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Progress indicator ────────────────────────────────────────────────────────

class _SetupProgressBar extends StatelessWidget {
  const _SetupProgressBar({required this.current, required this.total});

  final int current;
  final int total;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.lg,
        AppSpacing.lg,
        AppSpacing.lg,
        AppSpacing.xs,
      ),
      child: Row(
        children: List.generate(total, (i) {
          final isActive = i <= current;
          return Expanded(
            child: Container(
              height: 4,
              margin: EdgeInsetsDirectional.only(
                end: i < total - 1 ? AppSpacing.xs : 0,
              ),
              decoration: BoxDecoration(
                color: isActive
                    ? AppColors.actionPrimary
                    : AppColors.borderSubtle,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          );
        }),
      ),
    );
  }
}

// ── Shared step scaffold ──────────────────────────────────────────────────────

class _StepScaffold extends StatelessWidget {
  const _StepScaffold({
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
          Text(title, style: AppTypography.sectionTitle.copyWith(color: AppColors.textPrimary)),
          const SizedBox(height: AppSpacing.xs),
          Text(subtitle, style: AppTypography.body.copyWith(color: AppColors.textSecondary)),
          const SizedBox(height: AppSpacing.xxl),
          content,
          const Spacer(),
          ...actions,
          const SizedBox(height: AppSpacing.lg),
        ],
      ),
    );
  }
}

// ── Step 1: Memorization capacity ────────────────────────────────────────────

class _MemorizeCapacityStep extends ConsumerWidget {
  const _MemorizeCapacityStep({required this.onNext});

  final VoidCallback onNext;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final setup = ref.watch(setupControllerProvider);
    final controller = ref.read(setupControllerProvider.notifier);

    return _StepScaffold(
      title: 'كم تحفظ يومياً؟',
      subtitle: 'اختر عدداً يناسب وقتك وتركيزك اليومي',
      content: _TargetSelector(
        target: setup.memorizationTarget,
        configs: allowedMemorizationUnits,
        onChanged: controller.setMemorizationTarget,
      ),
      actions: [
        _PrimaryButton(label: 'التالي', onPressed: onNext),
      ],
    );
  }
}

// ── Step 2: Review capacity ──────────────────────────────────────────────────

class _ReviewCapacityStep extends ConsumerWidget {
  const _ReviewCapacityStep({required this.onBack, required this.onNext});

  final VoidCallback onBack;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final setup = ref.watch(setupControllerProvider);
    final controller = ref.read(setupControllerProvider.notifier);

    return _StepScaffold(
      title: 'ما هو مقدار المراجعة اليومي؟',
      subtitle: 'المراجعة بانتظام تُرسّخ ما حفظت. ابدأ بمقدار تستطيع الالتزام به',
      content: _TargetSelector(
        target: setup.reviewTarget,
        configs: allowedReviewUnits,
        onChanged: controller.setReviewTarget,
      ),
      actions: [
        _PrimaryButton(label: 'التالي', onPressed: onNext),
        const SizedBox(height: AppSpacing.xs),
        _SecondaryButton(label: 'رجوع', onPressed: onBack),
      ],
    );
  }
}

// ── Step 3: Intensity preference ─────────────────────────────────────────────

class _IntensityStep extends ConsumerWidget {
  const _IntensityStep({required this.onBack, required this.onFinish});

  final VoidCallback onBack;
  final Future<void> Function() onFinish;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final setup = ref.watch(setupControllerProvider);
    final controller = ref.read(setupControllerProvider.notifier);

    return _StepScaffold(
      title: 'ما الإيقاع الذي يناسبك؟',
      subtitle: 'يمكنك تغيير هذا الإعداد لاحقاً من صفحة الخطة',
      content: Column(
        children: MemorizationIntensity.values.map((intensity) {
          final selected = setup.intensity == intensity;
          return _IntensityCard(
            intensity: intensity,
            selected: selected,
            onTap: () => controller.setIntensity(intensity),
          );
        }).toList(),
      ),
      actions: [
        _PrimaryButton(label: 'ابدأ الحفظ', onPressed: onFinish),
        const SizedBox(height: AppSpacing.xs),
        _SecondaryButton(label: 'رجوع', onPressed: onBack),
      ],
    );
  }
}

// ── Reusable step widgets ─────────────────────────────────────────────────────

class _TargetSelector extends StatelessWidget {
  const _TargetSelector({
    required this.target,
    required this.configs,
    required this.onChanged,
  });

  final DailyTarget target;
  final List<UnitConfig> configs;
  final ValueChanged<DailyTarget> onChanged;

  @override
  Widget build(BuildContext context) {
    final activeConfig = configs.firstWhere(
      (c) => c.unit == target.unit,
      orElse: () => configs.first,
    );

    double safeAmount = target.amount.clamp(activeConfig.min, activeConfig.max);

    return Column(
      children: [
        SegmentedButton<ProgressUnit>(
          segments: configs.map((c) {
            return ButtonSegment<ProgressUnit>(
              value: c.unit,
              label: Text(c.labelAr),
            );
          }).toList(),
          selected: {activeConfig.unit},
          onSelectionChanged: (Set<ProgressUnit> selection) {
            final newUnit = selection.first;
            final newConfig = configs.firstWhere((c) => c.unit == newUnit);
            final newAmount = target.amount.clamp(newConfig.min, newConfig.max);
            
            // Adjust step
            final roundedAmount = (newAmount / newConfig.step).roundToDouble() * newConfig.step;
            onChanged(DailyTarget(amount: roundedAmount, unit: newUnit));
          },
        ),
        const SizedBox(height: AppSpacing.xxl),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _StepperButton(
              icon: Icons.remove,
              onPressed: safeAmount > activeConfig.min
                  ? () => onChanged(DailyTarget(amount: safeAmount - activeConfig.step, unit: activeConfig.unit))
                  : null,
            ),
            const SizedBox(width: AppSpacing.xl),
            Column(
              children: [
                Text(
                  safeAmount == safeAmount.truncateToDouble()
                      ? safeAmount.toInt().toString()
                      : safeAmount.toString(),
                  style: AppTypography.display
                      .copyWith(color: AppColors.actionPrimary),
                ),
                Text(
                  '${activeConfig.labelAr} / يوم',
                  style: AppTypography.bodySmall
                      .copyWith(color: AppColors.textSecondary),
                ),
              ],
            ),
            const SizedBox(width: AppSpacing.xl),
            _StepperButton(
              icon: Icons.add,
              onPressed: safeAmount < activeConfig.max
                  ? () => onChanged(DailyTarget(amount: safeAmount + activeConfig.step, unit: activeConfig.unit))
                  : null,
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: AppColors.actionPrimary,
            inactiveTrackColor: AppColors.borderSubtle,
            thumbColor: AppColors.actionPrimary,
            overlayColor: AppColors.actionSecondary,
            trackHeight: 4,
          ),
          child: Slider(
            value: safeAmount,
            min: activeConfig.min,
            max: activeConfig.max,
            divisions: ((activeConfig.max - activeConfig.min) / activeConfig.step).round(),
            onChanged: (v) {
              double rounded = (v / activeConfig.step).roundToDouble() * activeConfig.step;
              onChanged(DailyTarget(amount: rounded, unit: activeConfig.unit));
            },
          ),
        ),
      ],
    );
  }
}

class _StepperButton extends StatelessWidget {
  const _StepperButton({required this.icon, this.onPressed});

  final IconData icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final enabled = onPressed != null;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: enabled ? AppColors.actionSecondary : AppColors.surfaceTertiary,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: enabled ? AppColors.actionPrimary : AppColors.textDisabled,
          size: 24,
        ),
      ),
    );
  }
}

class _IntensityCard extends StatelessWidget {
  const _IntensityCard({
    required this.intensity,
    required this.selected,
    required this.onTap,
  });

  final MemorizationIntensity intensity;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        margin: const EdgeInsets.only(bottom: AppSpacing.sm),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: selected ? AppColors.actionSecondary : AppColors.surfacePrimary,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected ? AppColors.actionPrimary : AppColors.borderSubtle,
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
                    intensity.label,
                    style: AppTypography.label.copyWith(
                      color: selected
                          ? AppColors.actionPrimary
                          : AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    intensity.description,
                    style: AppTypography.caption.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            if (selected)
              const Icon(
                Icons.check_circle,
                color: AppColors.actionPrimary,
                size: 20,
              ),
          ],
        ),
      ),
    );
  }
}

class _PrimaryButton extends StatelessWidget {
  const _PrimaryButton({required this.label, required this.onPressed});

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(label),
      ),
    );
  }
}

class _SecondaryButton extends StatelessWidget {
  const _SecondaryButton({required this.label, required this.onPressed});

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        onPressed: onPressed,
        child: Text(label),
      ),
    );
  }
}
