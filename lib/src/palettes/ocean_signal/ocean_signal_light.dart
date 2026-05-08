import 'package:flutter/material.dart';

import '../palette_scheme_helpers.dart';

/// Ocean Signal light palette.
const Color _primarySeed = Color(0xFF23A9BD);
const Color _secondarySeed = Color(0xFFFBFC09);
const Color _tertiarySeed = Color(0xFFADDFF1);
const Color _neutralSeed = Color(0xFF122837);

// Important role colors (explicitly controlled)
const Color _surfaceColor = Color(0xFFF1FAFF);
const Color _textColor = Color(0xFF102028);
const Color _outlineColor = Color(0xFF6B8798);
const Color _outlineVariantColor = Color(0xFFC8D8E4);
const Color _errorColor = Color(0xFFB3261E);

ColorScheme oceanSignalLightScheme() {
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
