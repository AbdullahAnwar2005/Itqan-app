import 'package:flutter/material.dart';

/// Itqan radius scale.
///
/// Values from `.agent/design/11_EXACT_DESIGN_SPEC.md` § 5.
/// Default card/button/input radius: [md] (12).
/// Pills and chips: [full].
abstract final class AppRadius {
  static const double none = 0;
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 20;
  static const double full = 9999;

  // Convenience BorderRadius shortcuts
  static const BorderRadius cardDefault =
      BorderRadius.all(Radius.circular(md));
  static const BorderRadius buttonDefault =
      BorderRadius.all(Radius.circular(md));
  static const BorderRadius inputDefault =
      BorderRadius.all(Radius.circular(md));
  static const BorderRadius pill =
      BorderRadius.all(Radius.circular(full));
}
