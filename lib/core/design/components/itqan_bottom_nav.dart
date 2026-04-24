import 'package:flutter/material.dart';

import '../tokens/app_colors.dart';
import '../tokens/app_typography.dart';

/// Itqan primary bottom navigation bar.
///
/// 5-item navigation reflecting the product IA:
/// اليوم (Today) · الخطة (Plan) · الجلسة (Session) · التقدم (Progress) · المكتبة (Library)
///
/// RTL-native: BottomNavigationBar order is RTL-aware by Flutter's
/// directionality system — no manual mirroring needed.
///
/// [currentIndex] is the 0-based selected tab index.
/// [onTap] handles tab selection.
class ItqanBottomNav extends StatelessWidget {
  const ItqanBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      backgroundColor: AppColors.surfacePrimary,
      selectedItemColor: AppColors.actionPrimary,
      unselectedItemColor: AppColors.textTertiary,
      selectedLabelStyle: AppTypography.caption.copyWith(
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelStyle: AppTypography.caption,
      type: BottomNavigationBarType.fixed,
      elevation: 2,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.today_outlined),
          activeIcon: Icon(Icons.today),
          label: 'اليوم',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_month_outlined),
          activeIcon: Icon(Icons.calendar_month),
          label: 'الخطة',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.menu_book_outlined),
          activeIcon: Icon(Icons.menu_book),
          label: 'الجلسة',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bar_chart_outlined),
          activeIcon: Icon(Icons.bar_chart),
          label: 'التقدم',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.library_books_outlined),
          activeIcon: Icon(Icons.library_books),
          label: 'المكتبة',
        ),
      ],
    );
  }
}
