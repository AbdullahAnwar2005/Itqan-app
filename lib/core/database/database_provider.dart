import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app_database.dart';

/// Provides the singleton instance of [AppDatabase].
final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(() => db.close());
  return db;
});
