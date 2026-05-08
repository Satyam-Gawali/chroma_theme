import 'package:flutter/material.dart';

import '../palette_scheme_helpers.dart';

/// Black Metal dark palette.
const Color _primarySeed = Color(0xFFD89BD0);
const Color _secondarySeed = Color(0xFF010310);
const Color _tertiarySeed = Color(0xFFADDFF1);
const Color _neutralSeed = Color(0xFF010310);

// Important role colors (explicitly controlled)
const Color _surfaceColor = Color(0xFF000000);
const Color _textColor = Color(0xFFFFE8FC);
const Color _outlineColor = Color(0xFF876F8F);
const Color _outlineVariantColor = Color(0xFF4C3B50);
const Color _errorColor = Color(0xFFF2B8B5);

ColorScheme blackMetalDarkScheme() {
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
