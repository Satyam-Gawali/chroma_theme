import 'package:flutter/material.dart';

import '../palette_scheme_helpers.dart';

/// Emerald Road high contrast palette.
///
/// Core colors:
/// - primary: #023A22
/// - secondary: #A9CDA7
/// - tertiary: #CCDA47
///
/// Uses strong contrast surfaces and outlines for accessibility.
const Color _primary = Color(0xFF023A22);
const Color _secondary = Color(0xFFA9CDA7);
const Color _tertiary = Color(0xFFCCDA47);

ColorScheme emeraldRoadHighContrastScheme() {
  return buildPaletteHighContrastScheme(
    primary: _primary,
    secondary: _secondary,
    tertiary: _tertiary,
  );
}
