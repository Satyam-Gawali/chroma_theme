import 'package:flutter/material.dart';

import '../palette_scheme_helpers.dart';

/// Colonial Nature light palette.
const Color _primarySeed = Color(0xFF111808);
const Color _secondarySeed = Color(0xFFFFF0BA);
const Color _tertiarySeed = Color(0xFF023A22);
const Color _neutralSeed = Color(0xFFFFF8E1);

// Important role colors (explicitly controlled)
const Color _surfaceColor = Color(0xFFFFFDF6);
const Color _textColor = Color(0xFF1D2418);
const Color _outlineColor = Color(0xFF90886B);
const Color _outlineVariantColor = Color(0xFFE5DDBB);
const Color _errorColor = Color(0xFFB3261E);

ColorScheme colonialNatureLightScheme() {
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
