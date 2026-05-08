import 'package:flutter/material.dart';

import '../palette_scheme_helpers.dart';

/// Midnight Mint light palette.
const Color _primarySeed = Color(0xFF00A19B);
const Color _secondarySeed = Color(0xFFE4DDD3);
const Color _tertiarySeed = Color(0xFFADDFF1);
const Color _neutralSeed = Color(0xFF010310);

// Important role colors (explicitly controlled)
const Color _surfaceColor = Color(0xFFF5F8F7);
const Color _textColor = Color(0xFF1A1D2A);
const Color _outlineColor = Color(0xFF68808E);
const Color _outlineVariantColor = Color(0xFFC6D5E4);
const Color _errorColor = Color(0xFFB3261E);

ColorScheme midnightMintLightScheme() {
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
