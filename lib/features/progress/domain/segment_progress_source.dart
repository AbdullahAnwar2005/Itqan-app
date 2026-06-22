enum SegmentProgressSource {
  appMemorization,
  previousMemorization;

  String get persistenceKey => name;

  static SegmentProgressSource fromKey(String key) {
    return SegmentProgressSource.values.firstWhere(
      (e) => e.name == key,
      orElse: () => SegmentProgressSource.appMemorization,
    );
  }
}
