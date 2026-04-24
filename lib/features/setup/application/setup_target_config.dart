import '../domain/user_setup.dart';

/// Configuration for a specific progress unit in the UI.
class UnitConfig {
  const UnitConfig({
    required this.unit,
    required this.min,
    required this.max,
    required this.step,
    required this.labelAr,
  });

  final ProgressUnit unit;
  
  /// Minimum allowed target amount.
  final double min;
  
  /// Maximum allowed target amount.
  final double max;
  
  /// Step size for increments/decrements.
  final double step;
  
  /// Arabic display label for the unit (e.g. 'آية', 'صفحة').
  final String labelAr;
}

/// Allowed unit configurations for the memorization step during this phase.
const List<UnitConfig> allowedMemorizationUnits = [
  UnitConfig(
    unit: ProgressUnit.ayah,
    min: 1,
    max: 20,
    step: 1,
    labelAr: 'آية',
  ),
  UnitConfig(
    unit: ProgressUnit.page,
    min: 0.5,
    max: 5,
    step: 0.5,
    labelAr: 'صفحة',
  ),
];

/// Allowed unit configurations for the review step during this phase.
const List<UnitConfig> allowedReviewUnits = [
  UnitConfig(
    unit: ProgressUnit.page,
    min: 1,
    max: 20,
    step: 1,
    labelAr: 'صفحة',
  ),
  UnitConfig(
    unit: ProgressUnit.hizb,
    min: 0.5,
    max: 4,
    step: 0.5,
    labelAr: 'حزب',
  ),
  UnitConfig(
    unit: ProgressUnit.juz,
    min: 0.5,
    max: 3,
    step: 0.5,
    labelAr: 'جزء',
  ),
];
