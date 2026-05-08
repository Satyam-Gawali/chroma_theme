import 'package:flutter/material.dart';

import '../palette_scheme_helpers.dart';

/// Khaki Slate light palette.
const Color _primarySeed = Color(0xFFF2B759);
const Color _secondarySeed = Color(0xFF0A4A3C);
const Color _tertiarySeed = Color(0xFFCCDA47);
const Color _neutralSeed = Color(0xFF0A4A3C);

// Important role colors (explicitly controlled)
const Color _surfaceColor = Color(0xFFFFF8EC);
const Color _textColor = Color(0xFF10221E);
const Color _outlineColor = Color(0xFF8F8768);
const Color _outlineVariantColor = Color(0xFFDDD5B2);
const Color _errorColor = Color(0xFFB3261E);

ColorScheme khakiSlateLightScheme() {
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
