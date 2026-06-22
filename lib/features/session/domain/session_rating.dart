import 'package:equatable/equatable.dart';

/// Represents the user's self-rating of difficulty after a session.
enum SessionRating {
  unrated,
  easy,
  good,
  hard,
  again;

  String get labelAr {
    return switch (this) {
      SessionRating.unrated => 'غير مقيم',
      SessionRating.easy => 'سهل',
      SessionRating.good => 'جيد',
      SessionRating.hard => 'صعب',
      SessionRating.again => 'لم أتمكن',
    };
  }

  String get persistenceKey => name;

  static SessionRating fromKey(String key) {
    return SessionRating.values.firstWhere(
      (e) => e.name == key,
      orElse: () => SessionRating.unrated,
    );
  }
}
