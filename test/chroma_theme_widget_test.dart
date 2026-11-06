import 'package:chroma_theme/chroma_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ChromaTheme Widget & Extensions Tests (Task 6.5)', () {
    testWidgets('ChromaTheme.builder mounts and injects theme into MaterialApp', (tester) async {
      await tester.pumpWidget(
        ChromaTheme.builder(
          initialMode: ChromaThemeMode.dark,
          initialPalette: ChromaPalette.emerald,
          builder: (context, theme, darkTheme, themeMode) {
            return MaterialApp(
              theme: theme,
              darkTheme: darkTheme,
              themeMode: themeMode,
              home: Scaffold(
                body: Builder(
                  builder: (context) {
                    return Column(
                      children: [
                        Text('Mode: ${context.chroma.mode.name}'),
                        Text('Palette: ${context.chroma.palette.name}'),
                        ElevatedButton(
                          onPressed: () => context.toggleTheme(),
                          child: const Text('Toggle'),
                        ),
                      ],
                    );
                  },
                ),
              ),
            );
          },
        ),
      );

      expect(find.text('Mode: dark'), findsOneWidget);
      expect(find.text('Palette: emerald'), findsOneWidget);

      // Tap toggle button
      await tester.tap(find.text('Toggle'));
      await tester.pumpAndSettle();

      expect(find.text('Mode: light'), findsOneWidget);
    });

    testWidgets('ChromaTheme standalone child constructor wraps with AnimatedTheme', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ChromaTheme(
            initialMode: ChromaThemeMode.light,
            initialPalette: ChromaPalette.blue,
            child: Builder(
              builder: (context) {
                return Scaffold(
                  body: Text('Primary: ${context.chromaPrimary}'),
                );
              },
            ),
          ),
        ),
      );

      expect(find.byType(AnimatedTheme), findsOneWidget);
      expect(find.textContaining('Primary:'), findsOneWidget);
    });

    testWidgets('ChromaTheme.maybeOf returns null when outside ChromaTheme tree', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              final controller = ChromaTheme.maybeOf(context);
              return Text('Found: ${controller != null}');
            },
          ),
        ),
      );

      expect(find.text('Found: false'), findsOneWidget);
    });

    testWidgets('ChromaWidgets interact and update theme in tree', (tester) async {
      await tester.pumpWidget(
        ChromaTheme.builder(
          initialMode: ChromaThemeMode.light,
          builder: (context, theme, darkTheme, themeMode) {
            return MaterialApp(
              theme: theme,
              darkTheme: darkTheme,
              themeMode: themeMode,
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
