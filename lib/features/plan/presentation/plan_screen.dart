import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:itqan/core/routing/app_router.dart';
import 'package:itqan/features/plan/domain/plan_status.dart';

import '../../../core/constants/quran_metadata.dart';
import '../../../core/design/components/itqan_top_app_bar.dart';
import '../../../core/design/tokens/app_radius.dart';
import '../../../core/design/tokens/app_spacing.dart';
import '../../../core/design/tokens/app_typography.dart';
import '../../../core/utils/arabic_formatter.dart';
import '../application/plan_providers.dart';
import '../domain/active_plan.dart';
import '../domain/day_assignment.dart';
import '../domain/quran_position.dart';

class PlanScreen extends ConsumerWidget {
  const PlanScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<ActivePlanEntity?> activePlanAsync =
        ref.watch(activePlanProvider);

    return Scaffold(
      appBar: ItqanTopAppBar(
        title: 'الخطة',
        actions: [
          IconButton(
            onPressed: () => context.pushNamed(AppRoutes.settings),
            icon: const Icon(Icons.settings_outlined),
          ),
        ],
      ),
      body: activePlanAsync.when(
        data: (plan) => plan == null
            ? const _NoActivePlanState()
            : _ActivePlanState(plan: plan),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
}

class _NoActivePlanState extends ConsumerStatefulWidget {
  const _NoActivePlanState();

  @override
  _NoActivePlanStateState createState() => _NoActivePlanStateState();
}

class _NoActivePlanStateState extends ConsumerState<_NoActivePlanState> {
  int _selectedSurah = 1;
  int _selectedAyah = 1;

  void _onSurahChanged(int surah) {
    setState(() {
      _selectedSurah = surah;
      final maxAyahs = QuranMetadata.getAyahCount(surah);
      if (_selectedAyah > maxAyahs) {
        _selectedAyah = maxAyahs;
      }
    });
  }

  void _onAyahChanged(int ayah) {
    setState(() {
      _selectedAyah = ayah;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final controllerState = ref.watch(planControllerProvider);

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.auto_stories_outlined,
              size: 64,
              color: theme.colorScheme.primary.withValues(alpha: 0.5),
            ),
            const SizedBox(height: AppSpacing.xl),
            Text(
              'أنشئ خطتك الأولى',
              style: AppTypography.pageTitle,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              'حدد من أين ستبدأ حفظك الجديد اليوم وسنقوم بتوليد وردك اليومي تلقائياً.',
              style: AppTypography.body.copyWith(color: theme.hintColor),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.xxl),
            _StartingPositionCard(
              surah: _selectedSurah,
              ayah: _selectedAyah,
              onSurahChanged: _onSurahChanged,
              onAyahChanged: _onAyahChanged,
            ),
            const SizedBox(height: AppSpacing.xxl),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: controllerState.isLoading
                    ? null
                    : () {
                        ref.read(planControllerProvider.notifier).createPlan(
                              QuranPosition(
                                surahNumber: _selectedSurah,
                                ayahNumber: _selectedAyah,
                              ),
                            );
                      },
                child: controllerState.isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('بدء الخطة الآن'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StartingPositionCard extends StatelessWidget {
  const _StartingPositionCard({
    required this.surah,
    required this.ayah,
    required this.onSurahChanged,
    required this.onAyahChanged,
  });

  final int surah;
  final int ayah;
  final ValueChanged<int> onSurahChanged;
  final ValueChanged<int> onAyahChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: theme.dividerColor.withOpacity(0.1)),
      ),
      child: Column(
        children: [
          _PositionPickerField(
            label: 'السورة',
            value: QuranMetadata.getSurahName(surah),
            onTap: () => _showSurahPicker(context),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: AppSpacing.lg),
            child: Divider(),
          ),
          _PositionPickerField(
            label: 'الآية',
            value: ayah.toString(),
            onTap: () => _showAyahPicker(context),
          ),
        ],
      ),
    );
  }

  void _showSurahPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _SurahPickerSheet(
        initialSurah: surah,
        onSelected: (newSurah) {
          onSurahChanged(newSurah);
          // Revalidate ayah: if current ayah > max ayahs in new surah, reset to 1
          final maxAyahs = QuranMetadata.getAyahCount(newSurah);
          if (ayah > maxAyahs) {
            onAyahChanged(1);
          }
        },
      ),
    );
  }

  void _showAyahPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _AyahPickerSheet(
        surah: surah,
        initialAyah: ayah,
        onSelected: onAyahChanged,
      ),
    );
  }
}

class _PositionPickerField extends StatelessWidget {
  const _PositionPickerField({
    required this.label,
    required this.value,
    required this.onTap,
  });

  final String label;
  final String value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.md),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: AppTypography.bodySmall.copyWith(color: theme.hintColor)),
                  const SizedBox(height: AppSpacing.xs),
                  Text(value, style: AppTypography.cardTitle),
                ],
              ),
            ),
            Icon(Icons.unfold_more_rounded, color: theme.hintColor),
          ],
        ),
      ),
    );
  }
}

class _SurahPickerSheet extends StatefulWidget {
  const _SurahPickerSheet({
    required this.initialSurah,
    required this.onSelected,
  });

  final int initialSurah;
  final ValueChanged<int> onSelected;

  @override
  State<_SurahPickerSheet> createState() => _SurahPickerSheetState();
}

class _SurahPickerSheetState extends State<_SurahPickerSheet> {
  String _query = '';
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final filteredSurahs = List.generate(114, (i) => i + 1).where((s) {
      final name = QuranMetadata.getSurahName(s);
      return name.contains(_query) || s.toString().contains(_query);
    }).toList();

    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(AppRadius.xl)),
      ),
      child: Column(
        children: [
          const SizedBox(height: AppSpacing.md),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: theme.dividerColor,
              borderRadius: BorderRadius.circular(AppRadius.full),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.xl),
            child: TextField(
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'بحث عن سورة...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: theme.cardColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (val) => setState(() => _query = val),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredSurahs.length,
              itemBuilder: (context, index) {
                final s = filteredSurahs[index];
                final isSelected = s == widget.initialSurah;
                return ListTile(
                  title: Text(QuranMetadata.getSurahName(s)),
                  trailing: Text(s.toString(), style: AppTypography.bodySmall),
                  selected: isSelected,
                  onTap: () {
                    widget.onSelected(s);
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _AyahPickerSheet extends StatelessWidget {
  const _AyahPickerSheet({
    required this.surah,
    required this.initialAyah,
    required this.onSelected,
  });

  final int surah;
  final int initialAyah;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final ayahCount = QuranMetadata.getAyahCount(surah);

    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(AppRadius.xl)),
      ),
      child: Column(
        children: [
          const SizedBox(height: AppSpacing.md),
          Text(
            'اختر الآية - سورة ${QuranMetadata.getSurahName(surah)}',
            style: AppTypography.label,
          ),
          const SizedBox(height: AppSpacing.md),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(AppSpacing.lg),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                mainAxisSpacing: AppSpacing.sm,
                crossAxisSpacing: AppSpacing.sm,
              ),
              itemCount: ayahCount,
              itemBuilder: (context, index) {
                final a = index + 1;
                final isSelected = a == initialAyah;
                return InkWell(
                  onTap: () {
                    onSelected(a);
                    Navigator.pop(context);
                  },
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isSelected ? theme.colorScheme.primary : theme.cardColor,
                      borderRadius: BorderRadius.circular(AppRadius.sm),
                      border: Border.all(color: theme.dividerColor.withValues(alpha: 0.1)),
                    ),
                    child: Text(
                      a.toString(),
                      style: AppTypography.label.copyWith(
                        color: isSelected ? theme.colorScheme.onPrimary : null,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ActivePlanState extends ConsumerWidget {
  const _ActivePlanState({required this.plan});

  final ActivePlanEntity plan;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final assignmentAsync = ref.watch(todayAssignmentProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _PlanSummaryCard(plan: plan),
          const SizedBox(height: AppSpacing.xxl),
          Text(
            'عمل اليوم',
            style: AppTypography.cardTitle,
          ),
          const SizedBox(height: AppSpacing.lg),
          assignmentAsync.when(
            data: (assignment) {
              if (plan.status == PlanStatus.paused) {
                return const _PausedPlanMessage();
              }
              return assignment == null
                  ? const Text('لا يوجد مهام لليوم')
                  : _AssignmentCard(assignment: assignment);
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, _) => Text('Error: $err'),
          ),
        ],
      ),
    );
  }
}

class _PlanSummaryCard extends StatelessWidget {
  const _PlanSummaryCard({required this.plan});

  final ActivePlanEntity plan;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: theme.colorScheme.primary.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('نظرة عامة على الخطة', style: AppTypography.label),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                      color: (plan.status == PlanStatus.active
                          ? Colors.green
                          : Colors.orange)
                      .withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppRadius.full),
                ),
                child: Text(
                  plan.status == PlanStatus.active ? 'نشطة' : 'متوقفة',
                  style: AppTypography.label.copyWith(
                    color: plan.status == PlanStatus.active
                        ? Colors.green
                        : Colors.orange,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'البداية من: ${ArabicFormatter.formatPosition(plan.startPosition)}',
            style: AppTypography.cardTitle,
          ),
          const SizedBox(height: AppSpacing.xl),
          Row(
            children: [
              _PlanMetric(
                label: 'هدف الحفظ',
                value: ArabicFormatter.formatTarget(plan.memorizationTarget),
              ),
              const Spacer(),
              _PlanMetric(
                label: 'هدف المراجعة',
                value: ArabicFormatter.formatTarget(plan.reviewTarget),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PlanMetric extends StatelessWidget {
  const _PlanMetric({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTypography.bodySmall),
        Text(value, style: AppTypography.label),
      ],
    );
  }
}

class _AssignmentCard extends StatelessWidget {
  const _AssignmentCard({required this.assignment});

  final DayAssignmentEntity assignment;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: theme.dividerColor.withOpacity(0.1)),
      ),
      child: Column(
        children: [
          _AssignmentRow(
            label: 'الحفظ',
            value: ArabicFormatter.formatRange(
                assignment.memoStart, assignment.memoEnd),
          ),
          const Divider(height: AppSpacing.xxl),
          _AssignmentRow(
            label: 'المراجعة',
            value: ArabicFormatter.formatTarget(assignment.reviewTarget),
          ),
        ],
      ),
    );
  }
}

class _AssignmentRow extends StatelessWidget {
  const _AssignmentRow({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: AppTypography.bodySmall),
              Text(value, style: AppTypography.label),
            ],
          ),
        ),
        Icon(Icons.chevron_left_rounded, color: Theme.of(context).hintColor),
      ],
    );
  }
}

class _PausedPlanMessage extends StatelessWidget {
  const _PausedPlanMessage();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        color: Colors.orange.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: Colors.orange.withValues(alpha: 0.1)),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.pause_circle_filled_rounded,
            size: 48,
            color: Colors.orange,
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'الخطة متوقفة مؤقتاً',
            style: AppTypography.label.copyWith(color: Colors.orange, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'لن يتم توليد مهام جديدة حتى تقوم باستئناف الخطة من صفحة الإعدادات.',
            textAlign: TextAlign.center,
            style: AppTypography.bodySmall.copyWith(color: theme.hintColor),
          ),
        ],
      ),
    );
  }
}
