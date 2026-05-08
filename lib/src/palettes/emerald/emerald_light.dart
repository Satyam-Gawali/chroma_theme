import 'package:flutter/material.dart';

import '../palette_scheme_helpers.dart';

/// Emerald light palette.
const Color _primarySeed = Color(0xFF2E7D32);
const Color _secondarySeed = Color(0xFF81C784);
const Color _tertiarySeed = Color(0xFF1B5E20);
const Color _neutralSeed = Color(0xFFE8F5E9);

// Important role colors (explicitly controlled)
const Color _surfaceColor = Color(0xFFF4FBF4);
const Color _textColor = Color(0xFF122014);
const Color _outlineColor = Color(0xFF748E79);
const Color _outlineVariantColor = Color(0xFFC7D8CA);
const Color _errorColor = Color(0xFFB3261E);

ColorScheme emeraldLightScheme() {
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
