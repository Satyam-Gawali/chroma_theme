import 'package:chroma_theme/chroma_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PaletteRegistry Tests (Task 6.3)', () {
    setUp(() {
      registerDefaultPalettes();
    });

    test('registers all built-in palettes with light, dark, and high contrast entries', () {
      final builtInPalettes = ChromaPalette.values.where((p) => p != ChromaPalette.custom).toList();

      for (final palette in builtInPalettes) {
        final entry = PaletteRegistry.get(palette);
        expect(entry, isNotNull, reason: 'Palette ${palette.name} must be registered');

        final light = entry!.light();
        final dark = entry.dark();
        final hc = entry.highContrast();

        expect(light.brightness, Brightness.light, reason: '${palette.name} light scheme');
        expect(dark.brightness, Brightness.dark, reason: '${palette.name} dark scheme');
        expect(hc.brightness, Brightness.dark, reason: '${palette.name} high-contrast scheme');

        // Test entry resolution
        expect(entry.resolve(brightness: Brightness.light).brightness, Brightness.light);
        expect(entry.resolve(brightness: Brightness.dark).brightness, Brightness.dark);
        expect(entry.resolve(brightness: Brightness.dark, isHighContrast: true).surface, Colors.black);
      }
    });

    test('allows dynamic registration of custom palettes', () {
      PaletteRegistry.registerCustom(
        PaletteEntry(
          light: () => ColorScheme.fromSeed(seedColor: Colors.deepOrange),
          dark: () => ColorScheme.fromSeed(seedColor: Colors.deepOrange, brightness: Brightness.dark),
          highContrast: () => ColorScheme.fromSeed(seedColor: Colors.deepOrange, brightness: Brightness.dark),
        ),
      );

      final custom = PaletteRegistry.get(ChromaPalette.custom);
      expect(custom, isNotNull);
      expect(custom!.light().primary, isNotNull);
    });
  });
}
