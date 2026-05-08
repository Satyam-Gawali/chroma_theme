import 'package:flutter/material.dart';

import '../palette_scheme_helpers.dart';

/// Emerald Road light palette.
const Color _primarySeed = Color(0xFF023A22);
const Color _secondarySeed = Color(0xFFA9CDA7);
const Color _tertiarySeed = Color(0xFFCCDA47);
const Color _neutralSeed = Color(0xFF07191E);

// Important role colors (explicitly controlled)
const Color _surfaceColor = Color(0xFFF4FFF6);
const Color _textColor = Color(0xFF1B2A1F);
const Color _outlineColor = Color(0xFF6B8674);
const Color _outlineVariantColor = Color(0xFFC7DCCF);
const Color _errorColor = Color(0xFFB3261E);

ColorScheme emeraldRoadLightScheme() {
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
