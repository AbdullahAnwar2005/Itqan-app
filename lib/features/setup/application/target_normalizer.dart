import '../domain/user_setup.dart';

/// Helper utility for normalizing different target units to a canonical base metric.
///
/// Converts domain quantities into 'page equivalents' for capacity planning
/// and uniform progress tracking across different selected units.
///
/// Note: Some conversions (e.g. hizb or juz to pages) are approximations
/// based on the standard 604-page Madinah mushaf, where 1 juz = 20 pages
/// and 1 hizb = 10 pages on average.
class TargetNormalizer {
  /// Returns the page-equivalent value for a given [target].
  static double toPageEquivalent(DailyTarget target) {
    switch (target.unit) {
      case ProgressUnit.ayah:
        // Approximation: ~15 ayahs per page on average.
        // This is highly variable, but serves as a rough baseline.
        return target.amount / 15.0;
      case ProgressUnit.page:
        return target.amount;
      case ProgressUnit.hizb:
        return target.amount * 10.0;
      case ProgressUnit.juz:
        return target.amount * 20.0;
    }
  }
}
