import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/user_setup_local_source.dart';
import '../data/user_setup_repository.dart';
export 'setup_controller.dart';
export 'setup_wizard_state.dart';

// ── Infrastructure providers ──────────────────────────────────────────────────

/// Provides the [SharedPreferences] instance.
///
/// Must be overridden in [ProviderScope] at app start after
/// [SharedPreferences.getInstance()] resolves.
final sharedPreferencesProvider = Provider<SharedPreferences>(
  (_) => throw UnimplementedError('SharedPreferences must be provided at root'),
  name: 'sharedPreferencesProvider',
);

final userSetupLocalSourceProvider = Provider<UserSetupLocalSource>(
  (ref) => UserSetupLocalSource(ref.watch(sharedPreferencesProvider)),
  name: 'userSetupLocalSourceProvider',
);

final userSetupRepositoryProvider = Provider<UserSetupRepository>(
  (ref) => UserSetupRepository(ref.watch(userSetupLocalSourceProvider)),
  name: 'userSetupRepositoryProvider',
);

// ── Setup state ───────────────────────────────────────────────────────────────

/// Whether the user has completed initial setup.
///
/// Synchronous — SharedPreferences is pre-loaded at app start.
/// Used by the router redirect to determine the initial route.
final isSetupCompleteProvider = Provider<bool>(
  (ref) => ref.watch(userSetupRepositoryProvider).isSetupComplete,
  name: 'isSetupCompleteProvider',
);

final memorizationCustomModeProvider = StateProvider<bool>((ref) => false);
final reviewCustomModeProvider = StateProvider<bool>((ref) => false);
