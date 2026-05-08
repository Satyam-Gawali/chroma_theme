import 'package:flutter/material.dart';

import '../palette_scheme_helpers.dart';

/// Uniform Palesun high contrast palette.
///
/// Core colors:
/// - primary: #BFFC09
/// - secondary: #122837
/// - tertiary: #23A9BD
///
/// Uses strong contrast surfaces and outlines for accessibility.
const Color _primary = Color(0xFFBFFC09);
const Color _secondary = Color(0xFF122837);
const Color _tertiary = Color(0xFF23A9BD);

ColorScheme uniformPalesunHighContrastScheme() {
  return buildPaletteHighContrastScheme(
    primary: _primary,
    secondary: _secondary,
    tertiary: _tertiary,
  );
}
