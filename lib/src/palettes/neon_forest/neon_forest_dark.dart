import 'package:flutter/material.dart';

import '../palette_scheme_helpers.dart';

/// Neon Forest dark palette.
const Color _primarySeed = Color(0xFF02F5A1);
const Color _secondarySeed = Color(0xFFCCDA47);
const Color _tertiarySeed = Color(0xFF0A3625);
const Color _neutralSeed = Color(0xFF07191E);

// Important role colors (explicitly controlled)
const Color _surfaceColor = Color(0xFF07191E);
const Color _textColor = Color(0xFFE8FFF7);
const Color _outlineColor = Color(0xFF6A9D8C);
const Color _outlineVariantColor = Color(0xFF315247);
const Color _errorColor = Color(0xFFF2B8B5);

ColorScheme neonForestDarkScheme() {
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
