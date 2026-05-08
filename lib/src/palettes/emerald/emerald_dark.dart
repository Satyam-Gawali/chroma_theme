import 'package:flutter/material.dart';

import '../palette_scheme_helpers.dart';

/// Emerald dark palette.
const Color _primarySeed = Color(0xFF2E7D32);
const Color _secondarySeed = Color(0xFF81C784);
const Color _tertiarySeed = Color(0xFF1B5E20);
const Color _neutralSeed = Color(0xFFE8F5E9);

// Important role colors (explicitly controlled)
const Color _surfaceColor = Color(0xFF0E1A12);
const Color _textColor = Color(0xFFEBF7EE);
const Color _outlineColor = Color(0xFF728A78);
const Color _outlineVariantColor = Color(0xFF3A4D3F);
const Color _errorColor = Color(0xFFF2B8B5);

ColorScheme emeraldDarkScheme() {
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
