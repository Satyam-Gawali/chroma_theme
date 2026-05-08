import 'package:flutter/material.dart';

import '../palette_scheme_helpers.dart';

/// Midnight Mint dark palette.
const Color _primarySeed = Color(0xFF00A19B);
const Color _secondarySeed = Color(0xFFE4DDD3);
const Color _tertiarySeed = Color(0xFFADDFF1);
const Color _neutralSeed = Color(0xFF010310);

// Important role colors (explicitly controlled)
const Color _surfaceColor = Color(0xFF010310);
const Color _textColor = Color(0xFFF5F8F7);
const Color _outlineColor = Color(0xFF6B8395);
const Color _outlineVariantColor = Color(0xFF324455);
const Color _errorColor = Color(0xFFF2B8B5);

ColorScheme midnightMintDarkScheme() {
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
