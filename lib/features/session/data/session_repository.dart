import 'package:drift/drift.dart';
import '../../../core/database/app_database.dart';
import '../../plan/domain/quran_position.dart';
import '../domain/session.dart';
import '../domain/session_log.dart';
import '../domain/session_rating.dart';

class SessionRepository {
  SessionRepository(this._db);

  final AppDatabase _db;

  /// Saves a session log entry to the database.
  Future<void> saveSessionLog(SessionLogEntry entry) async {
    await _db.into(_db.sessionLogs).insert(
          SessionLogsCompanion.insert(
            id: entry.id,
            assignmentId: entry.assignmentId,
            planId: entry.planId,
            sessionType: entry.sessionType.name,
            startSurah: Value(entry.startPosition?.surahNumber),
            startAyah: Value(entry.startPosition?.ayahNumber),
            endSurah: Value(entry.endPosition?.surahNumber),
            endAyah: Value(entry.endPosition?.ayahNumber),
            rating: entry.rating.name,
            completedAt: entry.completedAt,
            createdAt: entry.createdAt,
          ),
        );
  }

  /// Retrieves all session logs for the given plan, ordered by completedAt descending.
  Future<List<SessionLogEntry>> getSessionLogsForPlan(String planId) async {
    final rows = await (_db.select(_db.sessionLogs)
          ..where((t) => t.planId.equals(planId))
          ..orderBy([(t) => OrderingTerm(expression: t.completedAt, mode: OrderingMode.desc)]))
        .get();

    return rows.map((row) {
      final startSurah = row.startSurah;
      final startAyah = row.startAyah;
      final endSurah = row.endSurah;
      final endAyah = row.endAyah;
      return SessionLogEntry(
        id: row.id,
        assignmentId: row.assignmentId,
        planId: row.planId,
        sessionType: SessionType.values.firstWhere(
          (e) => e.name == row.sessionType,
          orElse: () => SessionType.review,
        ),
        startPosition: startSurah != null && startAyah != null
            ? QuranPosition(surahNumber: startSurah, ayahNumber: startAyah)
            : null,
        endPosition: endSurah != null && endAyah != null
            ? QuranPosition(surahNumber: endSurah, ayahNumber: endAyah)
            : null,
        rating: SessionRating.fromKey(row.rating),
        completedAt: row.completedAt,
        createdAt: row.createdAt,
      );
    }).toList();
  }
}
