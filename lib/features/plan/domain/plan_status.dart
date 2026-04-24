/// Defines the operational status of a memorization plan.
enum PlanStatus {
  active,
  paused,
  archived;

  static PlanStatus fromString(String value) {
    return PlanStatus.values.firstWhere(
      (e) => e.name == value,
      orElse: () => PlanStatus.active,
    );
  }
}
