import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/design/tokens/app_colors.dart';
import '../../../core/routing/app_router.dart';
import '../application/setup_providers.dart';
import 'steps/memorization_amount_step.dart';
import 'steps/memorization_days_step.dart';
import 'steps/previous_memorization_screen.dart';
import 'steps/review_amount_step.dart';
import 'steps/review_schedule_step.dart';
import 'steps/start_position_step.dart';
import 'widgets/setup_shared_widgets.dart';

class SetupScreen extends ConsumerStatefulWidget {
  const SetupScreen({super.key});

  @override
  ConsumerState<SetupScreen> createState() => _SetupScreenState();
}

class _SetupScreenState extends ConsumerState<SetupScreen> {
  final PageController _pageController = PageController();
  int _currentStep = 0;
  static const int _totalSteps = 6;

  void _nextStep() {
    if (_currentStep < _totalSteps - 1) {
      setState(() => _currentStep++);
      _pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  void _prevStep() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
      _pageController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  Future<void> _finish() async {
    try {
      await ref.read(setupControllerProvider.notifier).save(ref);
      if (mounted) context.goNamed(AppRoutes.today);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('عذراً، حدث خطأ أثناء حفظ الخطة. يرجى المحاولة مرة أخرى.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfacePrimary,
      body: SafeArea(
        child: Column(
          children: [
            SetupProgressBar(current: _currentStep, total: _totalSteps),
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  MemorizeAmountStep(onNext: _nextStep),
                  MemorizationDaysStep(onBack: _prevStep, onNext: _nextStep),
                  ReviewAmountStep(onBack: _prevStep, onNext: _nextStep),
                  ReviewScheduleStep(onBack: _prevStep, onNext: _nextStep),
                  PreviousMemorizationScreen(onBack: _prevStep, onNext: _nextStep),
                  StartPositionStep(onBack: _prevStep, onFinish: _finish),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
