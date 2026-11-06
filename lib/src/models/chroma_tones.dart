import 'package:flutter/material.dart';

/// Represents a Material 3 Tonal Palette (0 to 100).
class ChromaTonalPalette {
  final Map<int, Color> tones;

  const ChromaTonalPalette(this.tones);

  /// Access a tone from 0 to 100.
  /// If the exact tone doesn't exist, it smoothly interpolates between adjacent tones.
  Color operator [](int tone) {
    if (tones.containsKey(tone)) return tones[tone]!;

    final clamped = tone.clamp(0, 100);
    if (tones.containsKey(clamped)) return tones[clamped]!;

    // Find closest lower and upper tone keys to interpolate
    int? lower;
    int? upper;
    final keys = tones.keys.toList()..sort();

    for (final key in keys) {
      if (key <= clamped) {
        lower = key;
      }
      if (key >= clamped && upper == null) {
        upper = key;
      }
    }

    if (lower != null && upper != null && lower != upper) {
      final ratio = (clamped - lower) / (upper - lower);
      return Color.lerp(tones[lower], tones[upper], ratio)!;
    }

    return tones[lower ?? upper ?? 50] ?? const Color(0xFF000000);
  }

  /// Generates a tonal palette from a seed color.
  factory ChromaTonalPalette.of(Color color) {
    final hsl = HSLColor.fromColor(color);
    final map = <int, Color>{
      0: const Color(0xFF000000),
      100: const Color(0xFFFFFFFF),
    };

    const intermediateTones = [10, 20, 30, 40, 50, 60, 70, 80, 90, 95, 99];
    for (final tone in intermediateTones) {
      final lightness = (tone / 100.0).clamp(0.0, 1.0);
      final saturation = (hsl.saturation * (1.0 - (tone - 50).abs() / 120.0))
          .clamp(0.0, 1.0);
      map[tone] = hsl
          .withLightness(lightness)
          .withSaturation(saturation)
          .toColor();
    }

    return ChromaTonalPalette(map);
  }
}

/// Container for all tonal palettes generated for the current theme.
class ChromaTones {
  static final Expando<ChromaTones> _cache = Expando<ChromaTones>();

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

  /// Generates or retrieves cached [ChromaTones] for the given [scheme].
  factory ChromaTones.generate(ColorScheme scheme) {
    final cached = _cache[scheme];
    if (cached != null) return cached;

    final generated = ChromaTones(
      primary: ChromaTonalPalette.of(scheme.primary),
      secondary: ChromaTonalPalette.of(scheme.secondary),
      tertiary: ChromaTonalPalette.of(scheme.tertiary),
      neutral: ChromaTonalPalette.of(scheme.surface),
      neutralVariant: ChromaTonalPalette.of(scheme.outlineVariant),
      error: ChromaTonalPalette.of(scheme.error),
    );

    _cache[scheme] = generated;
    return generated;
  }
}
