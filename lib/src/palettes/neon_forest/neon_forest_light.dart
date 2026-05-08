import 'package:flutter/material.dart';

import '../palette_scheme_helpers.dart';

/// Neon Forest light palette.
const Color _primarySeed = Color(0xFF02F5A1);
const Color _secondarySeed = Color(0xFFCCDA47);
const Color _tertiarySeed = Color(0xFF0A3625);
const Color _neutralSeed = Color(0xFF07191E);

// Important role colors (explicitly controlled)
const Color _surfaceColor = Color(0xFFEFFFF8);
const Color _textColor = Color(0xFF0D201C);
const Color _outlineColor = Color(0xFF5F8A7C);
const Color _outlineVariantColor = Color(0xFFBFDCD1);
const Color _errorColor = Color(0xFFB3261E);

ColorScheme neonForestLightScheme() {
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
