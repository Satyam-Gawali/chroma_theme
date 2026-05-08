import 'package:flutter/material.dart';

import '../palette_scheme_helpers.dart';

/// Raisin Caramel light palette.
const Color _primarySeed = Color(0xFFC87740);
const Color _secondarySeed = Color(0xFF2E1F26);
const Color _tertiarySeed = Color(0xFFF2B759);
const Color _neutralSeed = Color(0xFF2E1F26);

// Important role colors (explicitly controlled)
const Color _surfaceColor = Color(0xFFF8EEE6);
const Color _textColor = Color(0xFF2A1A15);
const Color _outlineColor = Color(0xFF9E7C66);
const Color _outlineVariantColor = Color(0xFFE6D3C5);
const Color _errorColor = Color(0xFFB3261E);

ColorScheme raisinCaramelLightScheme() {
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
