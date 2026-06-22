import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../core/design/components/itqan_top_app_bar.dart';
import '../../../core/design/theme/itqan_theme_extension.dart';
import '../../../core/design/tokens/app_radius.dart';
import '../../../core/design/tokens/app_spacing.dart';
import '../../../core/design/tokens/app_typography.dart';
import '../application/progress_providers.dart';
import '../domain/progress_insight_models.dart';
import '../domain/segment_progress_source.dart';
import '../domain/segment_progress_status.dart';

class ProgressScreen extends ConsumerWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summaryAsync = ref.watch(progressInsightSummaryProvider);

    return Scaffold(
      appBar: const ItqanTopAppBar(title: 'تقدمي'),
      body: summaryAsync.when(
        data: (summary) =>
            (summary == null || summary.totalTrackedSegments == 0)
                ? const _NoProgressState()
                : _ProgressContent(summary: summary),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) =>
            Center(child: Text('عذرًا، حدث خطأ في تحميل البيانات: $err')),
      ),
    );
  }
}

class _ProgressContent extends StatelessWidget {
  const _ProgressContent({required this.summary});

  final ProgressInsightSummary summary;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionHeader(title: 'نظرة عامة'),
          const SizedBox(height: AppSpacing.xs),
          _OverviewSection(summary: summary),
          const SizedBox(height: AppSpacing.lg),
          const _SectionHeader(title: 'حالة الإتقان'),
          const SizedBox(height: AppSpacing.xs),
          _MasterySection(summary: summary),
          const SizedBox(height: AppSpacing.lg),
          const _SectionHeader(title: 'مصادر الحفظ'),
          const SizedBox(height: AppSpacing.xs),
          _SourcesSection(summary: summary),
          const SizedBox(height: AppSpacing.lg),
          const _SectionHeader(title: 'مقاطع تحتاج انتباه'),
          const SizedBox(height: AppSpacing.xs),
          _PrioritySegmentsSection(summary: summary),
          const SizedBox(height: AppSpacing.lg),
          const _SectionHeader(title: 'النشاط الأخير'),
          const SizedBox(height: AppSpacing.xs),
          _RecentActivitySection(summary: summary),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xs),
      child: Text(
        title,
        style: AppTypography.label.copyWith(
          fontWeight: FontWeight.bold,
          color: theme.textTheme.bodyLarge?.color,
        ),
      ),
    );
  }
}

class _OverviewSection extends StatelessWidget {
  const _OverviewSection({required this.summary});

  final ProgressInsightSummary summary;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final itqanTheme = theme.extension<ItqanThemeExtension>()!;

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _OverviewCard(
                title: 'مقاطع مستقرة',
                value: '${summary.stableCount}',
                color: itqanTheme.completed,
                icon: Icons.verified_user_rounded,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: _OverviewCard(
                title: 'تحتاج تثبيت',
                value: '${summary.stabilizingCount}',
                color: itqanTheme.reviewDue,
                icon: Icons.hourglass_empty_rounded,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        Row(
          children: [
            Expanded(
              child: _OverviewCard(
                title: 'تحتاج انتباه',
                value: '${summary.weakCount + summary.needsRetryCount}',
                color: itqanTheme.overdue,
                icon: Icons.warning_amber_rounded,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: _OverviewCard(
                title: 'مراجعات مستحقة',
                value: '${summary.dueTodayCount}',
                color: itqanTheme.selfTest,
                icon: Icons.alarm_rounded,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _OverviewCard extends StatelessWidget {
  const _OverviewCard({
    required this.title,
    required this.value,
    required this.color,
    required this.icon,
  });

  final String title;
  final String value;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 0,
      color: theme.cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.lg),
        side: BorderSide(color: theme.dividerColor.withValues(alpha: 0.1)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(AppSpacing.sm),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style:
                        AppTypography.caption.copyWith(color: theme.hintColor),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    value,
                    style: AppTypography.cardTitle.copyWith(
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MasterySection extends StatelessWidget {
  const _MasterySection({required this.summary});

  final ProgressInsightSummary summary;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final itqanTheme = theme.extension<ItqanThemeExtension>()!;

    return Column(
      children: [
        _MasteryStatusRow(
          label: 'مستقر',
          count: summary.stableCount,
          color: itqanTheme.completed,
          description: 'تمكنت من حفظها بشكل ممتاز',
        ),
        const SizedBox(height: AppSpacing.xs),
        _MasteryStatusRow(
          label: 'قيد التثبيت',
          count: summary.stabilizingCount,
          color: itqanTheme.reviewDue,
          description: 'تحت المراجعة والتقوية المستمرة',
        ),
        const SizedBox(height: AppSpacing.xs),
        _MasteryStatusRow(
          label: 'ضعيف',
          count: summary.weakCount,
          color: itqanTheme.confidenceLow,
          description: 'أخطاء متكررة أثناء التسميع',
        ),
        const SizedBox(height: AppSpacing.xs),
        _MasteryStatusRow(
          label: 'يحتاج إعادة',
          count: summary.needsRetryCount,
          color: itqanTheme.overdue,
          description: 'يتطلب إعادة الحفظ بالكامل',
        ),
      ],
    );
  }
}

class _MasteryStatusRow extends StatelessWidget {
  const _MasteryStatusRow({
    required this.label,
    required this.count,
    required this.color,
    required this.description,
  });

  final String label;
  final int count;
  final Color color;
  final String description;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 0,
      color: theme.cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.md),
        side: BorderSide(color: theme.dividerColor.withValues(alpha: 0.1)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md, vertical: AppSpacing.sm),
        child: Row(
          children: [
            Container(
              width: 8,
              height: 40,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(AppRadius.xs),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label,
                      style: AppTypography.label
                          .copyWith(fontWeight: FontWeight.bold)),
                  Text(description,
                      style: AppTypography.caption
                          .copyWith(color: theme.hintColor)),
                ],
              ),
            ),
            Text(
              '$count',
              style: AppTypography.cardTitle.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SourcesSection extends StatelessWidget {
  const _SourcesSection({required this.summary});

  final ProgressInsightSummary summary;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final itqanTheme = theme.extension<ItqanThemeExtension>()!;

    return Row(
      children: [
        Expanded(
          child: _SourceCard(
            label: 'من الحفظ الجديد',
            count: summary.appMemorizationCount,
            icon: Icons.add_circle_outline_rounded,
            color: itqanTheme.memorizeActive,
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: _SourceCard(
            label: 'من الحفظ السابق',
            count: summary.previousMemorizationCount,
            icon: Icons.history_edu_rounded,
            color: itqanTheme.reviewDue,
          ),
        ),
      ],
    );
  }
}

class _SourceCard extends StatelessWidget {
  const _SourceCard({
    required this.label,
    required this.count,
    required this.icon,
    required this.color,
  });

  final String label;
  final int count;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 0,
      color: theme.cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.lg),
        side: BorderSide(color: theme.dividerColor.withValues(alpha: 0.1)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: AppSpacing.sm),
            Text(label,
                style: AppTypography.caption.copyWith(color: theme.hintColor)),
            const SizedBox(height: AppSpacing.xs),
            Text(
              '$count مقطع',
              style: AppTypography.body.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.textTheme.bodyLarge?.color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PrioritySegmentsSection extends StatelessWidget {
  const _PrioritySegmentsSection({required this.summary});

  final ProgressInsightSummary summary;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (summary.prioritySegments.isEmpty) {
      return Card(
        elevation: 0,
        color: theme.cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          side: BorderSide(color: theme.dividerColor.withValues(alpha: 0.1)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Center(
            child: Text(
              'لا توجد مقاطع ضعيفة حاليًا.',
              style: AppTypography.bodySmall.copyWith(color: theme.hintColor),
            ),
          ),
        ),
      );
    }

    return Column(
      children: summary.prioritySegments.map((segment) {
        return _PrioritySegmentRow(segment: segment);
      }).toList(),
    );
  }
}

class _PrioritySegmentRow extends StatelessWidget {
  const _PrioritySegmentRow({required this.segment});

  final PrioritySegmentInsight segment;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final itqanTheme = theme.extension<ItqanThemeExtension>()!;

    final isNeedsRetry = segment.status == SegmentProgressStatus.needsRetry;
    final statusColor =
        isNeedsRetry ? itqanTheme.overdue : itqanTheme.confidenceLow;
    final statusText = isNeedsRetry ? 'يحتاج إعادة' : 'ضعيف';

    final sourceText = segment.source == SegmentProgressSource.appMemorization
        ? 'حفظ جديد'
        : 'حفظ سابق';

    return Card(
      elevation: 0,
      color: theme.cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.md),
        side: BorderSide(color: theme.dividerColor.withValues(alpha: 0.1)),
      ),
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    segment.displayRange,
                    style: AppTypography.body.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    'المصدر: $sourceText',
                    style:
                        AppTypography.caption.copyWith(color: theme.hintColor),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm, vertical: AppSpacing.xs),
              decoration: BoxDecoration(
                color: statusColor.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(AppRadius.sm),
                border: Border.all(color: statusColor.withValues(alpha: 0.15)),
              ),
              child: Text(
                statusText,
                style: AppTypography.caption.copyWith(
                  color: statusColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RecentActivitySection extends StatelessWidget {
  const _RecentActivitySection({required this.summary});

  final ProgressInsightSummary summary;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final itqanTheme = theme.extension<ItqanThemeExtension>()!;

    return Card(
      elevation: 0,
      color: theme.cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.lg),
        side: BorderSide(color: theme.dividerColor.withValues(alpha: 0.1)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'عدد الجلسات خلال آخر ٧ أيام:',
                  style:
                      AppTypography.bodySmall.copyWith(color: theme.hintColor),
                ),
                Text(
                  '${summary.recentSessionCount} جلسات',
                  style: AppTypography.body.copyWith(
                    fontWeight: FontWeight.bold,
                    color: itqanTheme.memorizeActive,
                  ),
                ),
              ],
            ),
            const Divider(height: AppSpacing.lg),
            if (summary.lastSessionAt != null) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('آخر جلسة:',
                      style: AppTypography.bodySmall
                          .copyWith(color: theme.hintColor)),
                  Text(
                    DateFormat('yyyy/MM/dd').format(summary.lastSessionAt!),
                    style: AppTypography.bodySmall
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
            ],
            if (summary.recentSessionCount == 0)
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                  child: Text(
                    'لا توجد جلسات حديثة خلال آخر ٧ أيام.',
                    style: AppTypography.bodySmall
                        .copyWith(color: theme.hintColor),
                  ),
                ),
              )
            else ...[
              Text(
                'تقييم الجلسات الأخير:',
                style: AppTypography.caption.copyWith(color: theme.hintColor),
              ),
              const SizedBox(height: AppSpacing.sm),
              _buildRatingBreakdown(context, summary.ratingBreakdown),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildRatingBreakdown(
      BuildContext context, SessionRatingBreakdown breakdown) {
    final itqanTheme = Theme.of(context).extension<ItqanThemeExtension>()!;

    final items = <_RatingChip>[
      _RatingChip(
          label: 'سهل',
          count: breakdown.easyCount,
          color: itqanTheme.completed),
      _RatingChip(
          label: 'جيد',
          count: breakdown.goodCount,
          color: itqanTheme.reviewDue),
      _RatingChip(
          label: 'صعب',
          count: breakdown.hardCount,
          color: itqanTheme.confidenceLow),
      _RatingChip(
          label: 'لم أتمكن',
          count: breakdown.againCount,
          color: itqanTheme.overdue),
      if (breakdown.unratedCount > 0)
        _RatingChip(
            label: 'غير مقيّم',
            count: breakdown.unratedCount,
            color: Theme.of(context).hintColor),
    ];

    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.sm,
      children: items.map((item) {
        return Container(
          padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.sm, vertical: AppSpacing.xs),
          decoration: BoxDecoration(
            color: item.color.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(AppRadius.sm),
            border: Border.all(color: item.color.withValues(alpha: 0.15)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                item.label,
                style: AppTypography.caption
                    .copyWith(color: item.color, fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: AppSpacing.xs),
              Text(
                '(${item.count})',
                style: AppTypography.caption
                    .copyWith(color: item.color, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class _RatingChip {
  const _RatingChip({
    required this.label,
    required this.count,
    required this.color,
  });

  final String label;
  final int count;
  final Color color;
}

class _NoProgressState extends StatelessWidget {
  const _NoProgressState();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.bar_chart_rounded,
              size: 48,
              color: theme.hintColor.withValues(alpha: 0.5),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              'لا توجد بيانات كافية بعد. ابدأ جلسات الحفظ والمراجعة ليظهر تقدمك هنا.',
              textAlign: TextAlign.center,
              style: AppTypography.bodyLarge.copyWith(
                color: theme.hintColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
