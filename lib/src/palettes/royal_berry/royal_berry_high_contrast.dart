import 'package:flutter/material.dart';

import '../palette_scheme_helpers.dart';

/// Royal Berry high contrast palette.
///
/// Core colors:
/// - primary: #8B004A
/// - secondary: #F2EFE7
/// - tertiary: #D89BD0
///
/// Uses strong contrast surfaces and outlines for accessibility.
const Color _primary = Color(0xFF8B004A);
const Color _secondary = Color(0xFFF2EFE7);
const Color _tertiary = Color(0xFFD89BD0);

ColorScheme royalBerryHighContrastScheme() {
  return buildPaletteHighContrastScheme(
    primary: _primary,
    secondary: _secondary,
    tertiary: _tertiary,
  );
}
