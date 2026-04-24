import '../domain/user_setup.dart';
import 'user_setup_local_source.dart';

/// Repository for user setup data.
///
/// This is the public contract used by the application layer and providers.
/// It hides the [UserSetupLocalSource] implementation detail.
///
/// Rule: only this class (or its providers) should be accessed from
/// application providers and use-case-equivalent logic.
/// UI must never call [UserSetupLocalSource] directly.
class UserSetupRepository {
  const UserSetupRepository(this._source);

  final UserSetupLocalSource _source;

  /// Whether setup has been completed by the user.
  bool get isSetupComplete => _source.hasSetup;

  /// Retrieves the stored setup, or null if the user has not completed setup.
  UserSetup? getSetup() => _source.read();

  /// Persists the completed [setup].
  Future<void> saveSetup(UserSetup setup) => _source.write(setup);

  /// Clears setup data (e.g. for debug reset or future account switching).
  Future<void> clearSetup() => _source.clear();
}
