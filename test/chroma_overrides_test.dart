import 'package:chroma_theme/chroma_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ChromaOverrides & Component Theming Tests', () {
    test('copyWith updates individual properties without affecting others', () {
      const original = ChromaOverrides(
        appBarTheme: AppBarTheme(elevation: 0),
        cardTheme: CardThemeData(elevation: 4),
      );

      final updated = original.copyWith(
        cardTheme: const CardThemeData(elevation: 8),
      );

      expect(updated.appBarTheme?.elevation, 0);
      expect(updated.cardTheme?.elevation, 8);
      expect(updated.textTheme, isNull);
    });

    test('ChromaThemeBuilder applies all component overrides to ThemeData', () {
      final scheme = ColorScheme.fromSeed(seedColor: Colors.blue);
      const customOverrides = ChromaOverrides(
        appBarTheme: AppBarTheme(
          centerTitle: true,
          elevation: 5,
          backgroundColor: Colors.purple,
        ),
        cardTheme: CardThemeData(
          elevation: 6,
          color: Colors.amber,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.green,
        ),
        navigationBarTheme: NavigationBarThemeData(
          elevation: 3,
        ),
        bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: Colors.teal,
        ),
        dialogTheme: DialogThemeData(
          backgroundColor: Colors.cyan,
        ),
      );

      final theme = ChromaThemeBuilder.build(
        scheme: scheme,
        textTheme: ThemeData.light().textTheme,
        overrides: customOverrides,
        fontFamily: 'Montserrat',
      );

      expect(theme.useMaterial3, isTrue);
      expect(theme.textTheme.bodyMedium?.fontFamily, 'Montserrat');
      expect(theme.appBarTheme.centerTitle, isTrue);
      expect(theme.appBarTheme.elevation, 5);
      expect(theme.appBarTheme.backgroundColor, Colors.purple);
      expect(theme.cardTheme.elevation, 6);
      expect(theme.cardTheme.color, Colors.amber);
      expect(theme.inputDecorationTheme.filled, isTrue);
      expect(theme.floatingActionButtonTheme.backgroundColor, Colors.green);
      expect(theme.navigationBarTheme.elevation, 3);
      expect(theme.bottomSheetTheme.backgroundColor, Colors.teal);
      expect(theme.dialogTheme.backgroundColor, Colors.cyan);
    });

    test('AMOLED mode applies crisp styling to cards, dialogs and sheets when not overridden', () {
      const amoledScheme = ColorScheme.dark(
        surface: Colors.black,
        surfaceContainerLow: Color(0xFF0A0A0A),
      );

      final theme = ChromaThemeBuilder.build(
        scheme: amoledScheme,
        textTheme: ThemeData.dark().textTheme,
      );

      expect(theme.scaffoldBackgroundColor, Colors.black);
      expect(theme.cardTheme.color, const Color(0xFF0A0A0A));
      expect(theme.bottomSheetTheme.backgroundColor, Colors.black);
      expect(theme.dialogTheme.backgroundColor, const Color(0xFF0A0A0A));
    });
  });
}
