import 'package:flutter/material.dart';

import '../palette_scheme_helpers.dart';

/// Blue light palette.
const Color _primarySeed = Color(0xFF1E88E5);
const Color _secondarySeed = Color(0xFF64B5F6);
const Color _tertiarySeed = Color(0xFF1565C0);
const Color _neutralSeed = Color(0xFFEAF4FF);

// Important role colors (explicitly controlled)
const Color _surfaceColor = Color(0xFFF5FAFF);
const Color _textColor = Color(0xFF0F1720);
const Color _outlineColor = Color(0xFF7A8FA8);
const Color _outlineVariantColor = Color(0xFFC9D8E8);
const Color _errorColor = Color(0xFFB3261E);

ColorScheme blueLightScheme() {
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
