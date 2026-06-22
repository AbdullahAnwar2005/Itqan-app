class TodayAdjustment {
  final String planId;
  final String dateKey;
  final bool deferMemorization;
  final DateTime createdAt;
  final DateTime updatedAt;

  const TodayAdjustment({
    required this.planId,
    required this.dateKey,
    required this.deferMemorization,
    required this.createdAt,
    required this.updatedAt,
  });
}
