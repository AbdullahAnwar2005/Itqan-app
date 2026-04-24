import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/user_setup_local_source.dart';
import '../data/user_setup_repository.dart';
import '../domain/user_setup.dart';

// ── Infrastructure providers ─────────────────────────────────────────────────

/// Provides the [SharedPreferences] instance.
///
/// Must be overridden in [ProviderScope] at app start after
/// [SharedPreferences.getInstance()] resolves.
///
/// Example in main():
/// ```dart
/// final prefs = await SharedPreferences.getInstance();
/// runApp(ProviderScope(
///   overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
///   child: const ItqanApp(),
/// ));
/// ```
final sharedPreferencesProvider = Provider<SharedPreferences>(
  (_) => throw UnimplementedError('SharedPreferences must be provided at root'),
  name: 'sharedPreferencesProvider',
);

/// Provides the [UserSetupLocalSource].
final userSetupLocalSourceProvider = Provider<UserSetupLocalSource>(
  (ref) => UserSetupLocalSource(ref.watch(sharedPreferencesProvider)),
  name: 'userSetupLocalSourceProvider',
);

/// Provides the [UserSetupRepository].
final userSetupRepositoryProvider = Provider<UserSetupRepository>(
  (ref) => UserSetupRepository(ref.watch(userSetupLocalSourceProvider)),
  name: 'userSetupRepositoryProvider',
);

// ── Setup state ──────────────────────────────────────────────────────────────

/// Whether the user has completed initial setup.
///
/// Synchronous read — SharedPreferences is already loaded at app start.
/// Used by the router redirect to decide the initial route.
final isSetupCompleteProvider = Provider<bool>(
  (ref) => ref.watch(userSetupRepositoryProvider).isSetupComplete,
  name: 'isSetupCompleteProvider',
);

// ── Setup controller ─────────────────────────────────────────────────────────

/// Manages the in-progress setup form state and persists the final result.
///
/// State is the draft [UserSetup] being built across setup steps.
/// Calling [save] writes the completed setup and invalidates [isSetupCompleteProvider].
class SetupController extends Notifier<UserSetup> {
  static const _defaultSetup = UserSetup(
    memorizationTarget: DailyTarget(amount: 5, unit: ProgressUnit.ayah),
    reviewTarget: DailyTarget(amount: 1, unit: ProgressUnit.juz),
    intensity: MemorizationIntensity.moderate,
  );

  @override
  UserSetup build() => _defaultSetup;

  void setMemorizationTarget(DailyTarget target) {
    state = state.copyWith(memorizationTarget: target);
  }

  void setReviewTarget(DailyTarget target) {
    state = state.copyWith(reviewTarget: target);
  }

  void setIntensity(MemorizationIntensity intensity) {
    state = state.copyWith(intensity: intensity);
  }

  /// Persists the current draft as the completed user setup.
  /// Invalidates [isSetupCompleteProvider] so the router re-evaluates.
  Future<void> save(WidgetRef ref) async {
    await ref.read(userSetupRepositoryProvider).saveSetup(state);
    ref.invalidate(isSetupCompleteProvider);
  }
}

final setupControllerProvider =
    NotifierProvider<SetupController, UserSetup>(SetupController.new);
