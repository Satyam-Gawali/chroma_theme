import 'package:flutter/material.dart';

import '../palette_scheme_helpers.dart';

/// Soft Mauve dark palette.
const Color _primarySeed = Color(0xFFD89BD0);
const Color _secondarySeed = Color(0xFF000000);
const Color _tertiarySeed = Color(0xFFF2EFE7);
const Color _neutralSeed = Color(0xFFF7D6F0);

// Important role colors (explicitly controlled)
const Color _surfaceColor = Color(0xFF1A1018);
const Color _textColor = Color(0xFFFBEFFE);
const Color _outlineColor = Color(0xFF857182);
const Color _outlineVariantColor = Color(0xFF4E3D4A);
const Color _errorColor = Color(0xFFF2B8B5);

ColorScheme softMauveDarkScheme() {
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
