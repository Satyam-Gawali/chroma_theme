import 'package:flutter/material.dart';

import '../palette_scheme_helpers.dart';

/// Ice Latte dark palette.
const Color _primarySeed = Color(0xFF00A19B);
const Color _secondarySeed = Color(0xFFE4DDD3);
const Color _tertiarySeed = Color(0xFF2E1F26);
const Color _neutralSeed = Color(0xFFF5F1EA);

// Important role colors (explicitly controlled)
const Color _surfaceColor = Color(0xFF171417);
const Color _textColor = Color(0xFFF5F8F7);
const Color _outlineColor = Color(0xFF847C74);
const Color _outlineVariantColor = Color(0xFF4F4741);
const Color _errorColor = Color(0xFFF2B8B5);

ColorScheme iceLatteDarkScheme() {
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
