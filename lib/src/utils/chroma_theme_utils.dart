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
}
