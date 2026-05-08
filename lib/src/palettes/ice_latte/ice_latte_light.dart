import 'package:flutter/material.dart';

import '../palette_scheme_helpers.dart';

/// Ice Latte light palette.
const Color _primarySeed = Color(0xFF00A19B);
const Color _secondarySeed = Color(0xFFE4DDD3);
const Color _tertiarySeed = Color(0xFF2E1F26);
const Color _neutralSeed = Color(0xFFF5F1EA);

// Important role colors (explicitly controlled)
const Color _surfaceColor = Color(0xFFFFFCF7);
const Color _textColor = Color(0xFF1B1B1B);
const Color _outlineColor = Color(0xFF9A9288);
const Color _outlineVariantColor = Color(0xFFE1D9CF);
const Color _errorColor = Color(0xFFB3261E);

ColorScheme iceLatteLightScheme() {
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
