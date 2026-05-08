import 'package:flutter/material.dart';

import '../palette_scheme_helpers.dart';

/// Berry Blush light palette.
const Color _primarySeed = Color(0xFF8B004A);
const Color _secondarySeed = Color(0xFFF2EFE7);
const Color _tertiarySeed = Color(0xFFADDFD1);
const Color _neutralSeed = Color(0xFFF2EFE7);

// Important role colors (explicitly controlled)
const Color _surfaceColor = Color(0xFFFAF7F1);
const Color _textColor = Color(0xFF210F18);
const Color _outlineColor = Color(0xFF9A8E93);
const Color _outlineVariantColor = Color(0xFFE2D8DB);
const Color _errorColor = Color(0xFFB3261E);

ColorScheme berryBlushLightScheme() {
  return buildPaletteScheme(
    brightness: Brightness.light,
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
