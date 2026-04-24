import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/design/tokens/app_spacing.dart';
import '../../../core/design/tokens/app_typography.dart';
import '../../../core/design/theme/itqan_theme_extension.dart';
import '../../../core/design/tokens/app_radius.dart';
import '../../../core/utils/arabic_formatter.dart';
import '../application/session_providers.dart';
import '../domain/session.dart';

class SessionScreen extends ConsumerWidget {
  const SessionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(sessionControllerProvider);

    if (session == null) {
      return const _NoActiveSessionState();
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text(session.type.label),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => _handleCancel(context, ref),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.xl,
            vertical: AppSpacing.xxl,
          ),
          child: Column(
            children: [
              const Spacer(),
              _SessionContent(session: session),
              const Spacer(),
              _SessionActions(session: session),
            ],
          ),
        ),
      ),
    );
  }

  void _handleCancel(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('إلغاء الجلسة؟'),
        content: const Text(
            'هل أنت متأكد من رغبتك في إلغاء الجلسة الحالية؟ لن يتم حفظ التقدم.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('استمرار'),
          ),
          TextButton(
            onPressed: () {
              ref.read(sessionControllerProvider.notifier).cancelSession();
              Navigator.pop(context);
              // Go back to today
              context.go('/');
            },
            child: const Text('إلغاء', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

class _SessionContent extends StatelessWidget {
  const _SessionContent({required this.session});

  final WorkSession session;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final itqanTheme = theme.extension<ItqanThemeExtension>()!;

    final color = session.type == SessionType.memorization
        ? itqanTheme.memorizeActive
        : itqanTheme.reviewDue;

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(AppSpacing.xl),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            session.type == SessionType.memorization
                ? Icons.menu_book_rounded
                : Icons.history_rounded,
            size: 48,
            color: color,
          ),
        ),
        const SizedBox(height: AppSpacing.xxl),
        Text(
          session.type == SessionType.memorization
              ? 'النطاق المستهدف'
              : 'المراجعة المطلوبة',
          style: AppTypography.label.copyWith(color: theme.hintColor),
        ),
        const SizedBox(height: AppSpacing.md),
        if (session.type == SessionType.memorization) ...[
          Text(
            ArabicFormatter.formatRange(
              session.assignment.memoStart,
              session.assignment.memoEnd,
            ),
            style: AppTypography.cardTitle.copyWith(fontSize: 28),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            ArabicFormatter.formatTarget(session.assignment.memoTarget),
            style: AppTypography.body.copyWith(color: theme.hintColor),
          ),
        ] else ...[
          Text(
            ArabicFormatter.formatTarget(session.assignment.reviewTarget),
            style: AppTypography.cardTitle.copyWith(fontSize: 28),
            textAlign: TextAlign.center,
          ),
        ],
      ],
    );
  }
}

class _SessionActions extends ConsumerWidget {
  const _SessionActions({required this.session});

  final WorkSession session;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () async {
              await ref
                  .read(sessionControllerProvider.notifier)
                  .completeSession();
              if (context.mounted) {
                _showCompletionDialog(context, ref);
              }
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadius.md),
              ),
            ),
            child: const Text('إتمام الجلسة',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
        ),
      ],
    );
  }

  void _showCompletionDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.lg)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: AppSpacing.md),
            const Icon(Icons.check_circle_rounded, color: Colors.green, size: 64),
            const SizedBox(height: AppSpacing.lg),
            Text('أحسنت! الحمد لله', style: AppTypography.cardTitle),
            const SizedBox(height: AppSpacing.sm),
            const Text(
              'لقد أتممت وردك بنجاح. استمر في هذا الإنجاز!',
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                ref.read(sessionControllerProvider.notifier).reset();
                Navigator.pop(context);
                context.go('/');
              },
              child: const Text('العودة للرئيسية'),
            ),
          ),
        ],
      ),
    );
  }
}

class _NoActiveSessionState extends StatelessWidget {
  const _NoActiveSessionState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('الجلسة')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.play_circle_outline,
              size: 64,
              color: Theme.of(context).hintColor.withOpacity(0.5),
            ),
            const SizedBox(height: AppSpacing.md),
            const Text(
              'لا توجد جلسة نشطة حالياً.',
              style: AppTypography.bodyLarge,
            ),
            const SizedBox(height: AppSpacing.lg),
            ElevatedButton(
              onPressed: () => context.go('/'),
              child: const Text('انتقل لصفحة اليوم'),
            ),
          ],
        ),
      ),
    );
  }
}
