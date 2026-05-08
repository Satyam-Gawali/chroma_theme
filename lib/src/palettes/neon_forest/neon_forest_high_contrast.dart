import 'package:flutter/material.dart';

import '../palette_scheme_helpers.dart';

/// Neon Forest high contrast palette.
///
/// Core colors:
/// - primary: #02F5A1
/// - secondary: #CCDA47
/// - tertiary: #0A3625
///
/// Uses strong contrast surfaces and outlines for accessibility.
const Color _primary = Color(0xFF02F5A1);
const Color _secondary = Color(0xFFCCDA47);
const Color _tertiary = Color(0xFF0A3625);

ColorScheme neonForestHighContrastScheme() {
  return buildPaletteHighContrastScheme(
    primary: _primary,
    secondary: _secondary,
    tertiary: _tertiary,
  );
}
