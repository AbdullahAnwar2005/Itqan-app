import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../core/constants/quran_metadata.dart';
import '../../../../../../../core/design/tokens/app_colors.dart';
import '../../../../../../../core/design/tokens/app_spacing.dart';
import '../../../../../../../core/design/tokens/app_typography.dart';
import '../../../application/previous_memorization_draft_entry.dart';
import '../../../application/previous_memorization_service.dart';
import '../../../application/setup_providers.dart';

class AddBulkSurahsSheet extends ConsumerStatefulWidget {
  const AddBulkSurahsSheet({super.key}) : _editEntry = null;

  const AddBulkSurahsSheet.edit({
    super.key,
    required PreviousBulkSurahEntry entry,
  }) : _editEntry = entry;

  final PreviousBulkSurahEntry? _editEntry;

  bool get isEditMode => _editEntry != null;

  @override
  ConsumerState<AddBulkSurahsSheet> createState() => _AddBulkSurahsSheetState();
}

class _AddBulkSurahsSheetState extends ConsumerState<AddBulkSurahsSheet> {
  final Map<int, SurahCoverage> _coverages = {};
  String _searchQuery = '';
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    if (widget._editEntry != null) {
      for (final c in widget._editEntry!.surahCoverages) {
        if (c.type != MemorizationCoverageType.none) {
          _coverages[c.surahNumber] = c;
        }
      }
    }
  }

  void _toggleSurah(int surahNumber) {
    setState(() {
      if (_coverages.containsKey(surahNumber)) {
        _coverages.remove(surahNumber);
      } else {
        _coverages[surahNumber] = SurahCoverage(
          surahNumber: surahNumber,
          type: MemorizationCoverageType.full,
        );
      }
      _errorMessage = null;
    });
  }

  void _editCoverage(int surahNumber) async {
    final current = _coverages[surahNumber]!;
    final result = await showModalBottomSheet<SurahCoverage>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => _CoverageEditor(coverage: current),
    );

    if (result != null) {
      setState(() {
        if (result.type == MemorizationCoverageType.none) {
          _coverages.remove(surahNumber);
        } else {
          _coverages[surahNumber] = result;
        }
        _errorMessage = null;
      });
    }
  }

  void _submit() {
    final activeCoverages = _coverages.values.toList();
    if (activeCoverages.isEmpty) {
      setState(() => _errorMessage = 'يرجى اختيار سورة واحدة على الأقل');
      return;
    }

    try {
      final controller = ref.read(setupControllerProvider.notifier);
      if (widget.isEditMode) {
        controller.updateBulkSurahEntry(
          entryId: widget._editEntry!.id,
          surahCoverages: activeCoverages,
        );
      } else {
        controller.addBulkSurahEntry(activeCoverages.map((c) => c.surahNumber).toList());
      }
      Navigator.of(context).pop();
    } on RangeOverlapException catch (e) {
      setState(() => _errorMessage = e.toString());
    } on InvalidRangeException catch (e) {
      setState(() => _errorMessage = e.toString());
    } on OutOfBoundsException catch (e) {
      setState(() => _errorMessage = e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final entries = ref.watch(setupControllerProvider).previousMemorizationEntries;
    final service = ref.read(previousMemorizationServiceProvider);

    // In edit mode, exclude self from availability check
    final entriesForAvailability = widget.isEditMode
        ? entries.where((e) => e.id != widget._editEntry!.id).toList()
        : entries;

    final filteredSurahs = List.generate(QuranMetadata.surahCount, (i) => i + 1)
        .where((n) => QuranMetadata.getSurahName(n).contains(_searchQuery))
        .toList();

    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: const BoxDecoration(
        color: AppColors.surfacePrimary,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            widget.isEditMode ? 'تعديل السور المختارة' : 'إضافة عدة سور',
            style: AppTypography.sectionTitle,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.md),

          // ── Search field ────────────────────────────────────────────────
          TextField(
            decoration: InputDecoration(
              hintText: 'ابحث عن سورة...',
              prefixIcon: const Icon(Icons.search, size: 20),
              contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: AppColors.borderSubtle),
              ),
            ),
            onChanged: (v) => setState(() => _searchQuery = v),
          ),
          const SizedBox(height: AppSpacing.md),

          // ── Inline error ─────────────────────────────────────────────────
          if (_errorMessage != null) ...[
            _ErrorBanner(message: _errorMessage!),
            const SizedBox(height: AppSpacing.sm),
          ],

          // ── Surah list ──────────────────────────────────────────────────
          Expanded(
            child: ListView.separated(
              itemCount: filteredSurahs.length,
              separatorBuilder: (_, __) => const Divider(height: 1, color: AppColors.borderSubtle),
              itemBuilder: (context, index) {
                final surahNumber = filteredSurahs[index];
                final coverage = _coverages[surahNumber];
                final isSelected = coverage != null;
                
                final availability = service.getSurahAvailability(
                  surahNumber: surahNumber,
                  entries: entriesForAvailability,
                );
                
                final isFullyCovered = availability.status == MemorizationAvailability.fullyCovered;
                final isPartialCovered = availability.status == MemorizationAvailability.partiallyCovered;
                
                // Disable if covered by ANOTHER entry.
                // If it's part of the current entry, it's editable even if fully/partially covered by others?
                // Actually the rule says: "Fully/partially covered Surahs from other entries should be disabled in bulk mode."
                final isDisabled = (isFullyCovered || isPartialCovered) && !isSelected;

                return ListTile(
                  dense: true,
                  visualDensity: VisualDensity.compact,
                  enabled: !isDisabled,
                  onTap: isDisabled 
                      ? null 
                      : isSelected 
                          ? () => _editCoverage(surahNumber)
                          : () => _toggleSurah(surahNumber),
                  title: Row(
                    children: [
                      Text(
                        QuranMetadata.getSurahName(surahNumber),
                        style: AppTypography.label.copyWith(
                          color: isDisabled ? AppColors.textSecondary : null,
                        ),
                      ),
                      if (isSelected) ...[
                        const SizedBox(width: AppSpacing.xs),
                        const Icon(Icons.edit_outlined, size: 14, color: AppColors.actionPrimary),
                      ],
                    ],
                  ),
                  subtitle: Text(
                    isSelected
                        ? (coverage.type == MemorizationCoverageType.full
                            ? 'كاملة'
                            : 'الآيات ${coverage.fromAyah}–${coverage.toAyah}')
                        : isFullyCovered
                            ? 'مضافة مسبقًا'
                            : isPartialCovered
                                ? 'أضيفت جزئيًا — عدّلها من إضافة سورة أو آيات'
                                : 'متاحة',
                    style: AppTypography.caption.copyWith(
                      color: isSelected
                          ? AppColors.actionPrimary
                          : isFullyCovered
                              ? AppColors.textSecondary
                              : isPartialCovered
                                  ? AppColors.error
                                  : AppColors.actionPrimary,
                      fontWeight: isSelected ? FontWeight.bold : null,
                    ),
                  ),
                  trailing: Checkbox(
                    value: isSelected,
                    onChanged: isDisabled ? null : (_) => _toggleSurah(surahNumber),
                    activeColor: AppColors.actionPrimary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: AppSpacing.md),

          // ── Submit button ──────────────────────────────────────────────
          ElevatedButton(
            onPressed: (widget.isEditMode && !_hasChanges()) ? null : _submit,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.actionPrimary,
              disabledBackgroundColor: AppColors.borderSubtle,
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: Text(
              _coverages.isEmpty
                  ? 'اختر السور'
                  : widget.isEditMode
                      ? 'حفظ التعديلات (${_coverages.length})'
                      : 'إضافة ${_coverages.length} ${_coverages.length >= 3 && _coverages.length <= 10 ? 'سور' : 'سورة'}',
              style: TextStyle(
                color: (widget.isEditMode && !_hasChanges()) ? AppColors.textSecondary : Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
        ],
      ),
    );
  }
  bool _hasChanges() {
    final edit = widget._editEntry;
    if (edit == null) return true;

    // Active entries in current state
    final currentList = _coverages.values.toList()
      ..sort((a, b) => a.surahNumber.compareTo(b.surahNumber));

    // Active entries in original state
    final originalList = edit.surahCoverages
        .where((c) => c.type != MemorizationCoverageType.none)
        .toList()
      ..sort((a, b) => a.surahNumber.compareTo(b.surahNumber));

    if (currentList.length != originalList.length) return true;

    for (int i = 0; i < currentList.length; i++) {
      final c = currentList[i];
      final o = originalList[i];
      if (c.surahNumber != o.surahNumber) return true;
      if (c.type != o.type) return true;
      if (c.type == MemorizationCoverageType.partial) {
        if (c.fromAyah != o.fromAyah) return true;
        if (c.toAyah != o.toAyah) return true;
      }
    }
    return false;
  }
}

class _CoverageEditor extends StatefulWidget {
  const _CoverageEditor({required this.coverage});
  final SurahCoverage coverage;

  @override
  State<_CoverageEditor> createState() => _CoverageEditorState();
}

class _CoverageEditorState extends State<_CoverageEditor> {
  late MemorizationCoverageType _type;
  late TextEditingController _fromController;
  late TextEditingController _toController;
  String? _error;

  @override
  void initState() {
    super.initState();
    _type = widget.coverage.type;
    final totalAyahs = QuranMetadata.getAyahCount(widget.coverage.surahNumber);
    _fromController = TextEditingController(text: '${widget.coverage.fromAyah ?? 1}');
    _toController = TextEditingController(text: '${widget.coverage.toAyah ?? totalAyahs}');
  }

  @override
  void dispose() {
    _fromController.dispose();
    _toController.dispose();
    super.dispose();
  }

  void _save() {
    if (_type == MemorizationCoverageType.partial) {
      final from = int.tryParse(_fromController.text);
      final to = int.tryParse(_toController.text);
      final total = QuranMetadata.getAyahCount(widget.coverage.surahNumber);

      if (from == null || to == null) {
        setState(() => _error = 'يرجى إدخال أرقام صحيحة');
        return;
      }
      if (from < 1 || to > total) {
        setState(() => _error = 'الأرقام يجب أن تكون بين 1 و $total');
        return;
      }
      if (to < from) {
        setState(() => _error = 'نهاية الآيات يجب أن تكون بعد بدايتها');
        return;
      }

      Navigator.of(context).pop(SurahCoverage(
        surahNumber: widget.coverage.surahNumber,
        type: MemorizationCoverageType.partial,
        fromAyah: from,
        toAyah: to,
      ));
    } else {
      Navigator.of(context).pop(SurahCoverage(
        surahNumber: widget.coverage.surahNumber,
        type: _type,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
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
            'تعديل حفظ سورة ${QuranMetadata.getSurahName(widget.coverage.surahNumber)}',
            style: AppTypography.label,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.md),
          
          RadioListTile<MemorizationCoverageType>(
            title: const Text('السورة كاملة', style: AppTypography.bodySmall),
            value: MemorizationCoverageType.full,
            groupValue: _type,
            activeColor: AppColors.actionPrimary,
            onChanged: (v) => setState(() => _type = v!),
          ),
          RadioListTile<MemorizationCoverageType>(
            title: const Text('آيات محددة', style: AppTypography.bodySmall),
            value: MemorizationCoverageType.partial,
            groupValue: _type,
            activeColor: AppColors.actionPrimary,
            onChanged: (v) => setState(() => _type = v!),
          ),
          
          if (_type == MemorizationCoverageType.partial) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _fromController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: 'من آية'),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: TextField(
                      controller: _toController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: 'إلى آية'),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
          ],
          
          RadioListTile<MemorizationCoverageType>(
            title: const Text('إزالة من المجموعة', style: AppTypography.bodySmall),
            value: MemorizationCoverageType.none,
            groupValue: _type,
            activeColor: AppColors.error,
            onChanged: (v) => setState(() => _type = v!),
          ),

          if (_error != null) ...[
            const SizedBox(height: AppSpacing.sm),
            Text(_error!, style: AppTypography.caption.copyWith(color: AppColors.error), textAlign: TextAlign.center),
          ],

          const SizedBox(height: AppSpacing.lg),
          ElevatedButton(
            onPressed: _save,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.actionPrimary,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: const Text('حفظ', style: TextStyle(color: Colors.white)),
          ),
          const SizedBox(height: AppSpacing.sm),
        ],
      ),
    );
  }
}

class _ErrorBanner extends StatelessWidget {
  const _ErrorBanner({required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
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
              message,
              style: AppTypography.caption.copyWith(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
  }
}
