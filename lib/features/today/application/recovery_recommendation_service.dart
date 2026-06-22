import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/recovery_notice.dart';
import '../domain/recovery_recommendation.dart';
import '../domain/today_mode.dart';

class RecoveryRecommendationService {
  const RecoveryRecommendationService();

  RecoveryRecommendation? buildRecommendation({
    required RecoveryNotice? notice,
    required bool hasNearReview,
    required bool hasOldReview,
    required bool isMemorizationDeferred,
    required TodayMode currentMode,
  }) {
    if (notice == null || !notice.hasMissedWork || notice.missedDaysCount <= 0) {
      return null;
    }

    final int missedDays = notice.missedDaysCount;

    if (missedDays == 1) {
      return RecoveryRecommendation(
        severity: RecoverySeverity.light,
        title: 'رجوع بسيط للخطة',
        message: 'لديك تأخر بسيط. ابدأ بالتثبيت ثم أكمل وردك المعتاد إن استطعت.',
        recommendedMode: TodayMode.normal,
        suggestDeferMemorization: false,
        suggestResolveMissedWork: false,
        steps: const [
          'ابدأ بالتثبيت القريب إن وُجد.',
          'أكمل وردك المعتاد إن كان الوقت مناسبًا.',
        ],
      );
    } else if (missedDays == 2 || missedDays == 3) {
      final steps = <String>[];
      if (currentMode == TodayMode.lightRecovery) {
        steps.add('الخطة الخفيفة نشطة بالفعل اليوم.');
      } else {
        steps.add('فعّل الخطة الخفيفة اليوم.');
      }
      steps.add('قدّم التثبيت والمراجعة على الحفظ الجديد.');
      if (!isMemorizationDeferred) {
        steps.add('أجّل الحفظ الجديد إذا كان التراكم مرهقًا.');
      }

      return RecoveryRecommendation(
        severity: RecoverySeverity.moderate,
        title: 'خطة رجوع خفيفة',
        message: 'تراكمت بعض المهام. الأفضل اليوم التركيز على التثبيت والمراجعة قبل زيادة الحفظ.',
        recommendedMode: TodayMode.lightRecovery,
        suggestDeferMemorization: !isMemorizationDeferred,
        suggestResolveMissedWork: false,
        steps: steps,
      );
    } else {
      // missedDays >= 4
      final steps = <String>[];
      if (currentMode == TodayMode.lightRecovery) {
        steps.add('الخطة الخفيفة نشطة بالفعل اليوم.');
      }
      steps.add('ركّز اليوم على المراجعة والتثبيت.');
      if (!isMemorizationDeferred) {
        steps.add('أجّل الحفظ الجديد لهذا اليوم.');
      }
      steps.add('إذا كان التراكم غير مناسب، يمكنك تجاوز المهام الفائتة والبدء من جديد.');

      return RecoveryRecommendation(
        severity: RecoverySeverity.heavy,
        title: 'عودة هادئة للخطة',
        message: 'التراكم أصبح عاليًا. نقترح إيقاف الحفظ الجديد اليوم والتركيز على المراجعة، أو تجاوز المهام الفائتة إذا أردت بداية نظيفة.',
        recommendedMode: TodayMode.lightRecovery,
        suggestDeferMemorization: !isMemorizationDeferred,
        suggestResolveMissedWork: true,
        steps: steps,
      );
    }
  }
}

final recoveryRecommendationServiceProvider = Provider<RecoveryRecommendationService>((ref) {
  return const RecoveryRecommendationService();
});
