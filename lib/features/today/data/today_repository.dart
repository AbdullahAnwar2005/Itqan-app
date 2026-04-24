import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

/// Manages persistence for today's task completion state.
///
/// Currently uses [SharedPreferences] for simple daily state.
class TodayRepository {
  TodayRepository(this._prefs);

  final SharedPreferences _prefs;

  static const _prefix = 'today_completed_tasks_';

  String _getDateKey() {
    final now = DateTime.now();
    return '$_prefix${DateFormat('yyyy-MM-dd').format(now)}';
  }

  /// Returns a set of completed task IDs for the current day.
  Set<String> getCompletedTaskIds() {
    final key = _getDateKey();
    final list = _prefs.getStringList(key) ?? [];
    return list.toSet();
  }

  /// Marks a task as completed or incomplete for the current day.
  Future<void> setTaskCompletion(String taskId, bool isCompleted) async {
    final key = _getDateKey();
    final current = getCompletedTaskIds();
    
    if (isCompleted) {
      current.add(taskId);
    } else {
      current.remove(taskId);
    }
    
    await _prefs.setStringList(key, current.toList());
  }
}
