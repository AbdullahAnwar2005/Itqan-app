import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/quran_metadata.dart';
import '../../../../core/design/tokens/app_colors.dart';
import '../../../../core/design/tokens/app_spacing.dart';
import '../../../../core/design/tokens/app_typography.dart';
import '../../../../core/utils/arabic_formatter.dart';
import '../../../plan/domain/quran_position.dart';
import '../../application/setup_providers.dart';
import '../widgets/setup_shared_widgets.dart';
import 'previous_memorization/suggested_start_position_card.dart';

class StartPositionStep extends ConsumerWidget {
  const StartPositionStep({super.key, required this.onBack, required this.onFinish});
  final VoidCallback onBack;
  final VoidCallback onFinish;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final setup = ref.watch(setupControllerProvider);
    final pos = setup.startPosition;

    return StepScaffold(
      title: 'من أين تبدأ الحفظ الجديد؟',
      subtitle: 'حدد السورة والآية التي ستبدأ منها حفظك الجديد',
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SuggestedStartPositionCard(),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('السورة', style: AppTypography.label),
                    const SizedBox(height: AppSpacing.xs),
                    DropdownButtonFormField<int>(
                      key: ValueKey('surah-${pos.surahNumber}'),
                      initialValue: pos.surahNumber,
                      decoration: _inputDecoration(),
                      items: List.generate(
                        QuranMetadata.surahCount,
                        (i) => DropdownMenuItem(
                          value: i + 1,
                          child: Text(QuranMetadata.getSurahName(i + 1)),
                        ),
                      ),
                      onChanged: (val) {
                        if (val == null) return;
                        final maxAyahs = QuranMetadata.getAyahCount(val);
                        ref.read(setupControllerProvider.notifier).setStartPosition(
                          QuranPosition(
                            surahNumber: val,
                            ayahNumber: pos.ayahNumber.clamp(1, maxAyahs),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('الآية', style: AppTypography.label),
                    const SizedBox(height: AppSpacing.xs),
                    DropdownButtonFormField<int>(
                      key: ValueKey('ayah-${pos.surahNumber}-${pos.ayahNumber}'),
                      initialValue: pos.ayahNumber,
                      decoration: _inputDecoration(),
                      items: List.generate(
                        QuranMetadata.getAyahCount(pos.surahNumber),
                        (i) => DropdownMenuItem(
                          value: i + 1,
                          child: Text((i + 1).toString()),
                        ),
                      ),
                      onChanged: (val) {
                        if (val == null) return;
                        ref.read(setupControllerProvider.notifier).setStartPosition(
                          pos.copyWith(ayahNumber: val),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xl),
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.actionSecondary.withAlpha(25),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.actionSecondary),
            ),
            child: Text(
              'سيبدأ حفظك الجديد من: ${ArabicFormatter.formatPosition(pos)}',
              style: AppTypography.body.copyWith(color: AppColors.actionPrimary),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
      actions: [
        PrimaryButton(label: 'ابدأ الحفظ', onPressed: onFinish),
        SecondaryButton(label: 'رجوع', onPressed: onBack),
      ],
    );
  }

  InputDecoration _inputDecoration() {
    return InputDecoration(
      contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: AppSpacing.sm),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.borderSubtle),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.borderSubtle),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.actionPrimary),
      ),
    );
  }
}
