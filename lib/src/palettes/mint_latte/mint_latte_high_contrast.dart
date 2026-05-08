import 'package:flutter/material.dart';

import '../palette_scheme_helpers.dart';

/// Mint Latte high contrast palette.
///
/// Core colors:
/// - primary: #00A19B
/// - secondary: #E4DDD3
/// - tertiary: #0A4A3C
///
/// Uses strong contrast surfaces and outlines for accessibility.
const Color _primary = Color(0xFF00A19B);
const Color _secondary = Color(0xFFE4DDD3);
const Color _tertiary = Color(0xFF0A4A3C);

ColorScheme mintLatteHighContrastScheme() {
  return buildPaletteHighContrastScheme(
    primary: _primary,
    secondary: _secondary,
    tertiary: _tertiary,
  );
}
