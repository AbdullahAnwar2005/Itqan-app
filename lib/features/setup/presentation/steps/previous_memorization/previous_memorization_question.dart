import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../application/setup_providers.dart';
import '../../widgets/setup_shared_widgets.dart';

class PreviousMemorizationQuestion extends ConsumerWidget {
  const PreviousMemorizationQuestion({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasPreviousMemorization =
        ref.watch(setupControllerProvider.select((s) => s.hasPreviousMemorization));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ChoiceCard(
          label: 'نعم، لدي حفظ سابق',
          selected: hasPreviousMemorization,
          onTap: () {
            ref.read(setupControllerProvider.notifier).setHasPreviousMemorization(true);
          },
        ),
        ChoiceCard(
          label: 'لا، سأبدأ من الصفر',
          selected: !hasPreviousMemorization,
          onTap: () {
            ref.read(setupControllerProvider.notifier).setHasPreviousMemorization(false);
          },
        ),
      ],
    );
  }
}
