import 'package:flutter/material.dart';

import '../palette_scheme_helpers.dart';

/// Emerald high contrast palette.
///
/// Core colors:
/// - primary: #2E7D32
/// - secondary: #81C784
/// - tertiary: #1B5E20
///
/// Uses strong contrast surfaces and outlines for accessibility.
const Color _primary = Color(0xFF2E7D32);
const Color _secondary = Color(0xFF81C784);
const Color _tertiary = Color(0xFF1B5E20);

ColorScheme emeraldHighContrastScheme() {
  return buildPaletteHighContrastScheme(
    primary: _primary,
    secondary: _secondary,
    tertiary: _tertiary,
  );
}
