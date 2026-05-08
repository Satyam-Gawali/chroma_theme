import 'package:flutter/material.dart';

/// Mono dark palette.
/// primary: #E8E8E8
/// secondary: #C8C8C8
/// tertiary: #A8A8A8
/// surface: #0F0F0F
ColorScheme monoDarkScheme() {
  return const ColorScheme.dark(
    primary: Color(0xFFE8E8E8),
    onPrimary: Color(0xFF121212),
    primaryContainer: Color(0xFF2A2A2A),
    onPrimaryContainer: Color(0xFFECECEC),
    secondary: Color(0xFFC8C8C8),
    onSecondary: Color(0xFF1A1A1A),
    secondaryContainer: Color(0xFF333333),
    onSecondaryContainer: Color(0xFFE2E2E2),
    tertiary: Color(0xFFA8A8A8),
    onTertiary: Color(0xFF1F1F1F),
    tertiaryContainer: Color(0xFF3D3D3D),
    onTertiaryContainer: Color(0xFFDCDCDC),
    error: Color(0xFFF2B8B5),
    onError: Color(0xFF601410),
    errorContainer: Color(0xFF8C1D18),
    onErrorContainer: Color(0xFFF9DEDC),
    surface: Color(0xFF0F0F0F),
    onSurface: Color(0xFFECECEC),
    surfaceContainerLowest: Color(0xFF090909),
    surfaceContainerLow: Color(0xFF141414),
    surfaceContainer: Color(0xFF1B1B1B),
    surfaceContainerHigh: Color(0xFF232323),
    surfaceContainerHighest: Color(0xFF2B2B2B),
    onSurfaceVariant: Color(0xFFC5C5C5),
    outline: Color(0xFF8F8F8F),
    outlineVariant: Color(0xFF4A4A4A),
    shadow: Colors.black,
    scrim: Colors.black,
    inverseSurface: Color(0xFFE8E8E8),
    onInverseSurface: Color(0xFF1F1F1F),
    inversePrimary: Color(0xFF444444),
    surfaceTint: Color(0xFFE8E8E8),
  );
}
