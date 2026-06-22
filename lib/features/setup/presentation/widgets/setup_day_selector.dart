import 'package:flutter/material.dart';
import '../../../../core/design/tokens/app_colors.dart';
import '../../../../core/design/tokens/app_spacing.dart';
import '../../../../core/design/tokens/app_typography.dart';

class SetupDaySelector extends StatelessWidget {
  const SetupDaySelector({
    super.key,
    required this.selectedDays,
    required this.onChanged,
  });

  final Set<int> selectedDays;
  final ValueChanged<Set<int>> onChanged;

  static const List<Map<String, dynamic>> _days = [
    {'name': 'السبت', 'id': 6},
    {'name': 'الأحد', 'id': 7},
    {'name': 'الاثنين', 'id': 1},
    {'name': 'الثلاثاء', 'id': 2},
    {'name': 'الأربعاء', 'id': 3},
    {'name': 'الخميس', 'id': 4},
    {'name': 'الجمعة', 'id': 5},
  ];

  void _toggleDay(int dayId) {
    final newDays = Set<int>.from(selectedDays);
    if (newDays.contains(dayId)) {
      newDays.remove(dayId);
    } else {
      newDays.add(dayId);
    }
    onChanged(newDays);
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.sm,
      alignment: WrapAlignment.center,
      children: _days.map((day) {
        final isSelected = selectedDays.contains(day['id']);
        return GestureDetector(
          onTap: () => _toggleDay(day['id']),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.actionSecondary : AppColors.surfacePrimary,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected ? AppColors.actionPrimary : AppColors.borderSubtle,
                width: isSelected ? 2 : 1,
              ),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: AppColors.actionPrimary.withAlpha(20),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      )
                    ]
                  : null,
            ),
            child: Text(
              day['name'],
              style: AppTypography.label.copyWith(
                color: isSelected ? AppColors.actionPrimary : AppColors.textPrimary,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
