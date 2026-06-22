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
import '../domain/session_rating.dart';

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
        title: const Text('إيقاف الجلسة؟'),
        content: const Text(
            'هل تود التوقف عن الجلسة الحالية؟ لن يتم حفظ ما أنجزته.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إكمال الجلسة'),
          ),
          TextButton(
            onPressed: () {
              ref.read(sessionControllerProvider.notifier).cancelSession();
              Navigator.pop(context);
              context.go('/');
            },
            child: Text(
              'توقف',
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
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
            color: color.withValues(alpha: 0.1),
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
              ? 'مقرر الحفظ'
              : 'مقرر المراجعة',
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
        Text(
          'كيف كان التسميع؟',
          style: AppTypography.cardTitle,
        ),
        const SizedBox(height: AppSpacing.lg),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _RatingButton(
              rating: SessionRating.easy,
              color: Colors.green,
              onPressed: () => _handleRating(context, ref, SessionRating.easy),
            ),
            _RatingButton(
              rating: SessionRating.good,
              color: Colors.blue,
              onPressed: () => _handleRating(context, ref, SessionRating.good),
            ),
            _RatingButton(
              rating: SessionRating.hard,
              color: Colors.orange,
              onPressed: () => _handleRating(context, ref, SessionRating.hard),
            ),
            _RatingButton(
              rating: SessionRating.again,
              color: Colors.red,
              onPressed: () => _handleRating(context, ref, SessionRating.again),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _handleRating(BuildContext context, WidgetRef ref, SessionRating rating) async {
    await ref.read(sessionControllerProvider.notifier).completeSession(rating);
    if (context.mounted) {
      _showCompletionDialog(context, ref, rating);
    }
  }

  void _showCompletionDialog(BuildContext context, WidgetRef ref, SessionRating rating) {
    final isAgain = rating == SessionRating.again && session.type == SessionType.memorization;
    
    final iconColor = isAgain ? Colors.orange : Colors.green;
    final iconData = isAgain ? Icons.info_outline_rounded : Icons.check_circle_rounded;
    final title = isAgain ? 'محاولة جيدة' : 'الحمد لله';
    final message = isAgain 
        ? 'تم تسجيل المحاولة. سيبقى هذا الورد حتى تتمكن من تسميعه.' 
        : 'لقد أتممت وردك اليوم بنجاح.';

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.lg)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: AppSpacing.md),
            Icon(iconData, color: iconColor, size: 64),
            const SizedBox(height: AppSpacing.lg),
            Text(title, style: AppTypography.cardTitle),
            const SizedBox(height: AppSpacing.sm),
            Text(
              message,
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
              child: const Text('العودة'),
            ),
          ),
        ],
      ),
    );
  }
}

class _RatingButton extends StatelessWidget {
  const _RatingButton({
    required this.rating,
    required this.color,
    required this.onPressed,
  });

  final SessionRating rating;
  final Color color;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: color.withValues(alpha: 0.1),
            foregroundColor: color,
            elevation: 0,
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadius.md),
              side: BorderSide(color: color.withValues(alpha: 0.3)),
            ),
          ),
          child: Text(
            rating.labelAr,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
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
              color: Theme.of(context).hintColor.withValues(alpha: 0.5),
            ),
            const SizedBox(height: AppSpacing.md),
            const Text(
              'لا توجد جلسة حالياً.',
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
