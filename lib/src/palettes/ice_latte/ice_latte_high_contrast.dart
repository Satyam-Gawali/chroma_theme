import 'package:flutter/material.dart';

import '../palette_scheme_helpers.dart';

/// Ice Latte high contrast palette.
///
/// Core colors:
/// - primary: #00A19B
/// - secondary: #E4DDD3
/// - tertiary: #2E1F26
///
/// Uses strong contrast surfaces and outlines for accessibility.
const Color _primary = Color(0xFF00A19B);
const Color _secondary = Color(0xFFE4DDD3);
const Color _tertiary = Color(0xFF2E1F26);

ColorScheme iceLatteHighContrastScheme() {
  return buildPaletteHighContrastScheme(
    primary: _primary,
    secondary: _secondary,
    tertiary: _tertiary,
  );
}
