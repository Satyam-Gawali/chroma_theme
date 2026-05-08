import 'package:flutter/material.dart';

import '../palette_scheme_helpers.dart';

/// Blue high contrast palette.
///
/// Core colors:
/// - primary: #1E88E5
/// - secondary: #64B5F6
/// - tertiary: #1565C0
///
/// Uses strong contrast surfaces and outlines for accessibility.
const Color _primary = Color(0xFF1E88E5);
const Color _secondary = Color(0xFF64B5F6);
const Color _tertiary = Color(0xFF1565C0);

ColorScheme blueHighContrastScheme() {
  return buildPaletteHighContrastScheme(
    primary: _primary,
    secondary: _secondary,
    tertiary: _tertiary,
  );
}
