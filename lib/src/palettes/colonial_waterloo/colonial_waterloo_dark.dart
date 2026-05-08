import 'package:flutter/material.dart';

import '../palette_scheme_helpers.dart';

/// Colonial Waterloo dark palette.
const Color _primarySeed = Color(0xFFFFF0BA);
const Color _secondarySeed = Color(0xFF111808);
const Color _tertiarySeed = Color(0xFFADDFF1);
const Color _neutralSeed = Color(0xFF111808);

// Important role colors (explicitly controlled)
const Color _surfaceColor = Color(0xFF111808);
const Color _textColor = Color(0xFFF8FBEF);
const Color _outlineColor = Color(0xFF8D8463);
const Color _outlineVariantColor = Color(0xFF4E563A);
const Color _errorColor = Color(0xFFF2B8B5);

ColorScheme colonialWaterlooDarkScheme() {
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
