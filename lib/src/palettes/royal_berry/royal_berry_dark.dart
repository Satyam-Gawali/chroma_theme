import 'package:flutter/material.dart';

import '../palette_scheme_helpers.dart';

/// Royal Berry dark palette.
const Color _primarySeed = Color(0xFF8B004A);
const Color _secondarySeed = Color(0xFFF2EFE7);
const Color _tertiarySeed = Color(0xFFD89BD0);
const Color _neutralSeed = Color(0xFF2B0A1B);

// Important role colors (explicitly controlled)
const Color _surfaceColor = Color(0xFF14040D);
const Color _textColor = Color(0xFFFFF2FA);
const Color _outlineColor = Color(0xFF8C7082);
const Color _outlineVariantColor = Color(0xFF4F3443);
const Color _errorColor = Color(0xFFF2B8B5);

ColorScheme royalBerryDarkScheme() {
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
