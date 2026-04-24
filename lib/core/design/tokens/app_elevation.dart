/// Itqan elevation scale.
///
/// Values from `.agent/design/11_EXACT_DESIGN_SPEC.md` § 6.
/// Keep usage restrained — do not make the app feel floaty or noisy.
abstract final class AppElevation {
  static const double none = 0;
  static const double xs = 1;
  static const double sm = 2;
  static const double md = 4;
  static const double lg = 8;
  static const double xl = 16;
}
