import 'package:flutter/material.dart';

import '../palette_scheme_helpers.dart';

/// Raisin Caramel high contrast palette.
///
/// Core colors:
/// - primary: #C87740
/// - secondary: #2E1F26
/// - tertiary: #F2B759
///
/// Uses strong contrast surfaces and outlines for accessibility.
const Color _primary = Color(0xFFC87740);
const Color _secondary = Color(0xFF2E1F26);
const Color _tertiary = Color(0xFFF2B759);

ColorScheme raisinCaramelHighContrastScheme() {
  return buildPaletteHighContrastScheme(
    primary: _primary,
    secondary: _secondary,
    tertiary: _tertiary,
  );
}
