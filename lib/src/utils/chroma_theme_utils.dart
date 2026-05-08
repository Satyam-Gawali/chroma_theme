import 'package:flutter/material.dart';

class ChromaThemeUtils {
  ChromaThemeUtils._();

  /// Parses a hex string into a Color object.
  /// Supports formats: "#RRGGBB", "RRGGBB", "#AARRGGBB", "AARRGGBB".
  static Color? fromHex(String hexString) {
    if (hexString.isEmpty) return null;
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    
    try {
      return Color(int.parse(buffer.toString(), radix: 16));
    } catch (e) {
      return null;
    }
  }

  /// Converts a Color object to a hex string.
  static String toHex(Color color, {bool leadingHashSign = true}) {
    final hex = (color.toARGB32() & 0xFFFFFF).toRadixString(16).padLeft(6, '0').toUpperCase();
    return leadingHashSign ? '#$hex' : hex;
  }
}
