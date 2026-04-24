import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:itqan/features/session/presentation/session_screen.dart';
import 'package:itqan/features/progress/presentation/progress_screen.dart';
import 'package:itqan/features/library/presentation/library_screen.dart';
import 'package:itqan/features/settings/presentation/settings_screen.dart';

import '../../features/plan/presentation/plan_screen.dart';
import '../../features/setup/application/setup_providers.dart';
import '../../features/setup/presentation/setup_screen.dart';
import '../../features/today/presentation/today_screen.dart';
import '../design/components/itqan_bottom_nav.dart';

/// Route names — use these constants with [context.goNamed].
abstract final class AppRoutes {
  static const String setup = 'setup';
  static const String today = 'today';
  static const String plan = 'plan';
  static const String session = 'session';
  static const String progress = 'progress';
  static const String library = 'library';
  static const String settings = 'settings';
}

/// Route paths.
abstract final class AppPaths {
  static const String setup = '/setup';
  static const String today = '/';
  static const String plan = '/plan';
  static const String session = '/session';
  static const String progress = '/progress';
  static const String library = '/library';
  static const String settings = '/settings';
}

/// Application router provider.
///
/// We provide the router via Riverpod so it can natively read other
/// providers (like [isSetupCompleteProvider]) during its redirect phase.
final appRouterProvider = Provider<GoRouter>((ref) {
  final rootNavigatorKey = GlobalKey<NavigatorState>();

  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: AppPaths.today,
    debugLogDiagnostics: false,
    redirect: (context, state) {
      final setupComplete = ref.read(isSetupCompleteProvider);
      final onSetup = state.matchedLocation == AppPaths.setup;

      if (!setupComplete && !onSetup) return AppPaths.setup;
      if (setupComplete && onSetup) return AppPaths.today;
      return null;
    },
    routes: [
      GoRoute(
        path: AppPaths.setup,
        name: AppRoutes.setup,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const SetupScreen(),
      ),
      GoRoute(
        path: AppPaths.settings,
        name: AppRoutes.settings,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const SettingsScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return ScaffoldWithNavBar(navigationShell: navigationShell);
        },
        branches: [
          // Branch 0: Today
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppPaths.today,
                name: AppRoutes.today,
                builder: (context, state) => const TodayScreen(),
              ),
            ],
          ),
          // Branch 1: Plan
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppPaths.plan,
                name: AppRoutes.plan,
                builder: (context, state) => const PlanScreen(),
              ),
            ],
          ),
          // Branch 2: Session
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppPaths.session,
                name: AppRoutes.session,
                builder: (context, state) => const SessionScreen(),
              ),
            ],
          ),
          // Branch 3: Progress
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppPaths.progress,
                name: AppRoutes.progress,
                builder: (context, state) => const ProgressScreen(),
              ),
            ],
          ),
          // Branch 4: Library
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppPaths.library,
                name: AppRoutes.library,
                builder: (context, state) => const LibraryScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
});

/// Shell widget to host the bottom navigation bar across branches.
class ScaffoldWithNavBar extends StatelessWidget {
  const ScaffoldWithNavBar({
    required this.navigationShell,
    super.key,
  });

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: ItqanBottomNav(
        currentIndex: navigationShell.currentIndex,
        onTap: (index) {
          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          );
        },
      ),
    );
  }
}
