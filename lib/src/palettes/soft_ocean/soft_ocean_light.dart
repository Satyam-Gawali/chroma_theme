import 'package:flutter/material.dart';

import '../palette_scheme_helpers.dart';

/// Soft Ocean light palette.
const Color _primarySeed = Color(0xFFADDFF1);
const Color _secondarySeed = Color(0xFF003152);
const Color _tertiarySeed = Color(0xFF23A9BD);
const Color _neutralSeed = Color(0xFFEAF8FD);

// Important role colors (explicitly controlled)
const Color _surfaceColor = Color(0xFFF7FDFF);
const Color _textColor = Color(0xFF102028);
const Color _outlineColor = Color(0xFF7F95A2);
const Color _outlineVariantColor = Color(0xFFD5E4EC);
const Color _errorColor = Color(0xFFB3261E);

ColorScheme softOceanLightScheme() {
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
