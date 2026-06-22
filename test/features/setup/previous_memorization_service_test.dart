import 'package:flutter_test/flutter_test.dart';
import 'package:itqan/features/setup/application/previous_memorization_draft_entry.dart';
import 'package:itqan/features/setup/application/previous_memorization_service.dart';
import 'package:itqan/features/plan/domain/quran_position.dart';

void main() {
  late PreviousMemorizationService service;

  setUp(() {
    service = PreviousMemorizationService();
  });

  // ── Full Juz ──────────────────────────────────────────────────────────────

  group('rangesFromEntry – PreviousJuzEntry (full)', () {
    test('Juz 1 produces ranges for Al-Fatiha and Al-Baqarah 1–141', () {
      const entry = PreviousJuzEntry(id: 'j1', juzNumber: 1);
      final ranges = service.rangesFromEntry(entry);

      expect(ranges.length, 2);
      expect(ranges[0].from, const QuranPosition(surahNumber: 1, ayahNumber: 1));
      expect(ranges[0].to, const QuranPosition(surahNumber: 1, ayahNumber: 7));
      expect(ranges[1].from, const QuranPosition(surahNumber: 2, ayahNumber: 1));
      expect(ranges[1].to, const QuranPosition(surahNumber: 2, ayahNumber: 141));
    });

    test('Juz 2 produces a single range (all within Al-Baqarah)', () {
      const entry = PreviousJuzEntry(id: 'j2', juzNumber: 2);
      final ranges = service.rangesFromEntry(entry);

      expect(ranges.length, 1);
      expect(ranges[0].from, const QuranPosition(surahNumber: 2, ayahNumber: 142));
      expect(ranges[0].to, const QuranPosition(surahNumber: 2, ayahNumber: 252));
    });

    test('Juz 30 produces multiple ranges across short surahs', () {
      const entry = PreviousJuzEntry(id: 'j30', juzNumber: 30);
      final ranges = service.rangesFromEntry(entry);

      expect(ranges.isNotEmpty, true);
      expect(ranges.first.from, const QuranPosition(surahNumber: 78, ayahNumber: 1));
      expect(ranges.last.to, const QuranPosition(surahNumber: 114, ayahNumber: 6));
    });

    test('Full Juz (customizedCoverage == null) derives full ranges', () {
      const entry = PreviousJuzEntry(id: 'j1', juzNumber: 1);
      expect(entry.isCustomized, false);

      final ranges = service.rangesFromEntry(entry);
      expect(ranges.length, 2);
    });
  });

  // ── Customized Juz ────────────────────────────────────────────────────────

  group('rangesFromEntry – PreviousJuzEntry (customized)', () {
    test('Customized Juz with all full produces same ranges as full Juz', () {
      final defaultCoverage = service.buildDefaultCoverage(1);
      final entry = PreviousJuzEntry(
        id: 'j1',
        juzNumber: 1,
        customizedCoverage: defaultCoverage,
      );

      final fullRanges = service.rangesFromEntry(
        const PreviousJuzEntry(id: 'j1_full', juzNumber: 1),
      );
      final customRanges = service.rangesFromEntry(entry);

      expect(customRanges.length, fullRanges.length);
      for (int i = 0; i < customRanges.length; i++) {
        expect(customRanges[i].from, fullRanges[i].from);
        expect(customRanges[i].to, fullRanges[i].to);
      }
    });

    test('Customized Juz with partial and none derives correct ranges', () {
      // Juz 1: Al-Fatiha (1:1–7), Al-Baqarah (2:1–141)
      final entry = PreviousJuzEntry(
        id: 'j1',
        juzNumber: 1,
        customizedCoverage: [
          // Al-Fatiha: none (not memorized)
          const JuzSurahCoverage(
            surahNumber: 1,
            segmentStart: QuranPosition(surahNumber: 1, ayahNumber: 1),
            segmentEnd: QuranPosition(surahNumber: 1, ayahNumber: 7),
            type: MemorizationCoverageType.none,
          ),
          // Al-Baqarah: partial (only ayahs 50–100)
          const JuzSurahCoverage(
            surahNumber: 2,
            segmentStart: QuranPosition(surahNumber: 2, ayahNumber: 1),
            segmentEnd: QuranPosition(surahNumber: 2, ayahNumber: 141),
            type: MemorizationCoverageType.partial,
            fromAyah: 50,
            toAyah: 100,
          ),
        ],
      );

      final ranges = service.rangesFromEntry(entry);

      expect(ranges.length, 1); // Only Al-Baqarah partial
      expect(ranges[0].from, const QuranPosition(surahNumber: 2, ayahNumber: 50));
      expect(ranges[0].to, const QuranPosition(surahNumber: 2, ayahNumber: 100));
    });

    test('Customized Juz with all none produces no ranges', () {
      final entry = PreviousJuzEntry(
        id: 'j1',
        juzNumber: 2,
        customizedCoverage: [
          const JuzSurahCoverage(
            surahNumber: 2,
            segmentStart: QuranPosition(surahNumber: 2, ayahNumber: 142),
            segmentEnd: QuranPosition(surahNumber: 2, ayahNumber: 252),
            type: MemorizationCoverageType.none,
          ),
        ],
      );

      final ranges = service.rangesFromEntry(entry);
      expect(ranges, isEmpty);
    });

    test('Deleting a customized Juz removes all derived ranges', () {
      final entry = PreviousJuzEntry(
        id: 'j1',
        juzNumber: 1,
        customizedCoverage: [
          const JuzSurahCoverage(
            surahNumber: 1,
            segmentStart: QuranPosition(surahNumber: 1, ayahNumber: 1),
            segmentEnd: QuranPosition(surahNumber: 1, ayahNumber: 7),
            type: MemorizationCoverageType.full,
          ),
          const JuzSurahCoverage(
            surahNumber: 2,
            segmentStart: QuranPosition(surahNumber: 2, ayahNumber: 1),
            segmentEnd: QuranPosition(surahNumber: 2, ayahNumber: 141),
            type: MemorizationCoverageType.partial,
            fromAyah: 1,
            toAyah: 50,
          ),
        ],
      );

      final rangesBefore = service.rangesFromEntry(entry);
      expect(rangesBefore.length, 2);

      // Simulate deletion: derive from empty list
      final rangesAfter = service.rangesFromEntries([]);
      expect(rangesAfter, isEmpty);
    });
  });

  // ── Surah entries ─────────────────────────────────────────────────────────

  group('rangesFromEntry – PreviousSurahEntry', () {
    test('Whole surah produces one range covering all ayahs', () {
      const entry = PreviousSurahEntry(
        id: 's1',
        surahNumber: 1,
        isWholeSurah: true,
      );
      final ranges = service.rangesFromEntry(entry);

      expect(ranges.length, 1);
      expect(ranges[0].from, const QuranPosition(surahNumber: 1, ayahNumber: 1));
      expect(ranges[0].to, const QuranPosition(surahNumber: 1, ayahNumber: 7));
    });

    test('Partial surah produces one range with specified ayahs', () {
      const entry = PreviousSurahEntry(
        id: 's2',
        surahNumber: 12,
        isWholeSurah: false,
        fromAyah: 53,
        toAyah: 111,
      );
      final ranges = service.rangesFromEntry(entry);

      expect(ranges.length, 1);
      expect(ranges[0].from, const QuranPosition(surahNumber: 12, ayahNumber: 53));
      expect(ranges[0].to, const QuranPosition(surahNumber: 12, ayahNumber: 111));
    });

    test('Whole surah ignores fromAyah/toAyah even if provided', () {
      const entry = PreviousSurahEntry(
        id: 's3',
        surahNumber: 1,
        isWholeSurah: true,
        fromAyah: 3,
        toAyah: 5,
      );
      final ranges = service.rangesFromEntry(entry);

      expect(ranges.length, 1);
      expect(ranges[0].from.ayahNumber, 1);
      expect(ranges[0].to.ayahNumber, 7);
    });
  });

  // ── Bulk surah entries ──────────────────────────────────────────────────

  group('rangesFromEntry – PreviousBulkSurahEntry', () {
    test('Derives multiple whole surah ranges', () {
      const entry = PreviousBulkSurahEntry(id: 'b1', surahCoverages: [
        SurahCoverage(surahNumber: 1, type: MemorizationCoverageType.full),
        SurahCoverage(surahNumber: 112, type: MemorizationCoverageType.full),
        SurahCoverage(surahNumber: 114, type: MemorizationCoverageType.full),
      ]);
      final ranges = service.rangesFromEntry(entry);

      expect(ranges, hasLength(3));
      expect(ranges[0].from.surahNumber, 1);
      expect(ranges[0].isFullSurah, isTrue);
      expect(ranges[1].from.surahNumber, 112);
      expect(ranges[1].isFullSurah, isTrue);
      expect(ranges[2].from.surahNumber, 114);
      expect(ranges[2].isFullSurah, isTrue);
    });

    test('Derives partial ranges and ignores none coverage', () {
      const entry = PreviousBulkSurahEntry(id: 'b1', surahCoverages: [
        SurahCoverage(surahNumber: 1, type: MemorizationCoverageType.partial, fromAyah: 1, toAyah: 3),
        SurahCoverage(surahNumber: 112, type: MemorizationCoverageType.none),
      ]);
      final ranges = service.rangesFromEntry(entry);

      expect(ranges, hasLength(1));
      expect(ranges[0].from.surahNumber, 1);
      expect(ranges[0].from.ayahNumber, 1);
      expect(ranges[0].to.ayahNumber, 3);
    });

    test('Bulk selection rejects overlapping surahs', () {
      const existing = [PreviousSurahEntry(id: 's1', surahNumber: 1, isWholeSurah: true)];
      const newEntry = PreviousBulkSurahEntry(id: 'b1', surahCoverages: [
        SurahCoverage(surahNumber: 1, type: MemorizationCoverageType.full),
        SurahCoverage(surahNumber: 2, type: MemorizationCoverageType.full),
      ]);

      expect(
        () => service.validateEntryNoOverlap(existing, newEntry),
        throwsA(isA<RangeOverlapException>()),
      );
    });
  });

  // ── rangesFromEntries ─────────────────────────────────────────────────────

  group('rangesFromEntries', () {
    test('Multiple entries produce sorted, combined ranges', () {
      const entries = [
        PreviousJuzEntry(id: 'j2', juzNumber: 2),
        PreviousSurahEntry(id: 's1', surahNumber: 1, isWholeSurah: true),
      ];
      final ranges = service.rangesFromEntries(entries);

      expect(ranges.first.from.surahNumber, 1);
      expect(ranges.last.from, const QuranPosition(surahNumber: 2, ayahNumber: 142));
    });

    test('Empty entries produces empty ranges', () {
      final ranges = service.rangesFromEntries([]);
      expect(ranges, isEmpty);
    });
  });

  // ── validateRange ─────────────────────────────────────────────────────────

  group('validateRange', () {
    test('Valid range does not throw', () {
      expect(() => service.validateRange(1, 10), returnsNormally);
    });

    test('Equal from and to does not throw', () {
      expect(() => service.validateRange(5, 5), returnsNormally);
    });

    test('Invalid range (from > to) throws InvalidRangeException', () {
      expect(
        () => service.validateRange(10, 5),
        throwsA(isA<InvalidRangeException>()),
      );
    });
  });

  // ── validateCoverage ──────────────────────────────────────────────────────

  group('validateCoverage', () {
    test('Full and none coverage passes validation', () {
      final coverage = [
        const JuzSurahCoverage(
          surahNumber: 1,
          segmentStart: QuranPosition(surahNumber: 1, ayahNumber: 1),
          segmentEnd: QuranPosition(surahNumber: 1, ayahNumber: 7),
          type: MemorizationCoverageType.full,
        ),
        const JuzSurahCoverage(
          surahNumber: 2,
          segmentStart: QuranPosition(surahNumber: 2, ayahNumber: 1),
          segmentEnd: QuranPosition(surahNumber: 2, ayahNumber: 141),
          type: MemorizationCoverageType.none,
        ),
      ];

      expect(() => service.validateCoverage(coverage), returnsNormally);
    });

    test('Valid partial coverage passes validation', () {
      final coverage = [
        const JuzSurahCoverage(
          surahNumber: 2,
          segmentStart: QuranPosition(surahNumber: 2, ayahNumber: 1),
          segmentEnd: QuranPosition(surahNumber: 2, ayahNumber: 141),
          type: MemorizationCoverageType.partial,
          fromAyah: 50,
          toAyah: 100,
        ),
      ];

      expect(() => service.validateCoverage(coverage), returnsNormally);
    });

    test('Partial coverage with from > to throws InvalidRangeException', () {
      final coverage = [
        const JuzSurahCoverage(
          surahNumber: 2,
          segmentStart: QuranPosition(surahNumber: 2, ayahNumber: 1),
          segmentEnd: QuranPosition(surahNumber: 2, ayahNumber: 141),
          type: MemorizationCoverageType.partial,
          fromAyah: 100,
          toAyah: 50,
        ),
      ];

      expect(
        () => service.validateCoverage(coverage),
        throwsA(isA<InvalidRangeException>()),
      );
    });

    test('Partial coverage outside segment bounds throws OutOfBoundsException', () {
      final coverage = [
        const JuzSurahCoverage(
          surahNumber: 2,
          segmentStart: QuranPosition(surahNumber: 2, ayahNumber: 1),
          segmentEnd: QuranPosition(surahNumber: 2, ayahNumber: 141),
          type: MemorizationCoverageType.partial,
          fromAyah: 50,
          toAyah: 200, // exceeds segment end (141)
        ),
      ];

      expect(
        () => service.validateCoverage(coverage),
        throwsA(isA<OutOfBoundsException>()),
      );
    });

    test('Partial coverage with null ayahs throws InvalidRangeException', () {
      final coverage = [
        const JuzSurahCoverage(
          surahNumber: 2,
          segmentStart: QuranPosition(surahNumber: 2, ayahNumber: 1),
          segmentEnd: QuranPosition(surahNumber: 2, ayahNumber: 141),
          type: MemorizationCoverageType.partial,
          // fromAyah and toAyah are null
        ),
      ];

      expect(
        () => service.validateCoverage(coverage),
        throwsA(isA<InvalidRangeException>()),
      );
    });
  });

  // ── validateEntryNoOverlap ────────────────────────────────────────────────

  group('validateEntryNoOverlap', () {
    test('Non-overlapping entries pass validation', () {
      const existing = [
        PreviousSurahEntry(id: 's1', surahNumber: 1, isWholeSurah: true),
      ];
      const newEntry = PreviousSurahEntry(
        id: 's2',
        surahNumber: 12,
        isWholeSurah: false,
        fromAyah: 1,
        toAyah: 52,
      );

      expect(
        () => service.validateEntryNoOverlap(existing, newEntry),
        returnsNormally,
      );
    });

    test('Overlapping surah entries throw RangeOverlapException', () {
      const existing = [
        PreviousSurahEntry(id: 's1', surahNumber: 1, isWholeSurah: true),
      ];
      const newEntry = PreviousSurahEntry(
        id: 's2',
        surahNumber: 1,
        isWholeSurah: false,
        fromAyah: 3,
        toAyah: 5,
      );

      expect(
        () => service.validateEntryNoOverlap(existing, newEntry),
        throwsA(isA<RangeOverlapException>()),
      );
    });

    test('Overlapping juz and surah entries throw RangeOverlapException', () {
      const existing = [
        PreviousJuzEntry(id: 'j1', juzNumber: 1),
      ];
      const newEntry = PreviousSurahEntry(
        id: 's1',
        surahNumber: 2,
        isWholeSurah: false,
        fromAyah: 100,
        toAyah: 150,
      );

      expect(
        () => service.validateEntryNoOverlap(existing, newEntry),
        throwsA(isA<RangeOverlapException>()),
      );
    });

    test('Adjacent but non-overlapping entries pass', () {
      const existing = [
        PreviousJuzEntry(id: 'j1', juzNumber: 1),
      ];
      const newEntry = PreviousJuzEntry(id: 'j2', juzNumber: 2);

      expect(
        () => service.validateEntryNoOverlap(existing, newEntry),
        returnsNormally,
      );
    });
  });

  // ── validateEntryNoOverlapExcluding ────────────────────────────────────────

  group('validateEntryNoOverlapExcluding', () {
    test('Editing surah entry validates against other entries only', () {
      const entries = [
        PreviousSurahEntry(id: 's1', surahNumber: 1, isWholeSurah: true),
        PreviousSurahEntry(id: 's2', surahNumber: 2, isWholeSurah: false, fromAyah: 1, toAyah: 50),
      ];

      // Update s1 to cover Al-Fatiha partially — no overlap with s2
      const updated = PreviousSurahEntry(
        id: 's1',
        surahNumber: 1,
        isWholeSurah: false,
        fromAyah: 1,
        toAyah: 5,
      );

      expect(
        () => service.validateEntryNoOverlapExcluding(entries, 's1', updated),
        returnsNormally,
      );
    });

    test('Editing surah entry to overlap with another entry throws', () {
      const entries = [
        PreviousSurahEntry(id: 's1', surahNumber: 2, isWholeSurah: false, fromAyah: 1, toAyah: 50),
        PreviousSurahEntry(id: 's2', surahNumber: 2, isWholeSurah: false, fromAyah: 100, toAyah: 150),
      ];

      // Update s1 to overlap with s2
      const updated = PreviousSurahEntry(
        id: 's1',
        surahNumber: 2,
        isWholeSurah: false,
        fromAyah: 120,
        toAyah: 130,
      );

      expect(
        () => service.validateEntryNoOverlapExcluding(entries, 's1', updated),
        throwsA(isA<RangeOverlapException>()),
      );
    });

    test('Customizing Juz entry validates against other entries', () {
      const entries = [
        PreviousJuzEntry(id: 'j1', juzNumber: 1),
        PreviousSurahEntry(id: 's1', surahNumber: 3, isWholeSurah: true),
      ];

      // Customize j1 — no overlap with s1 (surah 3 is not in Juz 1)
      final customized = PreviousJuzEntry(
        id: 'j1',
        juzNumber: 1,
        customizedCoverage: [
          const JuzSurahCoverage(
            surahNumber: 1,
            segmentStart: QuranPosition(surahNumber: 1, ayahNumber: 1),
            segmentEnd: QuranPosition(surahNumber: 1, ayahNumber: 7),
            type: MemorizationCoverageType.full,
          ),
          const JuzSurahCoverage(
            surahNumber: 2,
            segmentStart: QuranPosition(surahNumber: 2, ayahNumber: 1),
            segmentEnd: QuranPosition(surahNumber: 2, ayahNumber: 141),
            type: MemorizationCoverageType.none,
          ),
        ],
      );

      expect(
        () => service.validateEntryNoOverlapExcluding(entries, 'j1', customized),
        returnsNormally,
      );
    });

    test('Resetting customized Juz to full validates overlap', () {
      // Scenario: Juz 1 was customized to exclude Al-Baqarah,
      // then user added Al-Baqarah 1–50 separately.
      // Resetting Juz 1 to full should fail because it overlaps.
      const entries = [
        PreviousJuzEntry(id: 'j1', juzNumber: 1, customizedCoverage: [
          JuzSurahCoverage(
            surahNumber: 1,
            segmentStart: QuranPosition(surahNumber: 1, ayahNumber: 1),
            segmentEnd: QuranPosition(surahNumber: 1, ayahNumber: 7),
            type: MemorizationCoverageType.full,
          ),
          JuzSurahCoverage(
            surahNumber: 2,
            segmentStart: QuranPosition(surahNumber: 2, ayahNumber: 1),
            segmentEnd: QuranPosition(surahNumber: 2, ayahNumber: 141),
            type: MemorizationCoverageType.none,
          ),
        ]),
        PreviousSurahEntry(id: 's1', surahNumber: 2, isWholeSurah: false, fromAyah: 1, toAyah: 50),
      ];

      // Reset j1 to full — should overlap with s1
      const fullEntry = PreviousJuzEntry(id: 'j1', juzNumber: 1);

      expect(
        () => service.validateEntryNoOverlapExcluding(entries, 'j1', fullEntry),
        throwsA(isA<RangeOverlapException>()),
      );
    });
  });

  // ── buildDefaultCoverage ──────────────────────────────────────────────────

  group('buildDefaultCoverage', () {
    test('Produces correct number of segments for Juz 1', () {
      final coverage = service.buildDefaultCoverage(1);
      // Juz 1: Al-Fatiha + Al-Baqarah 1–141
      expect(coverage.length, 2);
      expect(coverage[0].surahNumber, 1);
      expect(coverage[0].type, MemorizationCoverageType.full);
      expect(coverage[1].surahNumber, 2);
      expect(coverage[1].segmentEnd.ayahNumber, 141);
    });

    test('Produces single segment for Juz within one surah', () {
      final coverage = service.buildDefaultCoverage(2);
      // Juz 2: entirely within Al-Baqarah
      expect(coverage.length, 1);
      expect(coverage[0].surahNumber, 2);
    });
  });

  // ── suggestStartPosition ──────────────────────────────────────────────────

  group('suggestStartPosition', () {
    test('Empty ranges suggest beginning of Quran', () {
      final pos = service.suggestStartPosition([]);
      expect(pos, const QuranPosition(surahNumber: 1, ayahNumber: 1));
    });

    test('After Al-Fatiha suggests Al-Baqarah ayah 1', () {
      const entry = PreviousSurahEntry(id: 's1', surahNumber: 1, isWholeSurah: true);
      final ranges = service.rangesFromEntry(entry);
      final pos = service.suggestStartPosition(ranges);

      expect(pos, const QuranPosition(surahNumber: 2, ayahNumber: 1));
    });

    test('After partial surah suggests next ayah', () {
      const entry = PreviousSurahEntry(
        id: 's1',
        surahNumber: 2,
        isWholeSurah: false,
        fromAyah: 1,
        toAyah: 100,
      );
      final ranges = service.rangesFromEntry(entry);
      final pos = service.suggestStartPosition(ranges);

      expect(pos, const QuranPosition(surahNumber: 2, ayahNumber: 101));
    });

    test('Multiple entries suggest position after the latest range', () {
      const entries = [
        PreviousSurahEntry(id: 's1', surahNumber: 1, isWholeSurah: true),
        PreviousJuzEntry(id: 'j2', juzNumber: 2),
      ];
      final ranges = service.rangesFromEntries(entries);
      final pos = service.suggestStartPosition(ranges);

      expect(pos, const QuranPosition(surahNumber: 2, ayahNumber: 253));
    });
  });

  // ── getJuzAvailability ──────────────────────────────────────────────────

  group('getJuzAvailability', () {
    test('Returns available when no entries exist', () {
      final result = service.getJuzAvailability(juzNumber: 1, entries: []);
      expect(result.status, MemorizationAvailability.available);
      expect(result.message, isNull);
    });

    test('Returns fullyCovered when Juz is already added', () {
      const entries = [PreviousJuzEntry(id: 'j1', juzNumber: 1)];
      final result = service.getJuzAvailability(juzNumber: 1, entries: entries);
      expect(result.status, MemorizationAvailability.fullyCovered);
    });

    test('Returns partiallyCovered when some surahs from Juz are added', () {
      // Juz 1 includes Al-Fatiha (1:1–7) and Al-Baqarah (2:1–141)
      // Adding only Al-Fatiha partially covers Juz 1
      const entries = [
        PreviousSurahEntry(id: 's1', surahNumber: 1, isWholeSurah: true),
      ];
      final result = service.getJuzAvailability(juzNumber: 1, entries: entries);
      expect(result.status, MemorizationAvailability.partiallyCovered);
    });

    test('Returns available for Juz 2 when only Juz 1 is added', () {
      const entries = [PreviousJuzEntry(id: 'j1', juzNumber: 1)];
      final result = service.getJuzAvailability(juzNumber: 2, entries: entries);
      expect(result.status, MemorizationAvailability.available);
    });

    test('Returns fullyCovered when all surahs in Juz are individually added', () {
      // Juz 1: Al-Fatiha whole + Al-Baqarah 1–141
      const entries = [
        PreviousSurahEntry(id: 's1', surahNumber: 1, isWholeSurah: true),
        PreviousSurahEntry(id: 's2', surahNumber: 2, isWholeSurah: false, fromAyah: 1, toAyah: 141),
      ];
      final result = service.getJuzAvailability(juzNumber: 1, entries: entries);
      expect(result.status, MemorizationAvailability.fullyCovered);
    });
  });

  // ── getSurahAvailability ────────────────────────────────────────────────

  group('getSurahAvailability', () {
    test('Returns available when no entries exist', () {
      final result = service.getSurahAvailability(surahNumber: 1, entries: []);
      expect(result.status, MemorizationAvailability.available);
    });

    test('Returns fullyCovered when whole surah is already added', () {
      const entries = [
        PreviousSurahEntry(id: 's1', surahNumber: 1, isWholeSurah: true),
      ];
      final result = service.getSurahAvailability(surahNumber: 1, entries: entries);
      expect(result.status, MemorizationAvailability.fullyCovered);
    });

    test('Returns partiallyCovered when partial surah is added', () {
      const entries = [
        PreviousSurahEntry(id: 's1', surahNumber: 2, isWholeSurah: false, fromAyah: 1, toAyah: 50),
      ];
      final result = service.getSurahAvailability(surahNumber: 2, entries: entries);
      expect(result.status, MemorizationAvailability.partiallyCovered);
    });

    test('Returns fullyCovered when surah is covered by a Juz entry', () {
      // Al-Fatiha is fully within Juz 1
      const entries = [PreviousJuzEntry(id: 'j1', juzNumber: 1)];
      final result = service.getSurahAvailability(surahNumber: 1, entries: entries);
      expect(result.status, MemorizationAvailability.fullyCovered);
    });

    test('Returns partiallyCovered when surah is partially covered by a Juz', () {
      // Al-Baqarah has 286 ayahs. Juz 1 covers ayahs 1–141.
      const entries = [PreviousJuzEntry(id: 'j1', juzNumber: 1)];
      final result = service.getSurahAvailability(surahNumber: 2, entries: entries);
      expect(result.status, MemorizationAvailability.partiallyCovered);
    });

    test('Returns available for unrelated surah', () {
      const entries = [
        PreviousSurahEntry(id: 's1', surahNumber: 1, isWholeSurah: true),
      ];
      final result = service.getSurahAvailability(surahNumber: 12, entries: entries);
      expect(result.status, MemorizationAvailability.available);
    });
  });
}
