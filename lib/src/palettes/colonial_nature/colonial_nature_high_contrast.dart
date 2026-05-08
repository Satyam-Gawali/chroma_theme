import 'package:flutter/material.dart';

import '../palette_scheme_helpers.dart';

/// Colonial Nature high contrast palette.
///
/// Core colors:
/// - primary: #111808
/// - secondary: #FFF0BA
/// - tertiary: #023A22
///
/// Uses strong contrast surfaces and outlines for accessibility.
const Color _primary = Color(0xFF111808);
const Color _secondary = Color(0xFFFFF0BA);
const Color _tertiary = Color(0xFF023A22);

ColorScheme colonialNatureHighContrastScheme() {
  return buildPaletteHighContrastScheme(
    primary: _primary,
    secondary: _secondary,
    tertiary: _tertiary,
  );
}
