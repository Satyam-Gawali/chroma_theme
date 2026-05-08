import 'package:flutter/material.dart';

import '../palette_scheme_helpers.dart';

/// Berry Blush high contrast palette.
///
/// Core colors:
/// - primary: #8B004A
/// - secondary: #F2EFE7
/// - tertiary: #ADDFD1
///
/// Uses strong contrast surfaces and outlines for accessibility.
const Color _primary = Color(0xFF8B004A);
const Color _secondary = Color(0xFFF2EFE7);
const Color _tertiary = Color(0xFFADDFD1);

ColorScheme berryBlushHighContrastScheme() {
  return buildPaletteHighContrastScheme(
    primary: _primary,
    secondary: _secondary,
    tertiary: _tertiary,
  );
}
