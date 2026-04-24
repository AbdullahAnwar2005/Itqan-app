import 'package:flutter/material.dart';

import '../tokens/app_colors.dart';
import '../tokens/app_elevation.dart';
import '../tokens/app_typography.dart';

/// Itqan standard top app bar.
///
/// RTL-aware and token-driven.
/// [title] is a String (Arabic text expected).
/// [actions] are placed according to directionality — do not assume LTR.
///
/// Usage:
/// ```dart
/// ItqanTopAppBar(title: 'اليوم')
/// ```
class ItqanTopAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ItqanTopAppBar({
    super.key,
    required this.title,
    this.actions,
    this.leading,
    this.bottom,
  });

  final String title;
  final List<Widget>? actions;
  final Widget? leading;
  final PreferredSizeWidget? bottom;

  @override
  Size get preferredSize => Size.fromHeight(
        kToolbarHeight + (bottom?.preferredSize.height ?? 0),
      );

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: AppTypography.cardTitle.copyWith(color: AppColors.textPrimary),
      ),
      actions: actions,
      leading: leading,
      bottom: bottom,
      backgroundColor: AppColors.surfacePrimary,
      foregroundColor: AppColors.textPrimary,
      elevation: AppElevation.none,
      scrolledUnderElevation: AppElevation.xs,
      shadowColor: AppColors.borderSubtle,
      surfaceTintColor: Colors.transparent,
      // centerTitle: false — start-aligned is RTL-correct for Arabic
      centerTitle: false,
    );
  }
}
