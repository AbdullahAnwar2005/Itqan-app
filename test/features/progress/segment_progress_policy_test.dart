import 'package:flutter_test/flutter_test.dart';
import 'package:itqan/features/progress/application/segment_progress_policy.dart';
import 'package:itqan/features/progress/domain/segment_progress_status.dart';
import 'package:itqan/features/session/domain/session_rating.dart';

void main() {
  group('SegmentProgressPolicy', () {
    late SegmentProgressPolicy policy;

    setUp(() {
      policy = const SegmentProgressPolicy();
    });

    test('easy returns stable/3/+3 days', () {
      final now = DateTime(2024, 1, 1, 12, 0, 0);
      final decision = policy.fromRating(SessionRating.easy, now);

      expect(decision.status, SegmentProgressStatus.stable);
      expect(decision.masteryScore, 3);
      expect(decision.nextReviewAt, now.add(const Duration(days: 3)));
    });

    test('good returns stabilizing/2/+1 day', () {
      final now = DateTime(2024, 1, 1, 12, 0, 0);
      final decision = policy.fromRating(SessionRating.good, now);

      expect(decision.status, SegmentProgressStatus.stabilizing);
      expect(decision.masteryScore, 2);
      expect(decision.nextReviewAt, now.add(const Duration(days: 1)));
    });

    test('hard returns weak/1/+1 day', () {
      final now = DateTime(2024, 1, 1, 12, 0, 0);
      final decision = policy.fromRating(SessionRating.hard, now);

      expect(decision.status, SegmentProgressStatus.weak);
      expect(decision.masteryScore, 1);
      expect(decision.nextReviewAt, now.add(const Duration(days: 1)));
    });

    test('again returns needsRetry/0/now', () {
      final now = DateTime(2024, 1, 1, 12, 0, 0);
      final decision = policy.fromRating(SessionRating.again, now);

      expect(decision.status, SegmentProgressStatus.needsRetry);
      expect(decision.masteryScore, 0);
      expect(decision.nextReviewAt, now);
    });
  });
}
