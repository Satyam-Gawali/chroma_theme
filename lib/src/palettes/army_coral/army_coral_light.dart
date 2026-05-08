import 'package:flutter/material.dart';

import '../palette_scheme_helpers.dart';

/// Army Coral light palette.
const Color _primarySeed = Color(0xFFF95C4B);
const Color _secondarySeed = Color(0xFF171616);
const Color _tertiarySeed = Color(0xFFFFF0BA);
const Color _neutralSeed = Color(0xFF171616);

// Important role colors (explicitly controlled)
const Color _surfaceColor = Color(0xFFFFF5F2);
const Color _textColor = Color(0xFF261A18);
const Color _outlineColor = Color(0xFF9C7E79);
const Color _outlineVariantColor = Color(0xFFEACDCA);
const Color _errorColor = Color(0xFFB3261E);

ColorScheme armyCoralLightScheme() {
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
