import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:itqan/features/setup/application/setup_target_config.dart';
import '../../../../core/design/tokens/app_colors.dart';
import '../../../../core/design/tokens/app_spacing.dart';
import '../../../../core/design/tokens/app_typography.dart';

class SetupCustomAmountSelector extends StatefulWidget {
  const SetupCustomAmountSelector({
    super.key,
    required this.amount,
    required this.config,
    required this.onChanged,
  });

  final double amount;
  final UnitConfig config;
  final ValueChanged<double> onChanged;

  @override
  State<SetupCustomAmountSelector> createState() => _SetupCustomAmountSelectorState();
}

class _SetupCustomAmountSelectorState extends State<SetupCustomAmountSelector> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: widget.amount % 1 == 0 ? widget.amount.toInt().toString() : widget.amount.toString(),
    );
  }

  @override
  void didUpdateWidget(SetupCustomAmountSelector oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.amount != double.tryParse(_controller.text)) {
      _controller.text = widget.amount % 1 == 0 ? widget.amount.toInt().toString() : widget.amount.toString();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _increment() {
    if (widget.amount + widget.config.step <= widget.config.max) {
      widget.onChanged(widget.amount + widget.config.step);
    }
  }

  void _decrement() {
    if (widget.amount - widget.config.step >= widget.config.min) {
      widget.onChanged(widget.amount - widget.config.step);
    }
  }

  void _onFieldChanged(String val) {
    final parsed = double.tryParse(val);
    if (parsed != null) {
      // Allow the value for now, but clamp it on submit or if it's within bounds
      if (parsed >= widget.config.min && parsed <= widget.config.max) {
        widget.onChanged(parsed);
      }
    }
  }

  String _format(double val) {
    return val % 1 == 0 ? val.toInt().toString() : val.toString();
  }

  void _onFieldSubmitted(String val) {
    double parsed = double.tryParse(val) ?? widget.config.min;

    // Snapping logic: round to the nearest step
    final steps = (parsed / widget.config.step).round();
    parsed = steps * widget.config.step;

    if (parsed < widget.config.min) {
      widget.onChanged(widget.config.min);
    } else if (parsed > widget.config.max) {
      widget.onChanged(widget.config.max);
    } else {
      widget.onChanged(parsed);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surfacePrimary,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderSubtle),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _ActionButton(icon: Icons.remove, onPressed: _decrement),
              const SizedBox(width: AppSpacing.xl),
              SizedBox(
                width: 80,
                child: TextField(
                  controller: _controller,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  textAlign: TextAlign.center,
                  style: AppTypography.sectionTitle.copyWith(
                    color: AppColors.actionPrimary,
                    fontSize: 32,
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                  ],
                  onChanged: _onFieldChanged,
                  onSubmitted: _onFieldSubmitted,
                  onTapOutside: (_) => _onFieldSubmitted(_controller.text),
                ),
              ),
              const SizedBox(width: AppSpacing.xl),
              _ActionButton(icon: Icons.add, onPressed: _increment),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            widget.config.labelAr,
            style: AppTypography.caption.copyWith(color: AppColors.textSecondary),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'بين ${_format(widget.config.min)} و ${_format(widget.config.max)} ${widget.config.labelAr}',
            style: AppTypography.caption.copyWith(color: AppColors.textSecondary, fontSize: 10),
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({required this.icon, required this.onPressed});
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.sm),
        decoration: BoxDecoration(
          color: AppColors.actionSecondary,
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.actionPrimary.withAlpha(50)),
        ),
        child: Icon(icon, color: AppColors.actionPrimary, size: 24),
      ),
    );
  }
}
