import 'package:flutter/material.dart';

import '../tokens/app_colors.dart';

/// Itqan product semantic color extension for [ThemeData].
///
/// Exposes memorization-domain status colors that are not part of Flutter's
/// standard [ColorScheme]. Access via:
/// ```dart
/// Theme.of(context).extension<ItqanThemeExtension>()!
/// ```
@immutable
class ItqanThemeExtension extends ThemeExtension<ItqanThemeExtension> {
  const ItqanThemeExtension({
    required this.memorizeActive,
    required this.memorizeSurface,
    required this.reviewDue,
    required this.reviewSurface,
    required this.selfTest,
    required this.selfTestSurface,
    required this.completed,
    required this.completedSurface,
    required this.overdue,
    required this.overdueSurface,
    required this.confidenceHigh,
    required this.confidenceMedium,
    required this.confidenceLow,
  });

  final Color memorizeActive;
  final Color memorizeSurface;
  final Color reviewDue;
  final Color reviewSurface;
  final Color selfTest;
  final Color selfTestSurface;
  final Color completed;
  final Color completedSurface;
  final Color overdue;
  final Color overdueSurface;
  final Color confidenceHigh;
  final Color confidenceMedium;
  final Color confidenceLow;

  /// The canonical light-mode product extension.
  static const ItqanThemeExtension light = ItqanThemeExtension(
    memorizeActive: AppColors.memorizeActive,
    memorizeSurface: AppColors.memorizeSurface,
    reviewDue: AppColors.reviewDue,
    reviewSurface: AppColors.reviewSurface,
    selfTest: AppColors.selfTest,
    selfTestSurface: AppColors.selfTestSurface,
    completed: AppColors.completed,
    completedSurface: AppColors.completedSurface,
    overdue: AppColors.overdue,
    overdueSurface: AppColors.overdueSurface,
    confidenceHigh: AppColors.confidenceHigh,
    confidenceMedium: AppColors.confidenceMedium,
    confidenceLow: AppColors.confidenceLow,
  );

  @override
  ItqanThemeExtension copyWith({
    Color? memorizeActive,
    Color? memorizeSurface,
    Color? reviewDue,
    Color? reviewSurface,
    Color? selfTest,
    Color? selfTestSurface,
    Color? completed,
    Color? completedSurface,
    Color? overdue,
    Color? overdueSurface,
    Color? confidenceHigh,
    Color? confidenceMedium,
    Color? confidenceLow,
  }) {
    return ItqanThemeExtension(
      memorizeActive: memorizeActive ?? this.memorizeActive,
      memorizeSurface: memorizeSurface ?? this.memorizeSurface,
      reviewDue: reviewDue ?? this.reviewDue,
      reviewSurface: reviewSurface ?? this.reviewSurface,
      selfTest: selfTest ?? this.selfTest,
      selfTestSurface: selfTestSurface ?? this.selfTestSurface,
      completed: completed ?? this.completed,
      completedSurface: completedSurface ?? this.completedSurface,
      overdue: overdue ?? this.overdue,
      overdueSurface: overdueSurface ?? this.overdueSurface,
      confidenceHigh: confidenceHigh ?? this.confidenceHigh,
      confidenceMedium: confidenceMedium ?? this.confidenceMedium,
      confidenceLow: confidenceLow ?? this.confidenceLow,
    );
  }

  @override
  ItqanThemeExtension lerp(ItqanThemeExtension? other, double t) {
    if (other == null) return this;
    return ItqanThemeExtension(
      memorizeActive: Color.lerp(memorizeActive, other.memorizeActive, t)!,
      memorizeSurface: Color.lerp(memorizeSurface, other.memorizeSurface, t)!,
      reviewDue: Color.lerp(reviewDue, other.reviewDue, t)!,
      reviewSurface: Color.lerp(reviewSurface, other.reviewSurface, t)!,
      selfTest: Color.lerp(selfTest, other.selfTest, t)!,
      selfTestSurface: Color.lerp(selfTestSurface, other.selfTestSurface, t)!,
      completed: Color.lerp(completed, other.completed, t)!,
      completedSurface:
          Color.lerp(completedSurface, other.completedSurface, t)!,
      overdue: Color.lerp(overdue, other.overdue, t)!,
      overdueSurface: Color.lerp(overdueSurface, other.overdueSurface, t)!,
      confidenceHigh: Color.lerp(confidenceHigh, other.confidenceHigh, t)!,
      confidenceMedium:
          Color.lerp(confidenceMedium, other.confidenceMedium, t)!,
      confidenceLow: Color.lerp(confidenceLow, other.confidenceLow, t)!,
    );
  }
}
