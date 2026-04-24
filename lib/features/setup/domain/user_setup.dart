import 'package:equatable/equatable.dart';

/// Supported units for progress and target tracking.
enum ProgressUnit {
  ayah,
  page,
  hizb,
  juz,
}

/// A daily target quantity combined with its unit of measurement.
class DailyTarget extends Equatable {
  const DailyTarget({
    required this.amount,
    required this.unit,
  });

  final double amount;
  final ProgressUnit unit;

  @override
  List<Object?> get props => [amount, unit];
}

/// Pace / intensity preference chosen during setup.
///
/// Drives daily capacity defaults and scheduling pace.
/// Kept as a simple enum — displayed in Arabic in the UI.
enum MemorizationIntensity {
  /// مريح — gentler daily targets, more review buffer
  relaxed,

  /// متوازن — balanced targets (default)
  moderate,

  /// مكثّف — higher daily targets, faster progression
  intensive;

  /// Arabic display label.
  String get label {
    return switch (this) {
      MemorizationIntensity.relaxed => 'مريح',
      MemorizationIntensity.moderate => 'متوازن',
      MemorizationIntensity.intensive => 'مكثّف',
    };
  }

  /// Arabic description shown during setup.
  String get description {
    return switch (this) {
      MemorizationIntensity.relaxed => 'تقدم هادئ مع مراجعة أكثر',
      MemorizationIntensity.moderate => 'إيقاع متوازن بين الحفظ والمراجعة',
      MemorizationIntensity.intensive => 'تقدم أسرع مع التزام أعلى',
    };
  }

  /// Key used for persistence.
  String get persistenceKey {
    return switch (this) {
      MemorizationIntensity.relaxed => 'relaxed',
      MemorizationIntensity.moderate => 'moderate',
      MemorizationIntensity.intensive => 'intensive',
    };
  }

  static MemorizationIntensity fromKey(String key) {
    return MemorizationIntensity.values.firstWhere(
      (e) => e.persistenceKey == key,
      orElse: () => MemorizationIntensity.moderate,
    );
  }
}

/// Minimum user setup data needed before any plan can be generated.
///
/// Fields:
/// - [memorizationTarget] — how much the user commits to memorize per day.
/// - [reviewTarget] — how much the user commits to review per day.
/// - [intensity] — overall pace preference. Affects scheduling buffer and targets.
///
/// This entity is immutable. Use [copyWith] to produce updated instances.
class UserSetup extends Equatable {
  const UserSetup({
    required this.memorizationTarget,
    required this.reviewTarget,
    required this.intensity,
  });

  final DailyTarget memorizationTarget;
  final DailyTarget reviewTarget;
  final MemorizationIntensity intensity;

  UserSetup copyWith({
    DailyTarget? memorizationTarget,
    DailyTarget? reviewTarget,
    MemorizationIntensity? intensity,
  }) {
    return UserSetup(
      memorizationTarget: memorizationTarget ?? this.memorizationTarget,
      reviewTarget: reviewTarget ?? this.reviewTarget,
      intensity: intensity ?? this.intensity,
    );
  }

  @override
  List<Object?> get props => [memorizationTarget, reviewTarget, intensity];
}
