import 'package:flutter/material.dart';

import '../palette_scheme_helpers.dart';

/// Royal Berry light palette.
const Color _primarySeed = Color(0xFF8B004A);
const Color _secondarySeed = Color(0xFFF2EFE7);
const Color _tertiarySeed = Color(0xFFD89BD0);
const Color _neutralSeed = Color(0xFF2B0A1B);

// Important role colors (explicitly controlled)
const Color _surfaceColor = Color(0xFFFFF2FA);
const Color _textColor = Color(0xFF261019);
const Color _outlineColor = Color(0xFF9A7D8F);
const Color _outlineVariantColor = Color(0xFFE7CDDB);
const Color _errorColor = Color(0xFFB3261E);

ColorScheme royalBerryLightScheme() {
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
