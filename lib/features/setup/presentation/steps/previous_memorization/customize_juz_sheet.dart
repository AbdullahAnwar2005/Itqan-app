import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../core/constants/quran_metadata.dart';
import '../../../../../../../core/design/tokens/app_colors.dart';
import '../../../../../../../core/design/tokens/app_spacing.dart';
import '../../../../../../../core/design/tokens/app_typography.dart';
import '../../../../plan/domain/quran_position.dart';
import '../../../application/previous_memorization_draft_entry.dart';
import '../../../application/previous_memorization_service.dart';
import '../../../application/setup_providers.dart';

/// Bottom sheet for customizing per-surah coverage within a Juz entry.
///
/// Lists all surah segments inside the Juz. For each segment the user can choose:
/// - النطاق كامل (full)
/// - آيات محددة (partial)
/// - غير محفوظ (none)
class CustomizeJuzSheet extends ConsumerStatefulWidget {
  const CustomizeJuzSheet({super.key, required this.entry});

  final PreviousJuzEntry entry;

  @override
  ConsumerState<CustomizeJuzSheet> createState() => _CustomizeJuzSheetState();
}

class _CustomizeJuzSheetState extends ConsumerState<CustomizeJuzSheet> {
  late List<_SegmentState> _segments;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    final service = ref.read(previousMemorizationServiceProvider);
    final defaultCoverage = service.buildDefaultCoverage(widget.entry.juzNumber);
    final existing = widget.entry.customizedCoverage;

    _segments = defaultCoverage.map((defaultSeg) {
      // If there's existing customization, use it; otherwise default to full
      final match = existing?.firstWhere(
        (c) => c.surahNumber == defaultSeg.surahNumber,
        orElse: () => defaultSeg,
      );
      return _SegmentState(
        surahNumber: defaultSeg.surahNumber,
        segmentStart: defaultSeg.segmentStart,
        segmentEnd: defaultSeg.segmentEnd,
        type: match?.type ?? MemorizationCoverageType.full,
        fromAyah: match?.fromAyah ?? defaultSeg.segmentStart.ayahNumber,
        toAyah: match?.toAyah ?? defaultSeg.segmentEnd.ayahNumber,
      );
    }).toList();
  }

  void _save() {
    final coverage = _segments.map((s) => JuzSurahCoverage(
      surahNumber: s.surahNumber,
      segmentStart: s.segmentStart,
      segmentEnd: s.segmentEnd,
      type: s.type,
      fromAyah: s.type == MemorizationCoverageType.partial ? s.fromAyah : null,
      toAyah: s.type == MemorizationCoverageType.partial ? s.toAyah : null,
    )).toList();

    try {
      ref.read(setupControllerProvider.notifier).customizeJuzEntry(
        widget.entry.id,
        coverage,
      );
      Navigator.of(context).pop();
    } on InvalidRangeException catch (e) {
      setState(() => _errorMessage = e.toString());
    } on OutOfBoundsException catch (e) {
      setState(() => _errorMessage = e.toString());
    } on RangeOverlapException catch (e) {
      setState(() => _errorMessage = e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: const BoxDecoration(
        color: AppColors.surfacePrimary,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'تخصيص الجزء ${widget.entry.juzNumber}',
            style: AppTypography.sectionTitle,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'حدد ما تحفظه من كل سورة في هذا الجزء',
            style: AppTypography.caption.copyWith(color: AppColors.textSecondary),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.lg),
          Expanded(
            child: ListView.separated(
              itemCount: _segments.length,
              separatorBuilder: (_, __) => const Divider(height: 1, color: AppColors.borderSubtle),
              itemBuilder: (context, index) => _SegmentTile(
                segment: _segments[index],
                onChanged: (updated) => setState(() => _segments[index] = updated),
              ),
            ),
          ),
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

          ElevatedButton(
            onPressed: _hasChanges() ? _save : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.actionPrimary,
              disabledBackgroundColor: AppColors.borderSubtle,
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: Text(
              'حفظ التخصيص',
              style: TextStyle(
                color: _hasChanges() ? Colors.white : AppColors.textSecondary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
        ],
      ),
    );
  }

  bool _hasChanges() {
    final existing = widget.entry.customizedCoverage;

    // If original was full (null) and we have any non-full segment, we have changes.
    if (existing == null) {
      return _segments.any((s) => s.type != MemorizationCoverageType.full);
    }

    if (existing.length != _segments.length) return true;

    for (int i = 0; i < _segments.length; i++) {
      final s = _segments[i];
      final e = existing[i];
      if (s.surahNumber != e.surahNumber) return true;
      if (s.type != e.type) return true;
      if (s.type == MemorizationCoverageType.partial) {
        if (s.fromAyah != e.fromAyah) return true;
        if (s.toAyah != e.toAyah) return true;
      }
    }
    return false;
  }
}

/// Mutable local state for a single segment during customization.
class _SegmentState {
  _SegmentState({
    required this.surahNumber,
    required this.segmentStart,
    required this.segmentEnd,
    required this.type,
    required this.fromAyah,
    required this.toAyah,
  });

  final int surahNumber;
  final QuranPosition segmentStart;
  final QuranPosition segmentEnd;
  MemorizationCoverageType type;
  int fromAyah;
  int toAyah;

  _SegmentState copyWith({
    MemorizationCoverageType? type,
    int? fromAyah,
    int? toAyah,
  }) {
    return _SegmentState(
      surahNumber: surahNumber,
      segmentStart: segmentStart,
      segmentEnd: segmentEnd,
      type: type ?? this.type,
      fromAyah: fromAyah ?? this.fromAyah,
      toAyah: toAyah ?? this.toAyah,
    );
  }
}

class _SegmentTile extends StatelessWidget {
  const _SegmentTile({
    required this.segment,
    required this.onChanged,
  });

  final _SegmentState segment;
  final ValueChanged<_SegmentState> onChanged;

  @override
  Widget build(BuildContext context) {
    final surahName = QuranMetadata.getSurahName(segment.surahNumber);
    final segStartAyah = segment.segmentStart.ayahNumber;
    final segEndAyah = segment.segmentEnd.ayahNumber;
    final isFullSurah = segStartAyah == 1 &&
        segEndAyah == QuranMetadata.getAyahCount(segment.surahNumber);

    final segmentLabel = isFullSurah
        ? surahName
        : '$surahName ($segStartAyah–$segEndAyah)';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Segment header
          Text(segmentLabel, style: AppTypography.label),
          const SizedBox(height: AppSpacing.xs),

          // Coverage type selector
          Row(
            children: [
              _CoverageChip(
                label: 'كامل',
                selected: segment.type == MemorizationCoverageType.full,
                onTap: () => onChanged(segment.copyWith(
                  type: MemorizationCoverageType.full,
                )),
              ),
              const SizedBox(width: AppSpacing.xs),
              _CoverageChip(
                label: 'آيات محددة',
                selected: segment.type == MemorizationCoverageType.partial,
                onTap: () => onChanged(segment.copyWith(
                  type: MemorizationCoverageType.partial,
                  fromAyah: segment.segmentStart.ayahNumber,
                  toAyah: segment.segmentEnd.ayahNumber,
                )),
              ),
              const SizedBox(width: AppSpacing.xs),
              _CoverageChip(
                label: 'غير محفوظ',
                selected: segment.type == MemorizationCoverageType.none,
                isNone: true,
                onTap: () => onChanged(segment.copyWith(
                  type: MemorizationCoverageType.none,
                )),
              ),
            ],
          ),

          // Ayah range selectors for partial mode
          if (segment.type == MemorizationCoverageType.partial) ...[
            const SizedBox(height: AppSpacing.sm),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('من', style: AppTypography.caption),
                      const SizedBox(height: 2),
                      DropdownButtonFormField<int>(
                        key: ValueKey('seg_from_${segment.surahNumber}_${segment.fromAyah}'),
                        initialValue: segment.fromAyah,
                        decoration: _compactInputDecoration(),
                        items: List.generate(
                          segEndAyah - segStartAyah + 1,
                          (i) => DropdownMenuItem(
                            value: segStartAyah + i,
                            child: Text((segStartAyah + i).toString()),
                          ),
                        ),
                        onChanged: (v) {
                          if (v != null) {
                            onChanged(segment.copyWith(
                              fromAyah: v,
                              toAyah: segment.toAyah < v ? v : null,
                            ));
                          }
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('إلى', style: AppTypography.caption),
                      const SizedBox(height: 2),
                      DropdownButtonFormField<int>(
                        key: ValueKey('seg_to_${segment.surahNumber}_${segment.fromAyah}_${segment.toAyah}'),
                        initialValue: segment.toAyah,
                        decoration: _compactInputDecoration(),
                        items: List.generate(
                          segEndAyah - segment.fromAyah + 1,
                          (i) => DropdownMenuItem(
                            value: segment.fromAyah + i,
                            child: Text((segment.fromAyah + i).toString()),
                          ),
                        ),
                        onChanged: (v) {
                          if (v != null) {
                            onChanged(segment.copyWith(toAyah: v));
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  InputDecoration _compactInputDecoration() {
    return InputDecoration(
      contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: 4),
      isDense: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(color: AppColors.borderSubtle),
      ),
    );
  }
}

class _CoverageChip extends StatelessWidget {
  const _CoverageChip({
    required this.label,
    required this.selected,
    required this.onTap,
    this.isNone = false,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;
  final bool isNone;

  @override
  Widget build(BuildContext context) {
    final Color activeColor = isNone ? AppColors.textSecondary : AppColors.actionPrimary;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: AppSpacing.sm),
        decoration: BoxDecoration(
          color: selected ? activeColor.withAlpha(20) : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: selected ? activeColor : AppColors.borderSubtle,
          ),
        ),
        child: Text(
          label,
          style: AppTypography.caption.copyWith(
            fontSize: 11,
            color: selected ? activeColor : AppColors.textSecondary,
            fontWeight: selected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
