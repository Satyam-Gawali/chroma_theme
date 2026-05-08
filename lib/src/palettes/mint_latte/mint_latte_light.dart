import 'package:flutter/material.dart';

import '../palette_scheme_helpers.dart';

/// Mint Latte light palette.
const Color _primarySeed = Color(0xFF00A19B);
const Color _secondarySeed = Color(0xFFE4DDD3);
const Color _tertiarySeed = Color(0xFF0A4A3C);
const Color _neutralSeed = Color(0xFFE4DDD3);

// Important role colors (explicitly controlled)
const Color _surfaceColor = Color(0xFFF5F1EA);
const Color _textColor = Color(0xFF1B1B1B);
const Color _outlineColor = Color(0xFF8E8B85);
const Color _outlineVariantColor = Color(0xFFD9D0C4);
const Color _errorColor = Color(0xFFB3261E);

ColorScheme mintLatteLightScheme() {
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
