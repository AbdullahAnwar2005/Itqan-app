import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../core/design/tokens/app_colors.dart';
import '../../../../../../core/design/tokens/app_spacing.dart';
import '../../../../../../core/design/tokens/app_typography.dart';
import '../../../application/previous_memorization_draft_entry.dart';
import '../../../application/previous_memorization_service.dart';
import '../../../application/setup_providers.dart';
import 'add_bulk_surahs_sheet.dart';
import 'add_surah_sheet.dart';
import 'customize_juz_sheet.dart';
import 'draft_entry_formatter.dart';

class PreviousMemorizationSummary extends ConsumerWidget {
  const PreviousMemorizationSummary({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(setupControllerProvider);
    final entries = state.previousMemorizationEntries;

    if (entries.isEmpty && state.hasPreviousMemorization) {
      return Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.surfaceSecondary,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          'لم تضف أي محفوظات بعد. ابدأ بإضافة سورة أو جزء كامل.',
          style: AppTypography.caption.copyWith(color: AppColors.textSecondary),
          textAlign: TextAlign.center,
        ),
      );
    }

    if (entries.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('المحفوظات المضافة (${entries.length})', style: AppTypography.label),
        const SizedBox(height: AppSpacing.sm),
        ...entries.map((entry) => _EntryCard(entry: entry)),
      ],
    );
  }
}

class _EntryCard extends ConsumerWidget {
  const _EntryCard({required this.entry});

  final PreviousMemorizationDraftEntry entry;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final title = DraftEntryFormatter.titleForEntry(entry);
    final subtitle = DraftEntryFormatter.subtitleForEntry(entry);

    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.xs),
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.actionSecondary.withAlpha(20),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const Icon(Icons.bookmark, color: AppColors.actionPrimary, size: 16),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTypography.bodySmall),
                Text(subtitle, style: AppTypography.caption.copyWith(color: AppColors.textSecondary)),
              ],
            ),
          ),
          _buildActions(context, ref),
        ],
      ),
    );
  }

  Widget _buildActions(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...switch (entry) {
          PreviousSurahEntry() => [
            _actionButton(
              icon: Icons.edit_outlined,
              color: AppColors.actionPrimary,
              tooltip: 'تعديل',
              onTap: () => _editSurahEntry(context, entry as PreviousSurahEntry),
            ),
          ],
          PreviousJuzEntry(:final isCustomized) => [
            _actionButton(
              icon: isCustomized ? Icons.edit_outlined : Icons.tune,
              color: AppColors.actionPrimary,
              tooltip: isCustomized ? 'تعديل' : 'تخصيص',
              onTap: () => _customizeJuzEntry(context, entry as PreviousJuzEntry),
            ),
            if (isCustomized)
              _actionButton(
                icon: Icons.restore,
                color: AppColors.textSecondary,
                tooltip: 'إرجاع كجزء كامل',
                onTap: () => _resetJuzEntry(context, ref, entry as PreviousJuzEntry),
              ),
          ],
          PreviousBulkSurahEntry() => [
            _actionButton(
              icon: Icons.edit_outlined,
              color: AppColors.actionPrimary,
              tooltip: 'تعديل',
              onTap: () => _editBulkSurahEntry(context, entry as PreviousBulkSurahEntry),
            ),
          ],
        },
        _actionButton(
          icon: Icons.delete_outline,
          color: AppColors.error,
          tooltip: 'حذف',
          onTap: () {
            ref.read(setupControllerProvider.notifier).removePreviousMemorizationEntry(entry.id);
          },
        ),
      ],
    );
  }

  Widget _actionButton({
    required IconData icon,
    required Color color,
    required String tooltip,
    required VoidCallback onTap,
  }) {
    return IconButton(
      icon: Icon(icon, color: color, size: 20),
      tooltip: tooltip,
      onPressed: onTap,
      padding: const EdgeInsets.all(4),
      constraints: const BoxConstraints(),
      visualDensity: VisualDensity.compact,
    );
  }

  void _editSurahEntry(BuildContext context, PreviousSurahEntry surahEntry) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AddSurahSheet.edit(entry: surahEntry),
    );
  }

  void _customizeJuzEntry(BuildContext context, PreviousJuzEntry juzEntry) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => CustomizeJuzSheet(entry: juzEntry),
    );
  }

  void _resetJuzEntry(BuildContext context, WidgetRef ref, PreviousJuzEntry juzEntry) {
    try {
      ref.read(setupControllerProvider.notifier).resetJuzEntryToFull(juzEntry.id);
    } on RangeOverlapException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString()), backgroundColor: AppColors.error),
      );
    }
  }

  void _editBulkSurahEntry(BuildContext context, PreviousBulkSurahEntry entry) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AddBulkSurahsSheet.edit(entry: entry),
    );
  }
}
