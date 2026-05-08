import 'package:flutter/material.dart';

import '../palette_scheme_helpers.dart';

/// Army Coral high contrast palette.
///
/// Core colors:
/// - primary: #F95C4B
/// - secondary: #171616
/// - tertiary: #FFF0BA
///
/// Uses strong contrast surfaces and outlines for accessibility.
const Color _primary = Color(0xFFF95C4B);
const Color _secondary = Color(0xFF171616);
const Color _tertiary = Color(0xFFFFF0BA);

ColorScheme armyCoralHighContrastScheme() {
  return buildPaletteHighContrastScheme(
    primary: _primary,
    secondary: _secondary,
    tertiary: _tertiary,
  );
}
