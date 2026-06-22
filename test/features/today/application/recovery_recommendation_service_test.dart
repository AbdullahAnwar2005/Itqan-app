import 'package:flutter_test/flutter_test.dart';
import 'package:itqan/features/today/application/recovery_recommendation_service.dart';
import 'package:itqan/features/today/domain/recovery_notice.dart';
import 'package:itqan/features/today/domain/recovery_recommendation.dart';
import 'package:itqan/features/today/domain/today_mode.dart';

void main() {
  late RecoveryRecommendationService service;

  setUp(() {
    service = const RecoveryRecommendationService();
  });

  group('RecoveryRecommendationService - buildRecommendation', () {
    test('null notice returns null', () {
      final recommendation = service.buildRecommendation(
        notice: null,
        hasNearReview: true,
        hasOldReview: true,
        isMemorizationDeferred: false,
        currentMode: TodayMode.normal,
      );
      expect(recommendation, isNull);
    });

    test('notice with hasMissedWork = false returns null', () {
      final recommendation = service.buildRecommendation(
        notice: const RecoveryNotice(
          hasMissedWork: false,
          missedDaysCount: 0,
          missedMemorizationCount: 0,
          missedReviewCount: 0,
        ),
        hasNearReview: true,
        hasOldReview: true,
        isMemorizationDeferred: false,
        currentMode: TodayMode.normal,
      );
      expect(recommendation, isNull);
    });

    test('missedDaysCount == 1 returns light severity and normal mode recommendation', () {
      final recommendation = service.buildRecommendation(
        notice: const RecoveryNotice(
          hasMissedWork: true,
          missedDaysCount: 1,
          missedMemorizationCount: 1,
          missedReviewCount: 1,
        ),
        hasNearReview: true,
        hasOldReview: true,
        isMemorizationDeferred: false,
        currentMode: TodayMode.normal,
      );

      expect(recommendation, isNotNull);
      expect(recommendation!.severity, equals(RecoverySeverity.light));
      expect(recommendation.recommendedMode, equals(TodayMode.normal));
      expect(recommendation.suggestDeferMemorization, isFalse);
      expect(recommendation.suggestResolveMissedWork, isFalse);
      expect(recommendation.title, equals('رجوع بسيط للخطة'));
      expect(recommendation.steps, contains('ابدأ بالتثبيت القريب إن وُجد.'));
      expect(recommendation.steps, contains('أكمل وردك المعتاد إن كان الوقت مناسبًا.'));
    });

    test('missedDaysCount == 2 returns moderate severity and lightRecovery mode', () {
      final recommendation = service.buildRecommendation(
        notice: const RecoveryNotice(
          hasMissedWork: true,
          missedDaysCount: 2,
          missedMemorizationCount: 2,
          missedReviewCount: 2,
        ),
        hasNearReview: true,
        hasOldReview: true,
        isMemorizationDeferred: false,
        currentMode: TodayMode.normal,
      );

      expect(recommendation, isNotNull);
      expect(recommendation!.severity, equals(RecoverySeverity.moderate));
      expect(recommendation.recommendedMode, equals(TodayMode.lightRecovery));
      expect(recommendation.suggestDeferMemorization, isTrue);
      expect(recommendation.suggestResolveMissedWork, isFalse);
      expect(recommendation.title, equals('خطة رجوع خفيفة'));
      expect(recommendation.steps, contains('فعّل الخطة الخفيفة اليوم.'));
    });

    test('missedDaysCount == 3 returns moderate severity', () {
      final recommendation = service.buildRecommendation(
        notice: const RecoveryNotice(
          hasMissedWork: true,
          missedDaysCount: 3,
          missedMemorizationCount: 3,
          missedReviewCount: 3,
        ),
        hasNearReview: true,
        hasOldReview: true,
        isMemorizationDeferred: false,
        currentMode: TodayMode.normal,
      );

      expect(recommendation, isNotNull);
      expect(recommendation!.severity, equals(RecoverySeverity.moderate));
    });

    test('missedDaysCount >= 4 returns heavy severity and suggestResolveMissedWork = true', () {
      final recommendation = service.buildRecommendation(
        notice: const RecoveryNotice(
          hasMissedWork: true,
          missedDaysCount: 4,
          missedMemorizationCount: 5,
          missedReviewCount: 5,
        ),
        hasNearReview: true,
        hasOldReview: true,
        isMemorizationDeferred: false,
        currentMode: TodayMode.normal,
      );

      expect(recommendation, isNotNull);
      expect(recommendation!.severity, equals(RecoverySeverity.heavy));
      expect(recommendation.recommendedMode, equals(TodayMode.lightRecovery));
      expect(recommendation.suggestDeferMemorization, isTrue);
      expect(recommendation.suggestResolveMissedWork, isTrue);
      expect(recommendation.title, equals('عودة هادئة للخطة'));
      expect(recommendation.steps, contains('ركّز اليوم على المراجعة والتثبيت.'));
    });

    test('currentMode = TodayMode.lightRecovery does not produce a "فعّل الخطة الخفيفة" step', () {
      final recommendation = service.buildRecommendation(
        notice: const RecoveryNotice(
          hasMissedWork: true,
          missedDaysCount: 2,
          missedMemorizationCount: 2,
          missedReviewCount: 2,
        ),
        hasNearReview: true,
        hasOldReview: true,
        isMemorizationDeferred: false,
        currentMode: TodayMode.lightRecovery,
      );

      expect(recommendation, isNotNull);
      expect(recommendation!.steps, isNot(contains('فعّل الخطة الخفيفة اليوم.')));
      expect(recommendation.steps, contains('الخطة الخفيفة نشطة بالفعل اليوم.'));
    });

    test('isMemorizationDeferred = true does not suggest deferring again', () {
      final recommendation = service.buildRecommendation(
        notice: const RecoveryNotice(
          hasMissedWork: true,
          missedDaysCount: 3,
          missedMemorizationCount: 3,
          missedReviewCount: 3,
        ),
        hasNearReview: true,
        hasOldReview: true,
        isMemorizationDeferred: true,
        currentMode: TodayMode.normal,
      );

      expect(recommendation, isNotNull);
      expect(recommendation!.suggestDeferMemorization, isFalse);
      expect(recommendation.steps, isNot(contains('أجّل الحفظ الجديد إذا كان التراكم مرهقًا.')));
    });
  });
}
