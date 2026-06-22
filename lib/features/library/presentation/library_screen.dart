import 'package:flutter/material.dart';
import '../../../core/design/components/itqan_top_app_bar.dart';
import '../../../core/design/tokens/app_spacing.dart';
import '../../../core/design/tokens/app_typography.dart';
import '../../../core/design/tokens/app_radius.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ItqanTopAppBar(title: 'المكتبة'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'دليل الإتقان',
              style: AppTypography.pageTitle,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              'موارد وإرشادات لمساعدتك في رحلة الحفظ والمراجعة.',
              style: AppTypography.body.copyWith(color: Theme.of(context).hintColor),
            ),
            const SizedBox(height: AppSpacing.xxl),
            const _GuidanceCard(
              title: 'كيف تستخدم إتقان؟',
              description: 'يتكون التطبيق من ثلاث حلقات أساسية: التخطيط، التنفيذ، والتقدّم.',
              icon: Icons.lightbulb_outline_rounded,
            ),
            const SizedBox(height: AppSpacing.lg),
            const _GuidanceCard(
              title: 'أهمية المراجعة اليومية',
              description: 'المراجعة المستمرة هي سر الحفظ طويل الأمد. لا تهمل مهام المراجعة حتى لو كانت كثيرة.',
              icon: Icons.history_rounded,
            ),
            const SizedBox(height: AppSpacing.lg),
            const _GuidanceCard(
              title: 'ضبط أهدافك',
              description: 'ابدأ بأهداف صغيرة ومستمرة (قليل دائم خير من كثير منقطع). يمكنك تعديل أهدافك من الإعدادات.',
              icon: Icons.settings_suggest_outlined,
            ),
            const SizedBox(height: AppSpacing.lg),
            const _GuidanceCard(
              title: 'فهم السلسلة (Streak)',
              description: 'السلسلة تزداد عند إكمال مهام الحفظ والمراجعة معاً في نفس اليوم.',
              icon: Icons.local_fire_department_rounded,
            ),
          ],
        ),
      ),
    );
  }
}

class _GuidanceCard extends StatelessWidget {
  const _GuidanceCard({
    required this.title,
    required this.description,
    required this.icon,
  });

  final String title;
  final String description;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: theme.dividerColor.withValues(alpha: 0.1)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: theme.colorScheme.primary, size: 28),
          const SizedBox(width: AppSpacing.lg),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTypography.label.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  description,
                  style: AppTypography.bodySmall.copyWith(color: theme.hintColor, height: 1.5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
