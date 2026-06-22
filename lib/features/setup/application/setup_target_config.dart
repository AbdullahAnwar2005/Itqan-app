import '../domain/user_setup.dart';

/// Configuration for a specific progress unit in the custom sub-picker.
class UnitConfig {
  const UnitConfig({
    required this.unit,
    required this.min,
    required this.max,
    required this.step,
    required this.labelAr,
  });

  final ProgressUnit unit;
  final double min;
  final double max;
  final double step;
  final String labelAr;
}

/// A pre-defined target option shown as a tap-to-select card.
class TargetPreset {
  const TargetPreset({
    required this.labelAr,
    required this.descriptionAr,
    required this.target,
    this.isCustom = false,
  });

  final String labelAr;
  final String descriptionAr;
  final DailyTarget target;

  /// If true, tapping this preset reveals the custom sub-picker.
  final bool isCustom;
}

// ── Memorization presets ───────────────────────────────────────────────────────

const List<TargetPreset> memorizationPresets = [
  TargetPreset(
    labelAr: 'خفيف',
    descriptionAr: 'نصف صفحة في يوم الحفظ',
    target: DailyTarget(amount: 0.5, unit: ProgressUnit.page),
  ),
  TargetPreset(
    labelAr: 'مناسب',
    descriptionAr: 'صفحة كاملة في يوم الحفظ',
    target: DailyTarget(amount: 1, unit: ProgressUnit.page),
  ),
  TargetPreset(
    labelAr: 'متقدم',
    descriptionAr: 'صفحتان في يوم الحفظ',
    target: DailyTarget(amount: 2, unit: ProgressUnit.page),
  ),
  TargetPreset(
    labelAr: 'مخصص',
    descriptionAr: 'أدخل مقدارك بنفسك',
    target: DailyTarget(amount: 1, unit: ProgressUnit.page),
    isCustom: true,
  ),
];

// ── Review presets ─────────────────────────────────────────────────────────────

const List<TargetPreset> reviewPresets = [
  TargetPreset(
    labelAr: 'خفيف',
    descriptionAr: 'صفحة واحدة في يوم المراجعة',
    target: DailyTarget(amount: 1, unit: ProgressUnit.page),
  ),
  TargetPreset(
    labelAr: 'مناسب',
    descriptionAr: 'صفحتان في يوم المراجعة',
    target: DailyTarget(amount: 2, unit: ProgressUnit.page),
  ),
  TargetPreset(
    labelAr: 'متقدم',
    descriptionAr: 'ثلاث صفحات في يوم المراجعة',
    target: DailyTarget(amount: 3, unit: ProgressUnit.page),
  ),
  TargetPreset(
    labelAr: 'مخصص',
    descriptionAr: 'اختر عدد الصفحات',
    target: DailyTarget(amount: 1, unit: ProgressUnit.page),
    isCustom: true,
  ),
];

// ── Custom sub-picker configs ──────────────────────────────────────────────────

/// Units available in the custom memorization sub-picker.
const List<UnitConfig> customMemorizationUnits = [
  UnitConfig(
    unit: ProgressUnit.page,
    min: 0.5,
    max: 5,
    step: 0.5,
    labelAr: 'صفحة',
  ),
  UnitConfig(
    unit: ProgressUnit.ayah,
    min: 1,
    max: 20,
    step: 1,
    labelAr: 'آية',
  ),
];

/// Units available in the custom review sub-picker.
const List<UnitConfig> customReviewUnits = [
  UnitConfig(
    unit: ProgressUnit.page,
    min: 1,
    max: 20,
    step: 1,
    labelAr: 'صفحة',
  ),
  UnitConfig(
    unit: ProgressUnit.hizb,
    min: 0.25,
    max: 4,
    step: 0.25,
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

// ── Legacy aliases (kept for source compatibility) ────────────────────────────

/// @deprecated Use [customMemorizationUnits].
const List<UnitConfig> allowedMemorizationUnits = customMemorizationUnits;

/// @deprecated Use [customReviewUnits].
const List<UnitConfig> allowedReviewUnits = customReviewUnits;
