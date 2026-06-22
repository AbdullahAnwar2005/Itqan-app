import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/today_mode.dart';

/// Provides the current active today mode (normal or light recovery).
/// This state is temporary and resets to normal when the app restarts.
final todayModeProvider = StateProvider<TodayMode>((ref) {
  return TodayMode.normal;
});
