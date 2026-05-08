import 'package:flutter/material.dart';

import '../palette_scheme_helpers.dart';

/// Noir Mauve high contrast palette.
///
/// Core colors:
/// - primary: #003152
/// - secondary: #ADDFD1
/// - tertiary: #D79BD2
///
/// Uses strong contrast surfaces and outlines for accessibility.
const Color _primary = Color(0xFF003152);
const Color _secondary = Color(0xFFADDFD1);
const Color _tertiary = Color(0xFFD79BD2);

ColorScheme noirMauveHighContrastScheme() {
  return buildPaletteHighContrastScheme(
    primary: _primary,
    secondary: _secondary,
    tertiary: _tertiary,
  );
}
