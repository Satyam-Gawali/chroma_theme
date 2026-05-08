import 'package:flutter/material.dart';

import '../palette_scheme_helpers.dart';

/// Midnight Chrysocolla high contrast palette.
///
/// Core colors:
/// - primary: #23A9BD
/// - secondary: #010310
/// - tertiary: #122837
///
/// Uses strong contrast surfaces and outlines for accessibility.
const Color _primary = Color(0xFF23A9BD);
const Color _secondary = Color(0xFF010310);
const Color _tertiary = Color(0xFF122837);

ColorScheme midnightChrysocollaHighContrastScheme() {
  return buildPaletteHighContrastScheme(
    primary: _primary,
    secondary: _secondary,
    tertiary: _tertiary,
  );
}
