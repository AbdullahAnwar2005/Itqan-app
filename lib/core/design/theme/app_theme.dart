import 'package:flutter/material.dart';

import '../tokens/app_colors.dart';
import '../tokens/app_elevation.dart';
import '../tokens/app_radius.dart';
import '../tokens/app_spacing.dart';
import '../tokens/app_typography.dart';
import 'itqan_theme_extension.dart';

/// Itqan application theme.
///
/// V1 ships light mode only — see `.agent/context/decisions.md`.
/// Dark mode must not be added casually; a proper semantic dark token
/// system is required before implementing it.
abstract final class AppTheme {
  /// The single light-mode [ThemeData] for the app.
  static ThemeData get light {
    const colorScheme = ColorScheme.light(
      primary: AppColors.actionPrimary,
      onPrimary: AppColors.textInverse,
      primaryContainer: AppColors.actionSecondary,
      onPrimaryContainer: AppColors.actionPrimary,
      secondary: AppColors.actionSecondary,
      onSecondary: AppColors.actionPrimary,
      surface: AppColors.surfacePrimary,
      onSurface: AppColors.textPrimary,
      onSurfaceVariant: AppColors.textSecondary,
      outline: AppColors.borderSubtle,
      outlineVariant: AppColors.borderMedium,
      error: AppColors.error,
      onError: AppColors.textInverse,
      errorContainer: AppColors.errorSurface,
      onErrorContainer: AppColors.error,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.surfaceSecondary,
      fontFamily: 'IBMPlexSansArabic',

      // ── Typography ──────────────────────────────────────────────────────
      textTheme: TextTheme(
        displayLarge: AppTypography.display.copyWith(color: AppColors.textPrimary),
        titleLarge: AppTypography.pageTitle.copyWith(color: AppColors.textPrimary),
        titleMedium: AppTypography.sectionTitle.copyWith(color: AppColors.textPrimary),
        titleSmall: AppTypography.cardTitle.copyWith(color: AppColors.textPrimary),
        bodyLarge: AppTypography.bodyLarge.copyWith(color: AppColors.textPrimary),
        bodyMedium: AppTypography.body.copyWith(color: AppColors.textPrimary),
        bodySmall: AppTypography.bodySmall.copyWith(color: AppColors.textSecondary),
        labelLarge: AppTypography.label.copyWith(color: AppColors.textPrimary),
        labelSmall: AppTypography.caption.copyWith(color: AppColors.textSecondary),
      ),

      // ── AppBar ──────────────────────────────────────────────────────────
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.surfacePrimary,
        foregroundColor: AppColors.textPrimary,
        elevation: AppElevation.none,
        scrolledUnderElevation: AppElevation.xs,
        shadowColor: AppColors.borderSubtle,
        titleTextStyle:
            AppTypography.cardTitle.copyWith(color: AppColors.textPrimary),
        centerTitle: false,
        surfaceTintColor: Colors.transparent,
      ),

      // ── Card ────────────────────────────────────────────────────────────
      cardTheme: const CardThemeData(
        color: AppColors.surfaceElevated,
        elevation: AppElevation.xs,
        shadowColor: AppColors.borderSubtle,
        shape: RoundedRectangleBorder(
          borderRadius: AppRadius.cardDefault,
          side: BorderSide(color: AppColors.borderSubtle),
        ),
        margin: EdgeInsets.zero,
      ),

      // ── Elevated Button ─────────────────────────────────────────────────
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.actionPrimary,
          foregroundColor: AppColors.textInverse,
          disabledBackgroundColor: AppColors.textDisabled,
          disabledForegroundColor: AppColors.textInverse,
          elevation: AppElevation.none,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.sm,
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: AppRadius.buttonDefault,
          ),
          textStyle: AppTypography.label,
        ),
      ),

      // ── Text Button ─────────────────────────────────────────────────────
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.actionPrimary,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.xs,
          ),
          textStyle: AppTypography.label,
        ),
      ),

      // ── Input Decoration ────────────────────────────────────────────────
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surfaceTertiary,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        border: OutlineInputBorder(
          borderRadius: AppRadius.inputDefault,
          borderSide: const BorderSide(color: AppColors.borderSubtle),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppRadius.inputDefault,
          borderSide: const BorderSide(color: AppColors.borderSubtle),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppRadius.inputDefault,
          borderSide:
              const BorderSide(color: AppColors.focusRing, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: AppRadius.inputDefault,
          borderSide: const BorderSide(color: AppColors.error),
        ),
        hintStyle:
            AppTypography.body.copyWith(color: AppColors.textTertiary),
        labelStyle:
            AppTypography.label.copyWith(color: AppColors.textSecondary),
      ),

      // ── Bottom Navigation Bar ───────────────────────────────────────────
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.surfacePrimary,
        selectedItemColor: AppColors.actionPrimary,
        unselectedItemColor: AppColors.textTertiary,
        elevation: AppElevation.sm,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
      ),

      // ── Divider ─────────────────────────────────────────────────────────
      dividerTheme: const DividerThemeData(
        color: AppColors.divider,
        thickness: 1,
        space: 1,
      ),

      // ── Product extension ───────────────────────────────────────────────
      extensions: const [ItqanThemeExtension.light],
    );
  }
}
