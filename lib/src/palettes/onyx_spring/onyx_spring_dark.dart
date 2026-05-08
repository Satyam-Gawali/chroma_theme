import 'package:flutter/material.dart';

import '../palette_scheme_helpers.dart';

/// Onyx Spring dark palette.
const Color _primarySeed = Color(0xFF02F5A1);
const Color _secondarySeed = Color(0xFF07191E);
const Color _tertiarySeed = Color(0xFF023A22);
const Color _neutralSeed = Color(0xFF07191E);

// Important role colors (explicitly controlled)
const Color _surfaceColor = Color(0xFF07191E);
const Color _textColor = Color(0xFFEAFFF9);
const Color _outlineColor = Color(0xFF6A9D8D);
const Color _outlineVariantColor = Color(0xFF345247);
const Color _errorColor = Color(0xFFF2B8B5);

ColorScheme onyxSpringDarkScheme() {
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
