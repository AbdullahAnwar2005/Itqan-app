class RecoveryResolution {
  final String planId;
  final String resolvedBeforeDateKey;
  final DateTime resolvedAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  const RecoveryResolution({
    required this.planId,
    required this.resolvedBeforeDateKey,
    required this.resolvedAt,
    required this.createdAt,
    required this.updatedAt,
  });
}
