import 'package:flutter/material.dart';

import '../palette_scheme_helpers.dart';

/// Soft Ocean high contrast palette.
///
/// Core colors:
/// - primary: #ADDFF1
/// - secondary: #003152
/// - tertiary: #23A9BD
///
/// Uses strong contrast surfaces and outlines for accessibility.
const Color _primary = Color(0xFFADDFF1);
const Color _secondary = Color(0xFF003152);
const Color _tertiary = Color(0xFF23A9BD);

ColorScheme softOceanHighContrastScheme() {
  return buildPaletteHighContrastScheme(
    primary: _primary,
    secondary: _secondary,
    tertiary: _tertiary,
  );
}
