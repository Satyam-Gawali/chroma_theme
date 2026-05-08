import 'package:flutter/material.dart';

import '../palette_scheme_helpers.dart';

/// Army Coral dark palette.
const Color _primarySeed = Color(0xFFF95C4B);
const Color _secondarySeed = Color(0xFF171616);
const Color _tertiarySeed = Color(0xFFFFF0BA);
const Color _neutralSeed = Color(0xFF171616);

// Important role colors (explicitly controlled)
const Color _surfaceColor = Color(0xFF111111);
const Color _textColor = Color(0xFFFFF4F2);
const Color _outlineColor = Color(0xFF8A6F6A);
const Color _outlineVariantColor = Color(0xFF4E3A37);
const Color _errorColor = Color(0xFFF2B8B5);

ColorScheme armyCoralDarkScheme() {
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
