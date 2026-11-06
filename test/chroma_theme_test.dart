import 'package:chroma_theme/chroma_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ChromaThemeController', () {
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

    test('tracks seed presence correctly', () {
      final controller = ChromaThemeController();

      expect(controller.hasSeeds, isFalse);

      controller.setSeeds(const ChromaSeeds(primary: Colors.blue));
      expect(controller.hasSeeds, isTrue);

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
}
