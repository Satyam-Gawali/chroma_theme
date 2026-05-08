import 'package:flutter/material.dart';

import '../palette_scheme_helpers.dart';

/// Noir Mauve dark palette.
const Color _primarySeed = Color(0xFF003152);
const Color _secondarySeed = Color(0xFFADDFD1);
const Color _tertiarySeed = Color(0xFFD79BD2);
const Color _neutralSeed = Color(0xFF120016);

// Important role colors (explicitly controlled)
const Color _surfaceColor = Color(0xFF120016);
const Color _textColor = Color(0xFFF8EEFC);
const Color _outlineColor = Color(0xFF806B84);
const Color _outlineVariantColor = Color(0xFF4A3A4E);
const Color _errorColor = Color(0xFFF2B8B5);

ColorScheme noirMauveDarkScheme() {
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
