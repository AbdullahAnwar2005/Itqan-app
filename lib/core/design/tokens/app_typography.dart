import 'package:flutter/material.dart';

/// Itqan typography system.
///
/// Named roles from `.agent/design/11_EXACT_DESIGN_SPEC.md` § 7–8.
/// Interface font: IBM Plex Sans Arabic (family key: 'IBMPlexSansArabic').
/// Quran font: Amiri Quran (family key: 'AmiriQuran').
///
/// Use these styles through [AppTypography] constants; never declare
/// ad-hoc font sizes or weights in product widgets.
abstract final class AppTypography {
  /// IBM Plex Sans Arabic, 48px, bold, lh 1.2
  static const TextStyle display = TextStyle(
    fontFamily: 'IBMPlexSansArabic',
    fontSize: 48,
    fontWeight: FontWeight.w700,
    height: 1.2,
  );

  /// IBM Plex Sans Arabic, 30px, semibold, lh 1.3
  static const TextStyle pageTitle = TextStyle(
    fontFamily: 'IBMPlexSansArabic',
    fontSize: 30,
    fontWeight: FontWeight.w600,
    height: 1.3,
  );

  /// IBM Plex Sans Arabic, 24px, semibold, lh 1.4
  static const TextStyle sectionTitle = TextStyle(
    fontFamily: 'IBMPlexSansArabic',
    fontSize: 24,
    fontWeight: FontWeight.w600,
    height: 1.4,
  );

  /// IBM Plex Sans Arabic, 20px, semibold, lh 1.4
  static const TextStyle cardTitle = TextStyle(
    fontFamily: 'IBMPlexSansArabic',
    fontSize: 20,
    fontWeight: FontWeight.w600,
    height: 1.4,
  );

  /// IBM Plex Sans Arabic, 18px, regular, lh 1.6
  static const TextStyle bodyLarge = TextStyle(
    fontFamily: 'IBMPlexSansArabic',
    fontSize: 18,
    fontWeight: FontWeight.w400,
    height: 1.6,
  );

  /// IBM Plex Sans Arabic, 16px, regular, lh 1.6
  static const TextStyle body = TextStyle(
    fontFamily: 'IBMPlexSansArabic',
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.6,
  );

  /// IBM Plex Sans Arabic, 14px, regular, lh 1.5
  static const TextStyle bodySmall = TextStyle(
    fontFamily: 'IBMPlexSansArabic',
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );

  /// IBM Plex Sans Arabic, 14px, medium, lh 1.4
  static const TextStyle label = TextStyle(
    fontFamily: 'IBMPlexSansArabic',
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.4,
  );

  /// IBM Plex Sans Arabic, 12px, regular, lh 1.5
  static const TextStyle caption = TextStyle(
    fontFamily: 'IBMPlexSansArabic',
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );

  /// Amiri Quran, 24px, regular, lh 2.0 — for verse display
  static const TextStyle quranLarge = TextStyle(
    fontFamily: 'AmiriQuran',
    fontSize: 24,
    fontWeight: FontWeight.w400,
    height: 2.0,
  );

  /// Amiri Quran, 18px, regular, lh 1.8 — for compact verse display
  static const TextStyle quranMedium = TextStyle(
    fontFamily: 'AmiriQuran',
    fontSize: 18,
    fontWeight: FontWeight.w400,
    height: 1.8,
  );
}
