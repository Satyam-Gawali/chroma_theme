import 'package:flutter/material.dart';

import '../palette_scheme_helpers.dart';

/// Blue dark palette.
const Color _primarySeed = Color(0xFF1E88E5);
const Color _secondarySeed = Color(0xFF64B5F6);
const Color _tertiarySeed = Color(0xFF1565C0);
const Color _neutralSeed = Color(0xFFEAF4FF);

// Important role colors (explicitly controlled)
const Color _surfaceColor = Color(0xFF0F1A24);
const Color _textColor = Color(0xFFECF3FF);
const Color _outlineColor = Color(0xFF6E8399);
const Color _outlineVariantColor = Color(0xFF38495B);
const Color _errorColor = Color(0xFFF2B8B5);

ColorScheme blueDarkScheme() {
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
