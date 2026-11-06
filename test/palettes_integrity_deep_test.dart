import 'package:chroma_theme/chroma_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUpAll(() {
    registerDefaultPalettes();
  });

  group('Deep Palette Integrity & Material 3 Tokens Verification', () {
    final palettes = ChromaPalette.values
        .where((p) => p != ChromaPalette.custom)
        .toList();

    test('verifies all 23 palettes are registered and functional', () {
      expect(palettes.length, 23);

      for (final palette in palettes) {
        final entry = PaletteRegistry.get(palette);
        expect(entry, isNotNull, reason: 'Palette ${palette.name} must be in registry');

        // Test Light Scheme
        final light = entry!.light();
        expect(light.brightness, Brightness.light);
        expect(light.primary, isNotNull);
        expect(light.onPrimary, isNotNull);
        expect(light.surface, isNotNull);
        expect(light.onSurface, isNotNull);
        expect(light.surfaceContainerLowest, isNotNull);
        expect(light.surfaceContainer, isNotNull);

        // Test Dark Scheme
        final dark = entry.dark();
        expect(dark.brightness, Brightness.dark);
        expect(dark.primary, isNotNull);
        expect(dark.surface, isNotNull);

        // Test High Contrast Scheme
        final hc = entry.highContrast();
        expect(hc.brightness, Brightness.dark);
        expect(hc.surface, Colors.black);
        expect(hc.outline, Colors.white);
      }
    });

    test('verifies AMOLED conversion across all 23 palettes', () {
      for (final palette in palettes) {
        final amoled = ChromaColorSchemeBuilder.build(
          palette: palette,
          mode: ChromaThemeMode.amoled,
        );

        expect(amoled.surface, Colors.black, reason: '${palette.name} amoled surface');
        expect(amoled.surfaceContainerLowest, Colors.black);

        // Primary brand color should NOT be black
        expect(amoled.primary, isNot(Colors.black), reason: '${palette.name} primary must retain color in AMOLED');
      }
    });

    test('verifies WCAG contrast compliance for essential roles across all palettes', () {
      for (final palette in palettes) {
        final entry = PaletteRegistry.get(palette)!;
        final lightScheme = entry.light();

        final onSurfaceRatio = ChromaAuditor.calculateContrastRatio(
          lightScheme.onSurface,
          lightScheme.surface,
        );
        // OnSurface vs Surface must be clearly legible (>= 4.5:1)
        expect(
          onSurfaceRatio,
          greaterThanOrEqualTo(4.5),
          reason: '${palette.name} onSurface contrast ratio is ${onSurfaceRatio.toStringAsFixed(2)}:1',
        );

        // High contrast scheme must have extreme contrast
        final hcScheme = entry.highContrast();
        final hcRatio = ChromaAuditor.calculateContrastRatio(
          hcScheme.onSurface,
          hcScheme.surface,
        );
        expect(hcRatio, closeTo(21.0, 1.0));
      }
    });
  });
}
