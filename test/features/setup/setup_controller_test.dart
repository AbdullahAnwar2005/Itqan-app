import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:itqan/features/setup/application/previous_memorization_draft_entry.dart';
import 'package:itqan/features/setup/application/previous_memorization_service.dart';
import 'package:itqan/features/setup/application/setup_providers.dart';

void main() {
  group('SetupController', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test('State preservation when toggling hasPreviousMemorization', () {
      final controller = container.read(setupControllerProvider.notifier);

      // 1. Initial state
      expect(container.read(setupControllerProvider).hasPreviousMemorization, isFalse);
      expect(container.read(setupControllerProvider).previousMemorizationEntries, isEmpty);

      // 2. Enable and add an entry
      controller.setHasPreviousMemorization(true);
      controller.addSurahEntry(1, isWholeSurah: true); // Al-Fatiha
      
      var state = container.read(setupControllerProvider);
      expect(state.hasPreviousMemorization, isTrue);
      expect(state.previousMemorizationEntries, hasLength(1));
      expect((state.previousMemorizationEntries.first as PreviousSurahEntry).surahNumber, 1);

      // 3. Disable hasPreviousMemorization (select "لا، سأبدأ من الصفر")
      controller.setHasPreviousMemorization(false);
      
      state = container.read(setupControllerProvider);
      expect(state.hasPreviousMemorization, isFalse);
      // Entries must be cleared in state
      expect(state.previousMemorizationEntries, isEmpty, reason: 'Entries should be cleared when selecting "لا، سأبدأ من الصفر"');

      // 4. Re-enable hasPreviousMemorization
      controller.setHasPreviousMemorization(true);
      
      state = container.read(setupControllerProvider);
      expect(state.hasPreviousMemorization, isTrue);
      expect(state.previousMemorizationEntries, isEmpty);
    });

    test('Bulk surah entry creation and update', () {
      final controller = container.read(setupControllerProvider.notifier);
      controller.setHasPreviousMemorization(true);

      // 1. Add bulk entry (Al-Fatiha, Al-Ikhlas)
      controller.addBulkSurahEntry([1, 112]);
      
      var state = container.read(setupControllerProvider);
      expect(state.previousMemorizationEntries, hasLength(1));
      var bulkEntry = state.previousMemorizationEntries.first as PreviousBulkSurahEntry;
      expect(bulkEntry.surahCoverages, hasLength(2));
      expect(bulkEntry.surahCoverages[0].type, MemorizationCoverageType.full);

      // 2. Update bulk entry (change Al-Fatiha to partial, remove Al-Ikhlas)
      controller.updateBulkSurahEntry(
        entryId: bulkEntry.id,
        surahCoverages: [
          const SurahCoverage(surahNumber: 1, type: MemorizationCoverageType.partial, fromAyah: 1, toAyah: 3),
          const SurahCoverage(surahNumber: 112, type: MemorizationCoverageType.none),
        ],
      );

      state = container.read(setupControllerProvider);
      bulkEntry = state.previousMemorizationEntries.first as PreviousBulkSurahEntry;
      expect(bulkEntry.surahCoverages, hasLength(2));
      expect(bulkEntry.surahCoverages[0].type, MemorizationCoverageType.partial);
      expect(bulkEntry.surahCoverages[1].type, MemorizationCoverageType.none);

      // Verify derived ranges (only Al-Fatiha 1-3)
      final service = container.read(previousMemorizationServiceProvider);
      final ranges = service.rangesFromEntries(state.previousMemorizationEntries);
      expect(ranges, hasLength(1));
      expect(ranges[0].from.surahNumber, 1);
      expect(ranges[0].to.ayahNumber, 3);
    });

    test('updateBulkSurahEntry rejects empty effective coverage', () {
      final controller = container.read(setupControllerProvider.notifier);
      controller.setHasPreviousMemorization(true);
      controller.addBulkSurahEntry([1]);
      final entryId = container.read(setupControllerProvider).previousMemorizationEntries.first.id;

      expect(
        () => controller.updateBulkSurahEntry(
          entryId: entryId,
          surahCoverages: [const SurahCoverage(surahNumber: 1, type: MemorizationCoverageType.none)],
        ),
        throwsA(isA<InvalidRangeException>()),
      );
    });
  });
}
