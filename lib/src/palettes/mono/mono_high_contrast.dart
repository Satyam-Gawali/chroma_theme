import 'package:flutter/material.dart';

/// Mono high contrast palette.
/// Accessibility-first, max contrast surfaces and outlines.
ColorScheme monoHighContrastScheme() {
  return const ColorScheme.dark(
    primary: Colors.white,
    onPrimary: Colors.black,
    primaryContainer: Color(0xFF1F1F1F),
    onPrimaryContainer: Colors.white,
    secondary: Color(0xFFE0E0E0),
    onSecondary: Colors.black,
    secondaryContainer: Color(0xFF2B2B2B),
    onSecondaryContainer: Colors.white,
    tertiary: Color(0xFFCFCFCF),
    onTertiary: Colors.black,
    tertiaryContainer: Color(0xFF353535),
    onTertiaryContainer: Colors.white,
    error: Color(0xFFFF6B6B),
    onError: Colors.black,
    errorContainer: Color(0xFF7A0000),
    onErrorContainer: Colors.white,
    surface: Colors.black,
    onSurface: Colors.white,
    surfaceContainerLowest: Colors.black,
    surfaceContainerLow: Color(0xFF050505),
    surfaceContainer: Color(0xFF0A0A0A),
    surfaceContainerHigh: Color(0xFF121212),
    surfaceContainerHighest: Color(0xFF1A1A1A),
    onSurfaceVariant: Colors.white70,
    outline: Colors.white,
    outlineVariant: Colors.white54,
    shadow: Colors.black,
    scrim: Colors.black,
    inverseSurface: Colors.white,
    onInverseSurface: Colors.black,
    inversePrimary: Colors.black,
    surfaceTint: Colors.white,
  );
}
