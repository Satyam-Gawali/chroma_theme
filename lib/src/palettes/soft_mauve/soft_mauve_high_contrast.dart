import 'package:flutter/material.dart';

import '../palette_scheme_helpers.dart';

/// Soft Mauve high contrast palette.
///
/// Core colors:
/// - primary: #D89BD0
/// - secondary: #000000
/// - tertiary: #F2EFE7
///
/// Uses strong contrast surfaces and outlines for accessibility.
const Color _primary = Color(0xFFD89BD0);
const Color _secondary = Color(0xFF000000);
const Color _tertiary = Color(0xFFF2EFE7);

ColorScheme softMauveHighContrastScheme() {
  return buildPaletteHighContrastScheme(
    primary: _primary,
    secondary: _secondary,
    tertiary: _tertiary,
  );
}
