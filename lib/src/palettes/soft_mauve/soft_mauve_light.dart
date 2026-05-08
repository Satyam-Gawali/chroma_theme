import 'package:flutter/material.dart';

import '../palette_scheme_helpers.dart';

/// Soft Mauve light palette.
const Color _primarySeed = Color(0xFFD89BD0);
const Color _secondarySeed = Color(0xFF000000);
const Color _tertiarySeed = Color(0xFFF2EFE7);
const Color _neutralSeed = Color(0xFFF7D6F0);

// Important role colors (explicitly controlled)
const Color _surfaceColor = Color(0xFFFFF5FD);
const Color _textColor = Color(0xFF1A0F18);
const Color _outlineColor = Color(0xFF9A8394);
const Color _outlineVariantColor = Color(0xFFE6CFE1);
const Color _errorColor = Color(0xFFB3261E);

ColorScheme softMauveLightScheme() {
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
