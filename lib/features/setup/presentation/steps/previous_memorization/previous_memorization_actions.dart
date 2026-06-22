import 'package:flutter/material.dart';

import '../../../../../../core/design/tokens/app_colors.dart';
import '../../../../../../core/design/tokens/app_spacing.dart';
import '../../../../../../core/design/tokens/app_typography.dart';
import 'add_bulk_surahs_sheet.dart';
import 'add_juz_sheet.dart';
import 'add_surah_sheet.dart';

class PreviousMemorizationActions extends StatelessWidget {
  const PreviousMemorizationActions({super.key});

  void _showAddSurahSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const AddSurahSheet(),
    );
  }

  void _showAddJuzSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const AddJuzSheet(),
    );
  }

  void _showAddBulkSurahsSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const AddBulkSurahsSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('ما الذي تحفظه؟', style: AppTypography.label.copyWith(color: AppColors.actionPrimary)),
        const SizedBox(height: AppSpacing.md),
        Row(
          children: [
            Expanded(
              child: _ActionCard(
                icon: Icons.menu_book,
                label: 'إضافة من سورة',
                onTap: () => _showAddSurahSheet(context),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: _ActionCard(
                icon: Icons.library_books,
                label: 'إضافة جزء كامل',
                onTap: () => _showAddJuzSheet(context),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        _ActionCard(
          icon: Icons.view_module,
          label: 'إضافة عدة سور',
          subtitle: 'اختر أكثر من سورة كاملة دفعة واحدة',
          onTap: () => _showAddBulkSurahsSheet(context),
        ),
      ],
    );
  }
}

class _ActionCard extends StatelessWidget {
  const _ActionCard({
    required this.icon,
    required this.label,
    this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final String? subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.md, horizontal: AppSpacing.sm),
        decoration: BoxDecoration(
          color: AppColors.surfacePrimary,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.borderSubtle),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: AppColors.actionPrimary, size: 24),
                if (subtitle != null) ...[
                  const SizedBox(width: AppSpacing.sm),
                  Text(label, style: AppTypography.label),
                ],
              ],
            ),
            if (subtitle == null) ...[
              const SizedBox(height: AppSpacing.sm),
              Text(label, style: AppTypography.caption, textAlign: TextAlign.center),
            ],
            if (subtitle != null) ...[
              const SizedBox(height: AppSpacing.xs),
              Text(subtitle!, style: AppTypography.caption.copyWith(color: AppColors.textSecondary), textAlign: TextAlign.center),
            ],
          ],
        ),
      ),
    );
  }
}
