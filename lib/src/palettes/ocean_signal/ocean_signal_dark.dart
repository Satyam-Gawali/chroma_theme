import 'package:flutter/material.dart';

import '../palette_scheme_helpers.dart';

/// Ocean Signal dark palette.
const Color _primarySeed = Color(0xFF23A9BD);
const Color _secondarySeed = Color(0xFFFBFC09);
const Color _tertiarySeed = Color(0xFFADDFF1);
const Color _neutralSeed = Color(0xFF122837);

// Important role colors (explicitly controlled)
const Color _surfaceColor = Color(0xFF122837);
const Color _textColor = Color(0xFFF5FCFF);
const Color _outlineColor = Color(0xFF7695A8);
const Color _outlineVariantColor = Color(0xFF3A5467);
const Color _errorColor = Color(0xFFF2B8B5);

ColorScheme oceanSignalDarkScheme() {
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
