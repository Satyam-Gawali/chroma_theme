import 'package:chroma_theme/chroma_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ChromaThemeController Tests (Task 6.1)', () {
    test('initializes with default light mode and blue palette', () {
      final controller = ChromaThemeController();

      expect(controller.mode, ChromaThemeMode.light);
      expect(controller.palette, ChromaPalette.blue);
      expect(controller.seeds, isNull);
      expect(controller.overrides, isNull);
      expect(controller.fontFamily, isNull);
      expect(controller.activeBrand, isNull);
    });

    test('sets theme mode and emits onThemeChanged stream', () async {
      final controller = ChromaThemeController();
      ChromaThemeMode? emittedMode;

      final sub = controller.onThemeChanged.listen((c) {
        emittedMode = c.mode;
      });

      controller.setTheme(ChromaThemeMode.dark);
      expect(controller.mode, ChromaThemeMode.dark);
      expect(emittedMode, ChromaThemeMode.dark);

      await sub.cancel();
    });

    test('toggles theme mode between light, dark and amoled', () {
      final controller = ChromaThemeController(initialMode: ChromaThemeMode.light);

      controller.toggleThemeMode();
      expect(controller.mode, ChromaThemeMode.dark);

      controller.toggleThemeMode();
      expect(controller.mode, ChromaThemeMode.light);

      controller.toggleThemeMode(supportAmoled: true);
      expect(controller.mode, ChromaThemeMode.amoled);
    });

    test('cycles through palettes seamlessly', () {
      final controller = ChromaThemeController(initialPalette: ChromaPalette.blue);

      controller.nextPalette();
      expect(controller.palette, isNot(ChromaPalette.blue));

      controller.previousPalette();
      expect(controller.palette, ChromaPalette.blue);

      controller.randomPalette();
      expect(controller.palette, isNotNull);
    });

    test('manages custom seeds and dynamic seed colors', () {
      final controller = ChromaThemeController();

      expect(controller.hasSeeds, isFalse);

      controller.setDynamicSeed(Colors.indigo);
      expect(controller.hasSeeds, isTrue);
      expect(controller.seeds?.primary, Colors.indigo);

      controller.clearSeeds();
      expect(controller.hasSeeds, isFalse);
      expect(controller.seeds, isNull);
    });

    test('registers and activates brand profiles', () {
      final controller = ChromaThemeController();
      const brand = ChromaBrandProfile(
        name: 'TechCorp',
        palette: ChromaPalette.emerald,
        fontFamily: 'Inter',
      );

      controller.registerBrand(brand);
      expect(controller.brands.length, 1);

      controller.setBrand('TechCorp');
      expect(controller.activeBrand, 'TechCorp');
      expect(controller.palette, ChromaPalette.emerald);
      expect(controller.fontFamily, 'Inter');
    });

    test('evaluates sun-aware scheduled theming', () {
      const schedule = ChromaSchedule(
        lightTime: TimeOfDay(hour: 6, minute: 0),
        darkTime: TimeOfDay(hour: 18, minute: 0),
        darkEffectiveMode: ChromaThemeMode.amoled,
      );

      final controller = ChromaThemeController(schedule: schedule);

      expect(controller.schedule, isNotNull);
      final day = DateTime(2025, 6, 1, 10, 0);
      expect(schedule.resolveMode(day), ChromaThemeMode.light);

      final night = DateTime(2025, 6, 1, 23, 0);
      expect(schedule.resolveMode(night), ChromaThemeMode.amoled);
    });

    test('persists state with ThemePersistence adapter', () async {
      final persistence = InMemoryThemePersistence(
        initialMode: ChromaThemeMode.amoled,
        initialPalette: ChromaPalette.neonForest,
      );

      final controller = ChromaThemeController(persistence: persistence);
      await controller.loadFromPersistence();

      expect(controller.mode, ChromaThemeMode.amoled);
      expect(controller.palette, ChromaPalette.neonForest);

      controller.setTheme(ChromaThemeMode.light);
      expect(await persistence.loadThemeMode(), ChromaThemeMode.light);
    });

    test('builds and caches ThemeData correctly', () {
      final controller = ChromaThemeController(initialPalette: ChromaPalette.blue);

      final theme1 = controller.buildThemeData(Brightness.light);
      final theme2 = controller.buildThemeData(Brightness.light);

      // Verify cache hit
      expect(identical(theme1, theme2), isTrue);

      final lightTheme = controller.buildLightThemeData();
      final darkTheme = controller.buildDarkThemeData();

      expect(lightTheme.brightness, Brightness.light);
      expect(darkTheme.brightness, Brightness.dark);
    });
  });
}
