import 'package:flutter/material.dart';

/// Itqan color tokens.
///
/// All values are taken verbatim from `.agent/design/11_EXACT_DESIGN_SPEC.md` § 3.
/// Do not add ad-hoc colors here. Every new color must be justified and added
/// only if it belongs to the semantic token system.
abstract final class AppColors {
  // ── Surface ──────────────────────────────────────────────────────────────
  static const Color surfacePrimary = Color(0xFFFFFFFF);
  static const Color surfaceSecondary = Color(0xFFF8F9FA);
  static const Color surfaceTertiary = Color(0xFFF1F3F5);
  static const Color surfaceElevated = Color(0xFFFFFFFF);
  static const Color surfaceOverlay = Color(0x99000000); // rgba(0,0,0,0.6)

  // ── Text ─────────────────────────────────────────────────────────────────
  static const Color textPrimary = Color(0xFF1A1D1F);
  static const Color textSecondary = Color(0xFF6C727A);
  static const Color textTertiary = Color(0xFF9BA1A8);
  static const Color textDisabled = Color(0xFFC4C8CC);
  static const Color textInverse = Color(0xFFFFFFFF);

  // ── Action ───────────────────────────────────────────────────────────────
  static const Color actionPrimary = Color(0xFF2B5F44);
  static const Color actionPrimaryHover = Color(0xFF234A36);
  static const Color actionPrimaryPressed = Color(0xFF1A3628);
  static const Color actionSecondary = Color(0xFFE8F3ED);
  static const Color actionSecondaryHover = Color(0xFFD4E8DD);
  static const Color actionSecondaryPressed = Color(0xFFC0DDD0);

  // ── Semantic ─────────────────────────────────────────────────────────────
  static const Color success = Color(0xFF2B7A4B);
  static const Color successSurface = Color(0xFFE8F5EE);
  static const Color warning = Color(0xFFC77700);
  static const Color warningSurface = Color(0xFFFFF4E5);
  static const Color error = Color(0xFFC92A2A);
  static const Color errorSurface = Color(0xFFFFE8E8);

  // ── Product status ───────────────────────────────────────────────────────
  static const Color memorizeActive = Color(0xFF2B5F44);
  static const Color memorizeSurface = Color(0xFFE8F3ED);
  static const Color reviewDue = Color(0xFFC77700);
  static const Color reviewSurface = Color(0xFFFFF4E5);
  static const Color selfTest = Color(0xFF5F3DC4);
  static const Color selfTestSurface = Color(0xFFF3F0FF);
  static const Color completed = Color(0xFF2B7A4B);
  static const Color completedSurface = Color(0xFFE8F5EE);
  static const Color overdue = Color(0xFFC92A2A);
  static const Color overdueSurface = Color(0xFFFFE8E8);

  // ── Confidence ───────────────────────────────────────────────────────────
  static const Color confidenceHigh = Color(0xFF2B7A4B);
  static const Color confidenceMedium = Color(0xFFC77700);
  static const Color confidenceLow = Color(0xFFC92A2A);

  // ── Border / divider ─────────────────────────────────────────────────────
  static const Color borderSubtle = Color(0xFFE8EAED);
  static const Color borderMedium = Color(0xFFD0D5DD);
  static const Color borderStrong = Color(0xFFA0A7B0);
  static const Color divider = Color(0xFFE8EAED);

  // ── Focus / selection ────────────────────────────────────────────────────
  static const Color focusRing = Color(0xFF2B5F44);
  static const Color selectionBg = Color(0xFFE8F3ED);
}
