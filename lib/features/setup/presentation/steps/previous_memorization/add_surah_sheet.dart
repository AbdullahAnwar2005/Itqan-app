import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../core/constants/quran_metadata.dart';
import '../../../../../../../core/design/tokens/app_colors.dart';
import '../../../../../../../core/design/tokens/app_spacing.dart';
import '../../../../../../../core/design/tokens/app_typography.dart';
import '../../../application/previous_memorization_draft_entry.dart';
import '../../../application/previous_memorization_service.dart';
import '../../../application/setup_providers.dart';

class AddSurahSheet extends ConsumerStatefulWidget {
  /// Creates a sheet for adding a new surah entry.
  const AddSurahSheet({super.key}) : _editEntry = null;

  /// Creates a sheet for editing an existing surah entry.
  const AddSurahSheet.edit({super.key, required PreviousSurahEntry entry}) : _editEntry = entry;

  final PreviousSurahEntry? _editEntry;

  bool get isEditMode => _editEntry != null;

  @override
  ConsumerState<AddSurahSheet> createState() => _AddSurahSheetState();
}

class _AddSurahSheetState extends ConsumerState<AddSurahSheet> {
  late int _selectedSurah;
  late bool _isWholeSurah;
  late int _fromAyah;
  late int _toAyah;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    final edit = widget._editEntry;
    if (edit != null) {
      _selectedSurah = edit.surahNumber;
      _isWholeSurah = edit.isWholeSurah;
      _fromAyah = edit.fromAyah ?? 1;
      _toAyah = edit.toAyah ?? QuranMetadata.getAyahCount(edit.surahNumber);
    } else {
      _selectedSurah = 1;
      _isWholeSurah = true;
      _fromAyah = 1;
      _toAyah = 7; // Al-Fatiha default
    }
  }

  void _onSurahChanged(int surah) {
    setState(() {
      _selectedSurah = surah;
      _fromAyah = 1;
      _toAyah = QuranMetadata.getAyahCount(surah);
      _errorMessage = null;
    });
  }

  void _submit() {
    try {
      final controller = ref.read(setupControllerProvider.notifier);
      if (widget.isEditMode) {
        controller.updateSurahEntry(
          widget._editEntry!.id,
          surahNumber: _selectedSurah,
          isWholeSurah: _isWholeSurah,
          fromAyah: _isWholeSurah ? null : _fromAyah,
          toAyah: _isWholeSurah ? null : _toAyah,
        );
      } else {
        controller.addSurahEntry(
          _selectedSurah,
          isWholeSurah: _isWholeSurah,
          fromAyah: _isWholeSurah ? null : _fromAyah,
          toAyah: _isWholeSurah ? null : _toAyah,
        );
      }
      Navigator.of(context).pop();
    } on InvalidRangeException catch (e) {
      setState(() => _errorMessage = e.toString());
    } on RangeOverlapException catch (e) {
      setState(() => _errorMessage = e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final ayahCount = QuranMetadata.getAyahCount(_selectedSurah);
    final entries = ref.watch(setupControllerProvider).previousMemorizationEntries;
    final service = ref.read(previousMemorizationServiceProvider);

    // In edit mode, exclude self from availability check
    final entriesForAvailability = widget.isEditMode
        ? entries.where((e) => e.id != widget._editEntry!.id).toList()
        : entries;
    final availability = service.getSurahAvailability(
      surahNumber: _selectedSurah,
      entries: entriesForAvailability,
    );
    final isFullyCovered =
        availability.status == MemorizationAvailability.fullyCovered;
    final isPartial =
        availability.status == MemorizationAvailability.partiallyCovered;

    final hasChanges = !widget.isEditMode || _hasChanges();
    final submitDisabled = (isFullyCovered && _isWholeSurah) || !hasChanges;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: const BoxDecoration(
        color: AppColors.surfacePrimary,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            widget.isEditMode ? 'تعديل السورة' : 'إضافة من سورة',
            style: AppTypography.sectionTitle,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.xl),

          // ── Surah selector ──────────────────────────────────────────────
          const Text('اختر السورة', style: AppTypography.caption),
          const SizedBox(height: AppSpacing.xs),
          DropdownButtonFormField<int>(
            initialValue: _selectedSurah,
            decoration: _inputDecoration(),
            items: List.generate(
              QuranMetadata.surahCount,
              (i) => DropdownMenuItem(
                value: i + 1,
                child: Text(QuranMetadata.getSurahName(i + 1)),
              ),
            ),
            onChanged: (v) {
              if (v != null) _onSurahChanged(v);
            },
          ),
          const SizedBox(height: AppSpacing.sm),

          // ── Availability status ────────────────────────────────────────────
          if (isFullyCovered)
            _StatusBanner(
              message: 'هذه السورة مضافة بالكامل',
              icon: Icons.check_circle,
              color: AppColors.textSecondary,
            )
          else if (isPartial)
            _StatusBanner(
              message: 'تمت إضافة جزء من هذه السورة سابقًا. اختر آيات غير مضافة.',
              icon: Icons.info_outline,
              color: AppColors.actionPrimary,
            ),

          const SizedBox(height: AppSpacing.md),

          // ── Whole / Partial toggle ──────────────────────────────────────
          Row(
            children: [
              Expanded(
                child: _ToggleChip(
                  label: 'السورة كاملة',
                  selected: _isWholeSurah,
                  onTap: () => setState(() => _isWholeSurah = true),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: _ToggleChip(
                  label: 'آيات محددة',
                  selected: !_isWholeSurah,
                  onTap: () => setState(() => _isWholeSurah = false),
                ),
              ),
            ],
          ),

          // ── Ayah selectors (partial mode) ──────────────────────────────
          if (!_isWholeSurah) ...[
            const SizedBox(height: AppSpacing.md),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('من الآية', style: AppTypography.caption),
                      const SizedBox(height: AppSpacing.xs),
                      DropdownButtonFormField<int>(
                        key: ValueKey('from_${_selectedSurah}_$_fromAyah'),
                        initialValue: _fromAyah,
                        decoration: _inputDecoration(),
                        items: List.generate(
                          ayahCount,
                          (i) => DropdownMenuItem(value: i + 1, child: Text((i + 1).toString())),
                        ),
                        onChanged: (v) {
                          if (v != null) {
                            setState(() {
                              _fromAyah = v;
                              if (_toAyah < v) _toAyah = v;
                            });
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
                      const Text('إلى الآية', style: AppTypography.caption),
                      const SizedBox(height: AppSpacing.xs),
                      DropdownButtonFormField<int>(
                        key: ValueKey('to_${_selectedSurah}_${_fromAyah}_$_toAyah'),
                        initialValue: _toAyah,
                        decoration: _inputDecoration(),
                        items: List.generate(
                          ayahCount - _fromAyah + 1,
                          (i) => DropdownMenuItem(value: _fromAyah + i, child: Text((_fromAyah + i).toString())),
                        ),
                        onChanged: (v) {
                          if (v != null) setState(() => _toAyah = v);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],

          const SizedBox(height: AppSpacing.xl),

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
            onPressed: submitDisabled ? null : _submit,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.actionPrimary,
              disabledBackgroundColor: AppColors.borderSubtle,
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: Text(
              widget.isEditMode ? 'حفظ التعديلات' : 'إضافة',
              style: TextStyle(
                color: submitDisabled ? AppColors.textSecondary : Colors.white,
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
    final edit = widget._editEntry;
    if (edit == null) return true;
    if (_selectedSurah != edit.surahNumber) return true;
    if (_isWholeSurah != edit.isWholeSurah) return true;
    if (!_isWholeSurah) {
      if (_fromAyah != edit.fromAyah) return true;
      if (_toAyah != edit.toAyah) return true;
    }
    return false;
  }

  InputDecoration _inputDecoration() {
    return InputDecoration(
      contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: AppSpacing.xs),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.borderSubtle),
      ),
    );
  }
}

class _ToggleChip extends StatelessWidget {
  const _ToggleChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm, horizontal: AppSpacing.md),
        decoration: BoxDecoration(
          color: selected ? AppColors.actionPrimary.withAlpha(20) : AppColors.surfaceSecondary,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: selected ? AppColors.actionPrimary : AppColors.borderSubtle,
          ),
        ),
        child: Text(
          label,
          style: AppTypography.caption.copyWith(
            color: selected ? AppColors.actionPrimary : AppColors.textSecondary,
            fontWeight: selected ? FontWeight.bold : FontWeight.normal,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class _StatusBanner extends StatelessWidget {
  const _StatusBanner({
    required this.message,
    required this.icon,
    required this.color,
  });

  final String message;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: color.withAlpha(15),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withAlpha(50)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 16),
          const SizedBox(width: AppSpacing.xs),
          Expanded(
            child: Text(
              message,
              style: AppTypography.caption.copyWith(color: color),
            ),
          ),
        ],
      ),
    );
  }
}
