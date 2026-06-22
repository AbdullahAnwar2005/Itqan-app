enum SegmentProgressStatus {
  learning,
  stabilizing,
  stable,
  weak,
  needsRetry;

  String get persistenceKey => name;

  static SegmentProgressStatus fromKey(String key) {
    return SegmentProgressStatus.values.firstWhere(
      (e) => e.name == key,
      orElse: () => SegmentProgressStatus.learning,
    );
  }
}
