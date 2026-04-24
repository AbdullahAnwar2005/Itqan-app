import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/design/theme/app_theme.dart';
import '../core/routing/app_router.dart';

/// Itqan root application widget.
///
/// [ProviderScope] lives in main.dart so SharedPreferences can be injected
/// before the app tree is built.
class ItqanApp extends ConsumerWidget {
  const ItqanApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: 'إتقان',
      routerConfig: router,
      theme: AppTheme.light,
      // Arabic locale → Flutter sets RTL direction automatically.
      locale: const Locale('ar'),
      supportedLocales: const [Locale('ar')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
    );
  }
}
