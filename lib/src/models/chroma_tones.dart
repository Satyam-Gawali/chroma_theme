import 'package:flutter/material.dart';

/// Represents a Material 3 Tonal Palette (0 to 100).
class ChromaTonalPalette {
  final Map<int, Color> tones;

  const ChromaTonalPalette(this.tones);

  Color operator [](int tone) => tones[tone] ?? tones[50]!;

  /// Generates a tonal palette from a seed color.
  /// Uses a simplified HSL approach to simulate Material 3 tones.
  factory ChromaTonalPalette.of(Color color) {
    final hsl = HSLColor.fromColor(color);
    final map = <int, Color>{};

    // Standard Material 3 tones
    final toneValues = [0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 95, 99, 100];

    for (var tone in toneValues) {
      // Material 3 tone is inverse of lightness (100 = White, 0 = Black)
      final lightness = tone / 100.0;
      map[tone] = hsl.withLightness(lightness).toColor();
    }

    return ChromaTonalPalette(map);
  }
}

/// Container for all tonal palettes generated for the current theme.
class ChromaTones {
  final ChromaTonalPalette primary;
  final ChromaTonalPalette secondary;
  final ChromaTonalPalette tertiary;
  final ChromaTonalPalette neutral;
  final ChromaTonalPalette neutralVariant;
  final ChromaTonalPalette error;

  const ChromaTones({
    required this.primary,
    required this.secondary,
    required this.tertiary,
    required this.neutral,
    required this.neutralVariant,
    required this.error,
  });

  factory ChromaTones.generate(ColorScheme scheme) {
    return ChromaTones(
      primary: ChromaTonalPalette.of(scheme.primary),
      secondary: ChromaTonalPalette.of(scheme.secondary),
      tertiary: ChromaTonalPalette.of(scheme.tertiary),
      neutral: ChromaTonalPalette.of(scheme.surface),
      neutralVariant: ChromaTonalPalette.of(scheme.outlineVariant),
      error: ChromaTonalPalette.of(scheme.error),
    );
  }
}
