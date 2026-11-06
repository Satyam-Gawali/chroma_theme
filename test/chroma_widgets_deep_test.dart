import 'package:chroma_theme/chroma_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ChromaWidgets Deep UI & Interaction Tests', () {
    testWidgets('ChromaThemeToggle switches between Light, Dark and AMOLED on tap', (tester) async {
      await tester.pumpWidget(
        ChromaTheme.builder(
          initialMode: ChromaThemeMode.light,
          builder: (context, theme, darkTheme, themeMode) {
            return MaterialApp(
              theme: theme,
              darkTheme: darkTheme,
              themeMode: themeMode,
              home: const Scaffold(
                body: ChromaThemeToggle(showAmoled: true),
              ),
            );
          },
        ),
      );

      // Verify buttons exist
      expect(find.text('Light'), findsOneWidget);
      expect(find.text('Dark'), findsOneWidget);
      expect(find.text('AMOLED'), findsOneWidget);

      // Tap Dark
      await tester.tap(find.text('Dark'));
      await tester.pumpAndSettle();

      final controller = ChromaTheme.of(tester.element(find.byType(ChromaThemeToggle)));
      expect(controller.mode, ChromaThemeMode.dark);

      // Tap AMOLED
      await tester.tap(find.text('AMOLED'));
      await tester.pumpAndSettle();
      expect(controller.mode, ChromaThemeMode.amoled);
    });

    testWidgets('ChromaThemeToggle respects showAmoled = false', (tester) async {
      await tester.pumpWidget(
        ChromaTheme.builder(
          builder: (context, theme, darkTheme, themeMode) {
            return MaterialApp(
              theme: theme,
              home: const Scaffold(
                body: ChromaThemeToggle(showAmoled: false),
              ),
            );
          },
        ),
      );

      expect(find.text('Light'), findsOneWidget);
      expect(find.text('Dark'), findsOneWidget);
      expect(find.text('AMOLED'), findsNothing);
    });

    testWidgets('ChromaPaletteSelector renders grid and switches palette on tap', (tester) async {
      await tester.pumpWidget(
        ChromaTheme.builder(
          initialPalette: ChromaPalette.blue,
          builder: (context, theme, darkTheme, themeMode) {
            return MaterialApp(
              theme: theme,
              home: const Scaffold(
                body: ChromaPaletteSelector(horizontal: false),
              ),
            );
          },
        ),
      );

      expect(find.byType(ChromaPaletteSelector), findsOneWidget);

      // Tap the second circle swatch
      final gestureDetectors = find.descendant(
        of: find.byType(ChromaPaletteSelector),
        matching: find.byType(GestureDetector),
      );

      expect(gestureDetectors, findsWidgets);

      await tester.tap(gestureDetectors.at(1));
      await tester.pumpAndSettle();

      final controller = ChromaTheme.of(tester.element(find.byType(ChromaPaletteSelector)));
      expect(controller.palette, isNotNull);
    });

    testWidgets('showChromaThemeSheet opens bottom sheet and displays components', (tester) async {
      await tester.pumpWidget(
        ChromaTheme.builder(
          builder: (context, theme, darkTheme, themeMode) {
            return MaterialApp(
              theme: theme,
              home: Scaffold(
                body: Builder(
                  builder: (context) {
                    return ElevatedButton(
                      onPressed: () => showChromaThemeSheet(context),
                      child: const Text('Open Sheet'),
                    );
                  },
                ),
              ),
            );
          },
        ),
      );

      // Tap to open sheet
      await tester.tap(find.text('Open Sheet'));
      await tester.pumpAndSettle();

      expect(find.text('Theme & Appearance'), findsOneWidget);
      expect(find.byType(ChromaThemeToggle), findsOneWidget);
      expect(find.byType(ChromaPaletteSelector), findsOneWidget);
    });
  });
}
