import 'package:flutter/material.dart';

import '../palette_scheme_helpers.dart';

/// Ocean Signal high contrast palette.
///
/// Core colors:
/// - primary: #23A9BD
/// - secondary: #FBFC09
/// - tertiary: #ADDFF1
///
/// Uses strong contrast surfaces and outlines for accessibility.
const Color _primary = Color(0xFF23A9BD);
const Color _secondary = Color(0xFFFBFC09);
const Color _tertiary = Color(0xFFADDFF1);

ColorScheme oceanSignalHighContrastScheme() {
  return buildPaletteHighContrastScheme(
    primary: _primary,
    secondary: _secondary,
    tertiary: _tertiary,
  );
}
