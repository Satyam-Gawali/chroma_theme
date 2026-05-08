import 'package:flutter/material.dart';

import '../palette_scheme_helpers.dart';

/// Colonial Waterloo high contrast palette.
///
/// Core colors:
/// - primary: #FFF0BA
/// - secondary: #111808
/// - tertiary: #ADDFF1
///
/// Uses strong contrast surfaces and outlines for accessibility.
const Color _primary = Color(0xFFFFF0BA);
const Color _secondary = Color(0xFF111808);
const Color _tertiary = Color(0xFFADDFF1);

ColorScheme colonialWaterlooHighContrastScheme() {
  return buildPaletteHighContrastScheme(
    primary: _primary,
    secondary: _secondary,
    tertiary: _tertiary,
  );
}
