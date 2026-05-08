import 'package:flutter/material.dart';

import '../palette_scheme_helpers.dart';

/// Khaki Slate high contrast palette.
///
/// Core colors:
/// - primary: #F2B759
/// - secondary: #0A4A3C
/// - tertiary: #CCDA47
///
/// Uses strong contrast surfaces and outlines for accessibility.
const Color _primary = Color(0xFFF2B759);
const Color _secondary = Color(0xFF0A4A3C);
const Color _tertiary = Color(0xFFCCDA47);

ColorScheme khakiSlateHighContrastScheme() {
  return buildPaletteHighContrastScheme(
    primary: _primary,
    secondary: _secondary,
    tertiary: _tertiary,
  );
}
