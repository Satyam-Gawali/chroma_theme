import 'package:flutter/material.dart';

Color _softenNeutralSeed(Color color, Brightness brightness) {
  final hsl = HSLColor.fromColor(color);
  final toned = hsl.withSaturation((hsl.saturation * 0.35).clamp(0.0, 1.0));

  if (brightness == Brightness.light) {
    return Color.alphaBlend(
      Colors.white.withValues(alpha: 0.72),
      toned.toColor(),
    );
  }

  return Color.alphaBlend(
    Colors.black.withValues(alpha: 0.50),
    toned.toColor(),
  );
}

ColorScheme buildPaletteScheme({
  required Brightness brightness,
  required Color primarySeed,
  required Color secondarySeed,
  required Color tertiarySeed,
  required Color neutralSeed,
  Color? surfaceOverride,
  Color? onSurfaceOverride,
  Color? outlineOverride,
  Color? outlineVariantOverride,
  Color? errorOverride,
  Color? inverseSurfaceOverride,
  Color? onInverseSurfaceOverride,
}) {
  final primary = ColorScheme.fromSeed(
    seedColor: primarySeed,
    brightness: brightness,
  );
  final secondary = ColorScheme.fromSeed(
    seedColor: secondarySeed,
    brightness: brightness,
  );
  final tertiary = ColorScheme.fromSeed(
    seedColor: tertiarySeed,
    brightness: brightness,
  );
  final neutral = ColorScheme.fromSeed(
    seedColor: _softenNeutralSeed(neutralSeed, brightness),
    brightness: brightness,
  );
  final error = ColorScheme.fromSeed(
    seedColor: const Color(0xFFB3261E),
    brightness: brightness,
  );

  return primary.copyWith(
    primary: primary.primary,
    onPrimary: primary.onPrimary,
    primaryContainer: primary.primaryContainer,
    onPrimaryContainer: primary.onPrimaryContainer,
    primaryFixed: primary.primaryFixed,
    primaryFixedDim: primary.primaryFixedDim,
    onPrimaryFixed: primary.onPrimaryFixed,
    onPrimaryFixedVariant: primary.onPrimaryFixedVariant,
    secondary: secondary.primary,
    onSecondary: secondary.onPrimary,
    secondaryContainer: secondary.primaryContainer,
    onSecondaryContainer: secondary.onPrimaryContainer,
    secondaryFixed: secondary.primaryFixed,
    secondaryFixedDim: secondary.primaryFixedDim,
    onSecondaryFixed: secondary.onPrimaryFixed,
    onSecondaryFixedVariant: secondary.onPrimaryFixedVariant,
    tertiary: tertiary.primary,
    onTertiary: tertiary.onPrimary,
    tertiaryContainer: tertiary.primaryContainer,
    onTertiaryContainer: tertiary.onPrimaryContainer,
    tertiaryFixed: tertiary.primaryFixed,
    tertiaryFixedDim: tertiary.primaryFixedDim,
    onTertiaryFixed: tertiary.onPrimaryFixed,
    onTertiaryFixedVariant: tertiary.onPrimaryFixedVariant,
    error: errorOverride ?? error.error,
    onError: error.onError,
    errorContainer: error.errorContainer,
    onErrorContainer: error.onErrorContainer,
    surface: surfaceOverride ?? neutral.surface,
    onSurface: onSurfaceOverride ?? neutral.onSurface,
    onSurfaceVariant: neutral.onSurfaceVariant,
    surfaceDim: neutral.surfaceDim,
    surfaceBright: neutral.surfaceBright,
    surfaceContainerLowest: neutral.surfaceContainerLowest,
    surfaceContainerLow: neutral.surfaceContainerLow,
    surfaceContainer: neutral.surfaceContainer,
    surfaceContainerHigh: neutral.surfaceContainerHigh,
    surfaceContainerHighest: neutral.surfaceContainerHighest,
    surfaceTint: primary.surfaceTint,
    inverseSurface: inverseSurfaceOverride ?? neutral.inverseSurface,
    onInverseSurface: onInverseSurfaceOverride ?? neutral.onInverseSurface,
    inversePrimary: primary.inversePrimary,
    outline: outlineOverride ?? neutral.outline,
    outlineVariant: outlineVariantOverride ?? neutral.outlineVariant,
    shadow: neutral.shadow,
    scrim: neutral.scrim,
  );
}

ColorScheme buildPaletteHighContrastScheme({
  required Color primary,
  required Color secondary,
  required Color tertiary,
}) {
  return ColorScheme.fromSeed(
    seedColor: primary,
    brightness: Brightness.dark,
  ).copyWith(
    onPrimary: Colors.black,
    primaryContainer: const Color(0xFF2B2B2B),
    onPrimaryContainer: Colors.white,
    secondary: secondary,
    onSecondary: Colors.black,
    secondaryContainer: const Color(0xFF3A3A3A),
    onSecondaryContainer: Colors.white,
    tertiary: tertiary,
    onTertiary: Colors.black,
    tertiaryContainer: const Color(0xFF444444),
    onTertiaryContainer: Colors.white,
    error: const Color(0xFFFF6B6B),
    onError: Colors.black,
    errorContainer: const Color(0xFF7A0000),
    onErrorContainer: Colors.white,
    surface: Colors.black,
    onSurface: Colors.white,
    onSurfaceVariant: Colors.white70,
    surfaceDim: Colors.black,
    surfaceBright: const Color(0xFF1C1C1C),
    surfaceContainerLowest: Colors.black,
    surfaceContainerLow: const Color(0xFF050505),
    surfaceContainer: const Color(0xFF0A0A0A),
    surfaceContainerHigh: const Color(0xFF121212),
    surfaceContainerHighest: const Color(0xFF1A1A1A),
    inverseSurface: Colors.white,
    onInverseSurface: Colors.black,
    inversePrimary: Colors.black,
    surfaceTint: Colors.white,
    outline: Colors.white,
    outlineVariant: Colors.white54,
    shadow: Colors.black,
    scrim: Colors.black,
  );
}
