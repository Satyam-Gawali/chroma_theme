import 'package:flutter/material.dart';

import '../palette_scheme_helpers.dart';

/// Onyx Spring light palette.
const Color _primarySeed = Color(0xFF02F5A1);
const Color _secondarySeed = Color(0xFF07191E);
const Color _tertiarySeed = Color(0xFF023A22);
const Color _neutralSeed = Color(0xFF07191E);

// Important role colors (explicitly controlled)
const Color _surfaceColor = Color(0xFFECFFF8);
const Color _textColor = Color(0xFF10231D);
const Color _outlineColor = Color(0xFF5F8D80);
const Color _outlineVariantColor = Color(0xFFC3DED4);
const Color _errorColor = Color(0xFFB3261E);

ColorScheme onyxSpringLightScheme() {
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
