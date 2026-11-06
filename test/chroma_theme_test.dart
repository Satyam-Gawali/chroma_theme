import 'package:chroma_theme/chroma_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ChromaThemeController Core & Modes', () {
    test('updates mode and exposes effective darkness', () {
      final controller = ChromaThemeController(
        initialMode: ChromaThemeMode.system,
      );

      expect(controller.isDarkEffective(Brightness.light), isFalse);
      expect(controller.isDarkEffective(Brightness.dark), isTrue);

      controller.setTheme(ChromaThemeMode.amoled);
      expect(controller.mode, ChromaThemeMode.amoled);
      expect(controller.isDarkEffective(Brightness.light), isTrue);
    });

    test('toggles theme mode smoothly', () {
      final controller = ChromaThemeController(initialMode: ChromaThemeMode.light);

      controller.toggleThemeMode();
      expect(controller.mode, ChromaThemeMode.dark);

      controller.toggleThemeMode();
      expect(controller.mode, ChromaThemeMode.light);

      // Support AMOLED toggle
      controller.toggleThemeMode(supportAmoled: true);
      expect(controller.mode, ChromaThemeMode.amoled);
    });

    test('cycles next, previous and random palettes', () {
      final controller = ChromaThemeController(initialPalette: ChromaPalette.blue);

      controller.nextPalette();
      expect(controller.palette, isNot(ChromaPalette.blue));

      controller.previousPalette();
      expect(controller.palette, ChromaPalette.blue);

      controller.randomPalette();
      expect(controller.palette, isNotNull);
    });

    test('tracks seed presence and dynamic seeds', () {
      final controller = ChromaThemeController();

      expect(controller.hasSeeds, isFalse);

      controller.setDynamicSeed(Colors.purple);
      expect(controller.hasSeeds, isTrue);
      expect(controller.seeds?.primary, Colors.purple);

      controller.clearSeeds();
      expect(controller.hasSeeds, isFalse);
    });

    test('maps ChromaThemeMode to Flutter ThemeMode correctly', () {
      final controller = ChromaThemeController();

      controller.setTheme(ChromaThemeMode.system);
      expect(controller.flutterThemeMode, ThemeMode.system);

      controller.setTheme(ChromaThemeMode.light);
      expect(controller.flutterThemeMode, ThemeMode.light);

      controller.setTheme(ChromaThemeMode.dark);
      expect(controller.flutterThemeMode, ThemeMode.dark);

      controller.setTheme(ChromaThemeMode.amoled);
      expect(controller.flutterThemeMode, ThemeMode.dark);

      controller.setTheme(ChromaThemeMode.highContrast);
      expect(controller.flutterThemeMode, ThemeMode.dark);
    });

    test('integrates with ThemePersistence adapter', () async {
      final persistence = InMemoryThemePersistence(
        initialMode: ChromaThemeMode.amoled,
        initialPalette: ChromaPalette.neonForest,
      );

      final controller = ChromaThemeController(
        persistence: persistence,
      );

      await controller.loadFromPersistence();

      expect(controller.mode, ChromaThemeMode.amoled);
      expect(controller.palette, ChromaPalette.neonForest);

      controller.setTheme(ChromaThemeMode.light);
      expect(await persistence.loadThemeMode(), ChromaThemeMode.light);

      controller.setPalette(ChromaPalette.berryBlush);
      expect(await persistence.loadPalette(), ChromaPalette.berryBlush);
    });
  });

  group('ChromaSeeds & ChromaOverrides Equality', () {
    test('ChromaSeeds equality and copyWith', () {
      const s1 = ChromaSeeds(primary: Colors.blue, neutralDark: Colors.black);
      const s2 = ChromaSeeds(primary: Colors.blue, neutralDark: Colors.black);
      const s3 = ChromaSeeds(primary: Colors.red);

      expect(s1 == s2, isTrue);
      expect(s1.hashCode, s2.hashCode);
      expect(s1 == s3, isFalse);

      final copied = s1.copyWith(primary: Colors.green);
      expect(copied.primary, Colors.green);
      expect(copied.neutralDark, Colors.black);
    });

    test('ChromaOverrides value equality', () {
      const o1 = ChromaOverrides(appBarTheme: AppBarTheme(elevation: 0));
      const o2 = ChromaOverrides(appBarTheme: AppBarTheme(elevation: 0));
      const o3 = ChromaOverrides(appBarTheme: AppBarTheme(elevation: 4));

      expect(o1 == o2, isTrue);
      expect(o1.hashCode, o2.hashCode);
      expect(o1 == o3, isFalse);
    });
  });

  group('ChromaTheme.builder Widget', () {
    testWidgets('mounts and provides theme data to MaterialApp', (tester) async {
      await tester.pumpWidget(
        ChromaTheme.builder(
          initialMode: ChromaThemeMode.system,
          initialPalette: ChromaPalette.blue,
          builder: (context, theme, darkTheme, themeMode) {
            return MaterialApp(
              theme: theme,
              darkTheme: darkTheme,
              themeMode: themeMode,
              home: Builder(
                builder: (context) {
                  return Scaffold(
                    body: Text(
                      'Mode: ${ChromaTheme.of(context).mode.name}',
                    ),
                  );
                },
              ),
            );
          },
        ),
      );

      expect(find.text('Mode: system'), findsOneWidget);
    });
  });

  group('ChromaTones & TonalPalettes', () {
    test('generates, caches and interpolates tones', () {
      final scheme = ColorScheme.fromSeed(seedColor: Colors.blue);
      final tones1 = ChromaTones.generate(scheme);
      final tones2 = ChromaTones.generate(scheme);

      // Verify Expando cache identity
      expect(identical(tones1, tones2), isTrue);

      expect(tones1.primary[0], const Color(0xFF000000));
      expect(tones1.primary[100], const Color(0xFFFFFFFF));

      // Test interpolation between known tones
      final interpolated = tones1.primary[45];
      expect(interpolated, isNotNull);
    });
  });

  group('ChromaThemeUtils', () {
    test('parses various hex formats accurately', () {
      expect(ChromaThemeUtils.fromHex('#FFF'), const Color(0xFFFFFFFF));
      expect(ChromaThemeUtils.fromHex('000'), const Color(0xFF000000));
      expect(ChromaThemeUtils.fromHex('#FF0000'), const Color(0xFFFF0000));
      expect(ChromaThemeUtils.fromHex('8000FF00'), const Color(0x8000FF00));
      expect(ChromaThemeUtils.fromHex('invalid'), isNull);
      expect(ChromaThemeUtils.fromHex(''), isNull);
    });

    test('converts Color to hex format', () {
      expect(ChromaThemeUtils.toHex(const Color(0xFFFF0000)), '#FF0000');
      expect(
        ChromaThemeUtils.toHex(const Color(0x8000FF00), includeAlpha: true),
        '#8000FF00',
      );
    });

    test('harmonizes, darkens, lightens and calculates contrast', () {
      final harmonized = ChromaThemeUtils.harmonize(Colors.red, Colors.blue);
      expect(harmonized, isNotNull);

      final lightened = ChromaThemeUtils.lighten(Colors.blue, 0.2);
      expect(lightened, isNotNull);

      final darkened = ChromaThemeUtils.darken(Colors.blue, 0.2);
      expect(darkened, isNotNull);

      expect(ChromaThemeUtils.contrastColor(Colors.white), Colors.black);
      expect(ChromaThemeUtils.contrastColor(Colors.black), Colors.white);
    });
  });

  group('PaletteRegistry & Custom Palettes', () {
    test('registers and resolves custom palette', () {
      PaletteRegistry.registerCustom(
        PaletteEntry(
          light: () => ColorScheme.fromSeed(seedColor: Colors.amber),
          dark: () => ColorScheme.fromSeed(seedColor: Colors.amber, brightness: Brightness.dark),
          highContrast: () => ColorScheme.fromSeed(seedColor: Colors.amber, brightness: Brightness.dark),
        ),
      );

      final customEntry = PaletteRegistry.get(ChromaPalette.custom);
      expect(customEntry, isNotNull);
      expect(customEntry!.resolve(brightness: Brightness.light).primary, isNotNull);
    });
  });

  group('ChromaSchedule Sun-Aware Theming', () {
    test('resolves day and night according to schedule', () {
      const schedule = ChromaSchedule(
        lightTime: TimeOfDay(hour: 6, minute: 0),
        darkTime: TimeOfDay(hour: 18, minute: 0),
        darkEffectiveMode: ChromaThemeMode.amoled,
      );

      final daytime = DateTime(2025, 1, 1, 12, 0);
      expect(schedule.resolveMode(daytime), ChromaThemeMode.light);

      final nighttime = DateTime(2025, 1, 1, 22, 0);
      expect(schedule.resolveMode(nighttime), ChromaThemeMode.amoled);
    });
  });

  group('ChromaBrandProfile Multi-Brand', () {
    test('registers and switches brand profile', () {
      final controller = ChromaThemeController();
      const brandA = ChromaBrandProfile(
        name: 'BrandAlpha',
        palette: ChromaPalette.emerald,
        fontFamily: 'Inter',
      );

      controller.registerBrand(brandA);
      controller.setBrand('BrandAlpha');

      expect(controller.activeBrand, 'BrandAlpha');
      expect(controller.palette, ChromaPalette.emerald);
      expect(controller.fontFamily, 'Inter');
    });
  });

  group('ChromaAuditor Accessibility Contrast', () {
    test('calculates WCAG contrast ratio accurately', () {
      final ratio = ChromaAuditor.calculateContrastRatio(Colors.black, Colors.white);
      expect(ratio, closeTo(21.0, 0.5));

      final sameRatio = ChromaAuditor.calculateContrastRatio(Colors.white, Colors.white);
      expect(sameRatio, closeTo(1.0, 0.1));

      final scheme = ColorScheme.fromSeed(seedColor: Colors.blue);
      final report = ChromaAuditor.audit(scheme);
      expect(report.results.length, greaterThan(5));
    });
  });

  group('ChromaThemeExporter', () {
    test('exports standalone code for ColorScheme and ThemeData', () {
      final scheme = ColorScheme.fromSeed(seedColor: Colors.blue);
      final code = ChromaThemeExporter.exportColorScheme(scheme);
      expect(code, contains('ColorScheme('));
      expect(code, contains('primary:'));

      final themeCode = ChromaThemeExporter.exportThemeData(
        lightScheme: scheme,
        darkScheme: scheme.copyWith(brightness: Brightness.dark),
      );
      expect(themeCode, contains('class AppTheme'));
    });
  });

  group('ChromaWidgets Drop-in UI', () {
    testWidgets('renders ChromaThemeToggle and ChromaPaletteSelector', (tester) async {
      await tester.pumpWidget(
        ChromaTheme.builder(
          builder: (context, theme, darkTheme, themeMode) {
            return MaterialApp(
              theme: theme,
              home: const Scaffold(
                body: Column(
                  children: [
                    ChromaThemeToggle(),
                    ChromaPaletteSelector(),
                  ],
                ),
              ),
            );
          },
        ),
      );

      expect(find.byType(ChromaThemeToggle), findsOneWidget);
      expect(find.byType(ChromaPaletteSelector), findsOneWidget);
    });
  });
}
