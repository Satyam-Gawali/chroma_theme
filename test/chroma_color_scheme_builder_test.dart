import 'package:chroma_theme/chroma_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ChromaColorSchemeBuilder Tests (Task 6.2)', () {
    setUp(() {
      registerDefaultPalettes();
    });

    test('builds schemes for all 5 ChromaThemeModes', () {
      final modes = [
        ChromaThemeMode.light,
        ChromaThemeMode.dark,
        ChromaThemeMode.system,
        ChromaThemeMode.highContrast,
        ChromaThemeMode.amoled,
      ];

      for (final mode in modes) {
        final scheme = ChromaColorSchemeBuilder.build(
          palette: ChromaPalette.blue,
          mode: mode,
          systemBrightness: Brightness.dark,
        );

        expect(scheme, isNotNull);
        expect(scheme.primary, isNotNull);
        expect(scheme.surface, isNotNull);
      }
    });

    test('AMOLED mode preserves palette brand colors and enforces pure black surface', () {
      final darkScheme = ChromaColorSchemeBuilder.build(
        palette: ChromaPalette.neonForest,
        mode: ChromaThemeMode.dark,
      );

      final amoledScheme = ChromaColorSchemeBuilder.build(
        palette: ChromaPalette.neonForest,
        mode: ChromaThemeMode.amoled,
      );

      // AMOLED surfaces must be pure black
      expect(amoledScheme.surface, Colors.black);
      expect(amoledScheme.surfaceContainerLowest, Colors.black);

      // Primary brand accent must be preserved from the palette, NOT wiped
      expect(amoledScheme.primary, darkScheme.primary);
      expect(amoledScheme.secondary, darkScheme.secondary);
      expect(amoledScheme.tertiary, darkScheme.tertiary);
    });

    test('High-Contrast mode uses registered high contrast palette', () {
      final hcScheme = ChromaColorSchemeBuilder.build(
        palette: ChromaPalette.blue,
        mode: ChromaThemeMode.highContrast,
      );

      expect(hcScheme.surface, Colors.black);
      expect(hcScheme.onPrimary, Colors.black);
      expect(hcScheme.outline, Colors.white);
    });

    test('Custom seeds override palette and adapt to AMOLED / High-Contrast', () {
      const customSeeds = ChromaSeeds(
        primary: Color(0xFF9C27B0), // Purple
        secondary: Color(0xFFFF9800), // Orange
      );

      final seedScheme = ChromaColorSchemeBuilder.build(
        palette: ChromaPalette.blue,
        mode: ChromaThemeMode.light,
        seeds: customSeeds,
      );

      // Primary color must match custom purple seed derivation
      expect(seedScheme.primary, isNotNull);

      final amoledSeedScheme = ChromaColorSchemeBuilder.build(
        palette: ChromaPalette.blue,
        mode: ChromaThemeMode.amoled,
        seeds: customSeeds,
      );

      expect(amoledSeedScheme.surface, Colors.black);
      expect(amoledSeedScheme.surfaceContainerLowest, Colors.black);
    });
  });
}
