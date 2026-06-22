/// Represents the temporary UI state for today's plan presentation.
enum TodayMode {
  normal,
  lightRecovery;

  String get labelAr {
    return switch (this) {
      TodayMode.normal => 'الخطة المعتادة',
      TodayMode.lightRecovery => 'خطة خفيفة اليوم',
    };
  }
}
