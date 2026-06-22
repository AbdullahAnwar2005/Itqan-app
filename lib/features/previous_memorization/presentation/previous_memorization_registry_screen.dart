import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:itqan/core/constants/juz_metadata.dart';
import 'package:itqan/core/constants/quran_metadata.dart';
import 'package:itqan/core/design/components/itqan_top_app_bar.dart';
import 'package:itqan/core/design/tokens/app_spacing.dart';
import 'package:itqan/core/design/tokens/app_typography.dart';
import 'package:itqan/features/plan/application/plan_providers.dart';
import 'package:itqan/features/previous_memorization/data/previous_memorization_repository.dart';
import 'package:itqan/features/previous_memorization/domain/previous_memorized_range.dart';
import 'package:itqan/features/previous_memorization/application/previous_memorization_import_service.dart';

class PreviousMemorizationRegistryScreen extends ConsumerWidget {
  const PreviousMemorizationRegistryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activePlanAsync = ref.watch(activePlanProvider);

    return Scaffold(
      appBar: const ItqanTopAppBar(title: 'الحفظ السابق'),
      body: activePlanAsync.when(
        data: (plan) {
          if (plan == null) {
            return const Center(child: Text('لا توجد خطة نشطة'));
          }

          final rangesStream = ref.watch(
            StreamProvider((ref) {
              final repo = ref.watch(previousMemorizationRepositoryProvider);
              return repo.watchRangesForPlan(plan.id);
            }),
          );

          return rangesStream.when(
            data: (ranges) {
              return ListView(
                padding: const EdgeInsets.all(AppSpacing.lg),
                children: [
                  Text(
                    'نطاقات الحفظ التي أدخلتها',
                    style: AppTypography.cardTitle,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  if (ranges.isEmpty)
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.all(AppSpacing.xl),
                        child: Text('لم تقم بإضافة أي حفظ سابق بعد.'),
                      ),
                    )
                  else
                    ...ranges.map((range) => _RangeTile(range: range, planId: plan.id)),
                  const SizedBox(height: AppSpacing.xxl),
                  FilledButton.icon(
                    icon: const Icon(Icons.add),
                    label: const Text('أضف سورة كاملة'),
                    onPressed: () => _showAddSurahDialog(context, ref, plan.id),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  OutlinedButton.icon(
                    icon: const Icon(Icons.library_books),
                    label: const Text('أضف جزء كامل'),
                    onPressed: () => _showAddJuzDialog(context, ref, plan.id),
                  ),
                ],
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) => Center(child: Text('خطأ: $err')),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('خطأ: $err')),
      ),
    );
  }

  void _showAddSurahDialog(BuildContext context, WidgetRef ref, String planId) {
    showDialog(
      context: context,
      builder: (ctx) {
        return _AddSurahDialog(planId: planId);
      },
    );
  }

  void _showAddJuzDialog(BuildContext context, WidgetRef ref, String planId) {
    showDialog(
      context: context,
      builder: (ctx) {
        return _AddJuzDialog(planId: planId);
      },
    );
  }
}

class _RangeTile extends ConsumerWidget {
  const _RangeTile({required this.range, required this.planId});

  final PreviousMemorizedRange range;
  final String planId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final startSurahName = QuranMetadata.getSurahName(range.startSurah);
    final endSurahName = QuranMetadata.getSurahName(range.endSurah);
    
    final isSingleSurah = range.startSurah == range.endSurah;
    final isFullSurah = isSingleSurah && 
                        range.startAyah == 1 && 
                        range.endAyah == QuranMetadata.getAyahCount(range.endSurah);

    String title;
    String subtitle = '';
    if (isFullSurah) {
      title = 'سورة $startSurahName';
    } else if (isSingleSurah) {
      title = 'سورة $startSurahName';
      subtitle = 'الآيات: ${range.startAyah} - ${range.endAyah}';
    } else {
      title = 'من $startSurahName إلى $endSurahName';
      subtitle = 'من آية ${range.startAyah} إلى آية ${range.endAyah}';
    }

    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: ListTile(
        title: Text(title, style: AppTypography.label),
        subtitle: subtitle.isNotEmpty ? Text(subtitle, style: AppTypography.bodySmall) : null,
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: () async {
            final repo = ref.read(previousMemorizationRepositoryProvider);
            await repo.deleteRange(range.id);
          },
        ),
      ),
    );
  }
}

class _AddSurahDialog extends ConsumerStatefulWidget {
  const _AddSurahDialog({required this.planId});

  final String planId;

  @override
  ConsumerState<_AddSurahDialog> createState() => _AddSurahDialogState();
}

class _AddSurahDialogState extends ConsumerState<_AddSurahDialog> {
  int? _selectedSurah;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('أضف سورة كاملة'),
      content: DropdownButtonFormField<int>(
      initialValue: _selectedSurah,
        hint: const Text('اختر السورة'),
        items: List.generate(114, (i) => i + 1).map((number) {
          return DropdownMenuItem(
            value: number,
            child: Text('$number. سورة ${QuranMetadata.getSurahName(number)}'),
          );
        }).toList(),
        onChanged: (val) {
          setState(() {
            _selectedSurah = val;
          });
        },
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('إلغاء'),
        ),
        FilledButton(
          onPressed: _selectedSurah == null || _isLoading
              ? null
              : () async {
                  setState(() => _isLoading = true);
                  final repo = ref.read(previousMemorizationRepositoryProvider);
                  
                  final newRange = PreviousMemorizedRange(
                    id: 'prev_${DateTime.now().millisecondsSinceEpoch}',
                    planId: widget.planId,
                    startSurah: _selectedSurah!,
                    startAyah: 1,
                    endSurah: _selectedSurah!,
                    endAyah: QuranMetadata.getAyahCount(_selectedSurah!),
                    source: PreviousMemorizationSource.surahShortcut,
                    createdAt: DateTime.now(),
                    updatedAt: DateTime.now(),
                  );

                  try {
                    await repo.addRange(newRange);

                    final importService = ref.read(previousMemorizationImportServiceProvider);
                    await importService.importSingleRange(widget.planId, newRange);

                    if (context.mounted) Navigator.of(context).pop();
                  } catch (e) {
                    setState(() => _isLoading = false);
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('خطأ: ${e.toString()}')),
                      );
                    }
                  }
                },
          child: _isLoading ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2)) : const Text('إضافة'),
        ),
      ],
    );
  }
}

class _AddJuzDialog extends ConsumerStatefulWidget {
  const _AddJuzDialog({required this.planId});

  final String planId;

  @override
  ConsumerState<_AddJuzDialog> createState() => _AddJuzDialogState();
}

class _AddJuzDialogState extends ConsumerState<_AddJuzDialog> {
  int? _selectedJuz;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('أضف جزء كامل'),
      content: DropdownButtonFormField<int>(
      initialValue: _selectedJuz,
        hint: const Text('اختر الجزء'),
        items: List.generate(30, (i) => i + 1).map((number) {
          return DropdownMenuItem(
            value: number,
            child: Text('الجزء $number'),
          );
        }).toList(),
        onChanged: (val) {
          setState(() {
            _selectedJuz = val;
          });
        },
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('إلغاء'),
        ),
        FilledButton(
          onPressed: _selectedJuz == null || _isLoading
              ? null
              : () async {
                  setState(() => _isLoading = true);
                  final repo = ref.read(previousMemorizationRepositoryProvider);
                  
                  final juzMeta = JuzMetadata.getByNumber(_selectedJuz!);

                  final newRange = PreviousMemorizedRange(
                    id: 'prev_${DateTime.now().millisecondsSinceEpoch}',
                    planId: widget.planId,
                    startSurah: juzMeta.start.surahNumber,
                    startAyah: juzMeta.start.ayahNumber,
                    endSurah: juzMeta.end.surahNumber,
                    endAyah: juzMeta.end.ayahNumber,
                    source: PreviousMemorizationSource.juzShortcut,
                    createdAt: DateTime.now(),
                    updatedAt: DateTime.now(),
                  );

                  try {
                    await repo.addRange(newRange);
                    
                    final importService = ref.read(previousMemorizationImportServiceProvider);
                    await importService.importSingleRange(widget.planId, newRange);

                    if (context.mounted) Navigator.of(context).pop();
                  } catch (e) {
                    setState(() => _isLoading = false);
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('خطأ: ${e.toString()}')),
                      );
                    }
                  }
                },
          child: _isLoading ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2)) : const Text('إضافة'),
        ),
      ],
    );
  }
}
