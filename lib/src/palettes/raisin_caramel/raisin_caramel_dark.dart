import 'package:flutter/material.dart';

import '../palette_scheme_helpers.dart';

/// Raisin Caramel dark palette.
const Color _primarySeed = Color(0xFFC87740);
const Color _secondarySeed = Color(0xFF2E1F26);
const Color _tertiarySeed = Color(0xFFF2B759);
const Color _neutralSeed = Color(0xFF2E1F26);

// Important role colors (explicitly controlled)
const Color _surfaceColor = Color(0xFF1A1217);
const Color _textColor = Color(0xFFFFF4EA);
const Color _outlineColor = Color(0xFF8E6E5C);
const Color _outlineVariantColor = Color(0xFF4E3A30);
const Color _errorColor = Color(0xFFF2B8B5);

ColorScheme raisinCaramelDarkScheme() {
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
