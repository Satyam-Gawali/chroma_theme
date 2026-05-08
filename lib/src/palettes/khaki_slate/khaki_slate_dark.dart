import 'package:flutter/material.dart';

import '../palette_scheme_helpers.dart';

/// Khaki Slate dark palette.
const Color _primarySeed = Color(0xFFF2B759);
const Color _secondarySeed = Color(0xFF0A4A3C);
const Color _tertiarySeed = Color(0xFFCCDA47);
const Color _neutralSeed = Color(0xFF0A4A3C);

// Important role colors (explicitly controlled)
const Color _surfaceColor = Color(0xFF0D1C19);
const Color _textColor = Color(0xFFEEF8F2);
const Color _outlineColor = Color(0xFF6E867E);
const Color _outlineVariantColor = Color(0xFF39514A);
const Color _errorColor = Color(0xFFF2B8B5);

ColorScheme khakiSlateDarkScheme() {
  return buildPaletteScheme(
    brightness: Brightness.dark,
    primarySeed: _primarySeed,
    secondarySeed: _secondarySeed,
    tertiarySeed: _tertiarySeed,
    neutralSeed: _neutralSeed,
    surfaceOverride: _surfaceColor,
    onSurfaceOverride: _textColor,
    outlineOverride: _outlineColor,
    outlineVariantOverride: _outlineVariantColor,
    errorOverride: _errorColor,
  );
}
