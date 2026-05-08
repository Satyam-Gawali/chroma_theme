import 'package:flutter/material.dart';

import '../palette_scheme_helpers.dart';

/// Onyx Spring high contrast palette.
///
/// Core colors:
/// - primary: #02F5A1
/// - secondary: #07191E
/// - tertiary: #023A22
///
/// Uses strong contrast surfaces and outlines for accessibility.
const Color _primary = Color(0xFF02F5A1);
const Color _secondary = Color(0xFF07191E);
const Color _tertiary = Color(0xFF023A22);

ColorScheme onyxSpringHighContrastScheme() {
  return buildPaletteHighContrastScheme(
    primary: _primary,
    secondary: _secondary,
    tertiary: _tertiary,
  );
}
