import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../core/constants/juz_metadata.dart';
import '../../../../../../../core/design/tokens/app_colors.dart';
import '../../../../../../../core/design/tokens/app_spacing.dart';
import '../../../../../../../core/design/tokens/app_typography.dart';
import '../../../application/previous_memorization_service.dart';
import '../../../application/setup_providers.dart';

class AddJuzSheet extends ConsumerStatefulWidget {
  const AddJuzSheet({super.key});

  @override
  ConsumerState<AddJuzSheet> createState() => _AddJuzSheetState();
}

class _AddJuzSheetState extends ConsumerState<AddJuzSheet> {
  String? _errorMessage;

  void _addJuz(int juzNumber) {
    try {
      ref.read(setupControllerProvider.notifier).addJuzEntry(juzNumber);
      Navigator.of(context).pop();
    } on RangeOverlapException catch (e) {
      setState(() => _errorMessage = e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final entries = ref.watch(setupControllerProvider).previousMemorizationEntries;
    final service = ref.read(previousMemorizationServiceProvider);

    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: const BoxDecoration(
        color: AppColors.surfacePrimary,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('إضافة جزء',
              style: AppTypography.sectionTitle, textAlign: TextAlign.center),
          const SizedBox(height: AppSpacing.md),

          // ── Inline error ─────────────────────────────────────────────────
          if (_errorMessage != null) ...[
            Container(
              padding: const EdgeInsets.all(AppSpacing.sm),
              decoration: BoxDecoration(
                color: AppColors.error.withAlpha(20),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.error.withAlpha(60)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.error_outline, color: AppColors.error, size: 16),
                  const SizedBox(width: AppSpacing.xs),
                  Expanded(
                    child: Text(
                      _errorMessage!,
                      style: AppTypography.caption.copyWith(color: AppColors.error),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
          ],

          Expanded(
            child: ListView.separated(
              itemCount: JuzMetadata.juzList.length,
              separatorBuilder: (_, __) =>
                  const Divider(height: 1, color: AppColors.borderSubtle),
              itemBuilder: (context, index) {
                final juz = JuzMetadata.juzList[index];
                final availability = service.getJuzAvailability(
                  juzNumber: juz.juzNumber,
                  entries: entries,
                );
                final isFullyCovered =
                    availability.status == MemorizationAvailability.fullyCovered;
                final isPartial =
                    availability.status == MemorizationAvailability.partiallyCovered;

                return ListTile(
                  dense: true,
                  visualDensity: VisualDensity.compact,
                  enabled: !isFullyCovered,
                  title: Text(
                    'الجزء ${juz.juzNumber}',
                    style: AppTypography.label.copyWith(
                      color: isFullyCovered ? AppColors.textSecondary : null,
                    ),
                  ),
                  subtitle: Text(
                    isFullyCovered
                        ? 'مضاف مسبقًا'
                        : isPartial
                            ? '${juz.formatBoundary()} — مضاف جزئيًا'
                            : juz.formatBoundary(),
                    style: AppTypography.caption.copyWith(
                      color: isFullyCovered
                          ? AppColors.textSecondary
                          : isPartial
                              ? AppColors.actionPrimary
                              : null,
                    ),
                  ),
                  trailing: isFullyCovered
                      ? const Icon(Icons.check_circle, color: AppColors.textSecondary, size: 20)
                      : const Icon(Icons.add_circle_outline, color: AppColors.actionPrimary, size: 20),
                  onTap: isFullyCovered ? null : () => _addJuz(juz.juzNumber),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
