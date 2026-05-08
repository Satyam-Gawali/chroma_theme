import 'package:flutter/material.dart';

import '../palette_scheme_helpers.dart';

/// Uniform Palesun light palette.
const Color _primarySeed = Color(0xFFBFFC09);
const Color _secondarySeed = Color(0xFF122837);
const Color _tertiarySeed = Color(0xFF23A9BD);
const Color _neutralSeed = Color(0xFF122837);

// Important role colors (explicitly controlled)
const Color _surfaceColor = Color(0xFFFDFEF2);
const Color _textColor = Color(0xFF1A2730);
const Color _outlineColor = Color(0xFF8D9A63);
const Color _outlineVariantColor = Color(0xFFDEE7BF);
const Color _errorColor = Color(0xFFB3261E);

ColorScheme uniformPalesunLightScheme() {
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
