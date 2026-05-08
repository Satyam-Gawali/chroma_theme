import 'package:flutter/material.dart';

import '../palette_scheme_helpers.dart';

/// Black Metal high contrast palette.
///
/// Core colors:
/// - primary: #D89BD0
/// - secondary: #010310
/// - tertiary: #ADDFF1
///
/// Uses strong contrast surfaces and outlines for accessibility.
const Color _primary = Color(0xFFD89BD0);
const Color _secondary = Color(0xFF010310);
const Color _tertiary = Color(0xFFADDFF1);

ColorScheme blackMetalHighContrastScheme() {
  return buildPaletteHighContrastScheme(
    primary: _primary,
    secondary: _secondary,
    tertiary: _tertiary,
  );
}
