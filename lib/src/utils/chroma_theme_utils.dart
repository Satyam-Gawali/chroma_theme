import 'dart:math' as math;
import 'package:flutter/material.dart';

class ChromaThemeUtils {
  ChromaThemeUtils._();

  /// Parses a hex string into a [Color] object.
  ///
  /// Supports formats:
  /// - `#RGB` or `RGB` (expanded to `RRGGBB`)
  /// - `#RGBA` or `RGBA` (expanded to `RRGGBBAA`)
  /// - `#RRGGBB` or `RRGGBB`
  /// - `#AARRGGBB` or `AARRGGBB`
  static Color? fromHex(String hexString) {
    var hex = hexString.trim().replaceAll('#', '');
    if (hex.isEmpty) return null;

    // Handle 3-digit shorthand (#RGB -> #RRGGBB)
    if (hex.length == 3) {
      hex = hex.split('').map((c) => '$c$c').join();
    }
    // Handle 4-digit shorthand (#RGBA -> #RRGGBBAA)
    if (hex.length == 4) {
      hex = hex.split('').map((c) => '$c$c').join();
    }

    if (hex.length == 6) {
      hex = 'FF$hex';
    } else if (hex.length != 8) {
      return null;
    }

    try {
      final value = int.parse(hex, radix: 16);
      return Color(value);
    } catch (_) {
      return null;
    }
  }

  /// Converts a [Color] object to a hex string.
  ///
  /// Defaults to `#RRGGBB`. Set [includeAlpha] to true for `#AARRGGBB`.
  static String toHex(
    Color color, {
    bool leadingHashSign = true,
    bool includeAlpha = false,
  }) {
    final argb = color.toARGB32();
    final String hex;
    if (includeAlpha) {
      hex = argb.toRadixString(16).padLeft(8, '0').toUpperCase();
    } else {
      hex = (argb & 0x00FFFFFF).toRadixString(16).padLeft(6, '0').toUpperCase();
    }
    return leadingHashSign ? '#$hex' : hex;
  }

  /// Harmonizes a custom brand or semantic color with the theme's [sourceColor] (usually primary).
  ///
  /// Shifts the hue of [designColor] towards [sourceColor] by up to [maxShiftDegrees] (default: 15°),
  /// producing cohesive, balanced color aesthetics per Material 3 guidelines.
  static Color harmonize(
    Color designColor,
    Color sourceColor, {
    double maxShiftDegrees = 15.0,
  }) {
    final designHsl = HSLColor.fromColor(designColor);
    final sourceHsl = HSLColor.fromColor(sourceColor);

    // Calculate circular shortest distance between hues
    var diff = (sourceHsl.hue - designHsl.hue) % 360.0;
    if (diff > 180.0) {
      diff -= 360.0;
    }

    // Clamp the shift
    final shift = diff.clamp(-maxShiftDegrees, maxShiftDegrees);
    final newHue = (designHsl.hue + shift) % 360.0;

    return designHsl
        .withHue(newHue < 0 ? newHue + 360.0 : newHue)
        .toColor();
  }

  /// Lightens a color by [amount] (between 0.0 and 1.0).
  static Color lighten(Color color, [double amount = 0.1]) {
    final hsl = HSLColor.fromColor(color);
    return hsl
        .withLightness((hsl.lightness + amount).clamp(0.0, 1.0))
        .toColor();
  }

  /// Darkens a color by [amount] (between 0.0 and 1.0).
  static Color darken(Color color, [double amount = 0.1]) {
    final hsl = HSLColor.fromColor(color);
    return hsl
        .withLightness((hsl.lightness - amount).clamp(0.0, 1.0))
        .toColor();
  }

  /// Returns [Colors.white] or [Colors.black] depending on the background luminance
  /// for optimal accessibility contrast.
  static Color contrastColor(Color background) {
    return background.computeLuminance() > 0.5 ? Colors.black : Colors.white;
  }
}
