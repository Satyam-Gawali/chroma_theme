import 'package:flutter/material.dart';

/// Mono light palette.
/// primary: #111111
/// secondary: #2E2E2E
/// tertiary: #5A5A5A
/// surface: #FFFFFF
ColorScheme monoLightScheme() {
  return const ColorScheme.light(
    primary: Color(0xFF111111),
    onPrimary: Colors.white,
    primaryContainer: Color(0xFFEAEAEA),
    onPrimaryContainer: Color(0xFF111111),
    primaryFixed: Color(0xFFDCDCDC),
    primaryFixedDim: Color(0xFFC4C4C4),
    onPrimaryFixed: Color(0xFF111111),
    onPrimaryFixedVariant: Color(0xFF333333),
    secondary: Color(0xFF2E2E2E),
    onSecondary: Colors.white,
    secondaryContainer: Color(0xFFE1E1E1),
    onSecondaryContainer: Color(0xFF1A1A1A),
    secondaryFixed: Color(0xFFE5E5E5),
    secondaryFixedDim: Color(0xFFCCCCCC),
    onSecondaryFixed: Color(0xFF1A1A1A),
    onSecondaryFixedVariant: Color(0xFF3A3A3A),
    tertiary: Color(0xFF5A5A5A),
    onTertiary: Colors.white,
    tertiaryContainer: Color(0xFFD7D7D7),
    onTertiaryContainer: Color(0xFF202020),
    tertiaryFixed: Color(0xFFEAEAEA),
    tertiaryFixedDim: Color(0xFFD4D4D4),
    onTertiaryFixed: Color(0xFF202020),
    onTertiaryFixedVariant: Color(0xFF404040),
    error: Color(0xFFB3261E),
    onError: Colors.white,
    errorContainer: Color(0xFFF9DEDC),
    onErrorContainer: Color(0xFF410E0B),
    surface: Color(0xFFFFFFFF),
    onSurface: Color(0xFF111111),
    surfaceDim: Color(0xFFEDEDED),
    surfaceBright: Color(0xFFFFFFFF),
    surfaceContainerLowest: Color(0xFFFFFFFF),
    surfaceContainerLow: Color(0xFFF6F6F6),
    surfaceContainer: Color(0xFFEFEFEF),
    surfaceContainerHigh: Color(0xFFE7E7E7),
    surfaceContainerHighest: Color(0xFFDCDCDC),
    onSurfaceVariant: Color(0xFF4A4A4A),
    outline: Color(0xFF767676),
    outlineVariant: Color(0xFFC7C7C7),
    shadow: Colors.black,
    scrim: Colors.black,
    inverseSurface: Color(0xFF2A2A2A),
    onInverseSurface: Color(0xFFF5F5F5),
    inversePrimary: Color(0xFFD6D6D6),
    surfaceTint: Color(0xFF111111),
  );
}
