import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/design/components/itqan_top_app_bar.dart';
import '../../../core/design/tokens/app_spacing.dart';
import '../../../core/design/tokens/app_typography.dart';
import '../../../core/utils/arabic_formatter.dart';
import '../../plan/application/plan_providers.dart';
import '../../plan/domain/plan_status.dart';
import '../../setup/domain/user_setup.dart';
import '../application/settings_controller.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final planAsync = ref.watch(activePlanProvider);

    return Scaffold(
      appBar: const ItqanTopAppBar(title: 'الإعدادات'),
      body: planAsync.when(
        data: (plan) => plan == null
            ? const Center(child: Text('لا توجد خطة نشطة'))
            : _SettingsList(plan: plan),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Error: $err')),
      ),
    );
  }
}

class _SettingsList extends ConsumerWidget {
  const _SettingsList({required this.plan});

  final dynamic plan;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        _SectionHeader(title: 'أهداف اليوم'),
        _TargetTile(
          label: 'هدف الحفظ',
          target: plan.memorizationTarget,
          onTap: () => _showTargetPicker(context, ref, plan, true),
        ),
        _TargetTile(
          label: 'هدف المراجعة',
          target: plan.reviewTarget,
          onTap: () => _showTargetPicker(context, ref, plan, false),
        ),
        const Divider(height: AppSpacing.xxl),
        _SectionHeader(title: 'إدارة الخطة'),
        _ActionTile(
          label: plan.status == PlanStatus.active
              ? 'إيقاف الخطة مؤقتاً'
              : 'استئناف الخطة',
          icon: plan.status == PlanStatus.active
              ? Icons.pause_circle_outline
              : Icons.play_circle_outline,
          color:
              plan.status == PlanStatus.active ? Colors.orange : Colors.green,
          onTap: () =>
              ref.read(settingsControllerProvider.notifier).togglePlanStatus(),
        ),
        _ActionTile(
          label: 'إعادة ضبط الخطة',
          icon: Icons.refresh_rounded,
          color: Colors.red,
          onTap: () => _showResetDialog(context, ref),
        ),
      ],
    );
  }

  void _showTargetPicker(
      BuildContext context, WidgetRef ref, dynamic plan, bool isMemo) {
    // For V1, we'll keep it simple and just show a basic dialog with some options
    // In a real app, this would be a more sophisticated picker like in setup.
    showModalBottomSheet(
      context: context,
      builder: (context) => _TargetPickerSheet(
        initialTarget: isMemo ? plan.memorizationTarget : plan.reviewTarget,
        onSelected: (newTarget) {
          if (isMemo) {
            ref.read(settingsControllerProvider.notifier).updateTargets(
                  memorizationTarget: newTarget,
                  reviewTarget: plan.reviewTarget,
                );
          } else {
            ref.read(settingsControllerProvider.notifier).updateTargets(
                  memorizationTarget: plan.memorizationTarget,
                  reviewTarget: newTarget,
                );
          }
          Navigator.pop(context);
        },
      ),
    );
  }

  void _showResetDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('إعادة ضبط الخطة؟'),
        content: const Text('سيتم إيقاف الخطة الحالية. هل أنت متأكد؟'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('إلغاء')),
          TextButton(
            onPressed: () {
              ref.read(settingsControllerProvider.notifier).resetPlan();
              Navigator.pop(context);
              context.go('/plan');
            },
            child: const Text('تأكيد', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md, top: AppSpacing.sm),
      child: Text(title,
          style: AppTypography.label
              .copyWith(color: Theme.of(context).primaryColor)),
    );
  }
}

class _TargetTile extends StatelessWidget {
  const _TargetTile(
      {required this.label, required this.target, required this.onTap});
  final String label;
  final DailyTarget target;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(label, style: AppTypography.body),
      subtitle: Text(ArabicFormatter.formatTarget(target),
          style: AppTypography.bodySmall.copyWith(color: theme.hintColor)),
      trailing: const Icon(Icons.chevron_right_rounded),
      onTap: onTap,
    );
  }
}

class _ActionTile extends StatelessWidget {
  const _ActionTile(
      {required this.label,
      required this.icon,
      required this.color,
      required this.onTap});
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: color),
      title: Text(label, style: AppTypography.body.copyWith(color: color)),
      onTap: onTap,
    );
  }
}

class _TargetPickerSheet extends StatelessWidget {
  const _TargetPickerSheet(
      {required this.initialTarget, required this.onSelected});
  final DailyTarget initialTarget;
  final ValueChanged<DailyTarget> onSelected;

  @override
  Widget build(BuildContext context) {
    final amounts = [0.5, 1.0, 2.0, 3.0, 5.0, 10.0];

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('اختر الهدف الجديد', style: AppTypography.cardTitle),
          const SizedBox(height: AppSpacing.lg),
          Wrap(
            spacing: AppSpacing.md,
            runSpacing: AppSpacing.md,
            children: amounts.map((amount) {
              final target =
                  DailyTarget(amount: amount, unit: initialTarget.unit);
              return ActionChip(
                label: Text(ArabicFormatter.formatTarget(target)),
                onPressed: () => onSelected(target),
              );
            }).toList(),
          ),
          const SizedBox(height: AppSpacing.xl),
        ],
      ),
    );
  }
}
