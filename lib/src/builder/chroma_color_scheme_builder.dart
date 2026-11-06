import 'package:flutter/material.dart';

import '../models/chroma_palette.dart';
import '../models/chroma_seeds.dart';
import '../models/chroma_theme_mode.dart';
import '../palettes/palette_registry.dart';

class ChromaColorSchemeBuilder {
  ChromaColorSchemeBuilder._();

  static ColorScheme build({
    required ChromaPalette palette,
    required ChromaThemeMode mode,
    ChromaSeeds? seeds,
    Brightness? systemBrightness,
  }) {
    // Resolve effective brightness
    final Brightness brightness;
    if (mode == ChromaThemeMode.system) {
      brightness = systemBrightness ?? Brightness.light;
    } else {
      brightness = mode.isDark ? Brightness.dark : Brightness.light;
    }

    final bool isHighContrast = mode == ChromaThemeMode.highContrast;
    final bool isAmoled = mode == ChromaThemeMode.amoled;

    // 🔥 1. Seeds priority (TOP PRIORITY)
    if (seeds != null && !seeds.isEmpty) {
      final scheme = _fromSeeds(seeds, brightness);

      // 🔥 If high contrast + seeds → apply contrast overrides ON TOP of seeds
      if (isHighContrast) {
        return _applyHighContrast(scheme);
      }

      // 🔥 If amoled + seeds → force pure black surface
      if (isAmoled) {
        return _applyAmoled(scheme);
      }

      return scheme;
    }

    // 🔥 2. Palette Registry (DYNAMIC)
    final entry = PaletteRegistry.get(palette);

    if (entry != null) {
      if (isHighContrast) {
        return entry.highContrast();
      }
      if (isAmoled) {
        return _applyAmoled(entry.dark());
      }
      return brightness == Brightness.dark ? entry.dark() : entry.light();
    }

    // 🔥 3. Special modes fallbacks (when no palette is found)
    if (isHighContrast) {
      return _highContrastScheme();
    }

    if (isAmoled) {
      return _amoledScheme();
    }

    // 🔥 4. Fallback (safety)
    return ColorScheme.fromSeed(
      seedColor: Colors.blue,
      brightness: brightness,
    );
  }

  // =========================
  // SPECIAL SCHEMES 🔥
  // =========================

  /// Pure high contrast scheme (no seeds active).
  static ColorScheme _highContrastScheme() {
    return const ColorScheme.dark(
      primary: Colors.white,
      onPrimary: Colors.black,
      primaryContainer: Color(0xFF1F1F1F),
      onPrimaryContainer: Colors.white,
      primaryFixed: Colors.white,
      primaryFixedDim: Color(0xFFDCDCDC),
      onPrimaryFixed: Colors.black,
      onPrimaryFixedVariant: Color(0xFF222222),
      secondary: Colors.white70,
      onSecondary: Colors.black,
      secondaryContainer: Color(0xFF2B2B2B),
      onSecondaryContainer: Colors.white,
      secondaryFixed: Colors.white70,
      secondaryFixedDim: Color(0xFFB0B0B0),
      onSecondaryFixed: Colors.black,
      onSecondaryFixedVariant: Color(0xFF222222),
      tertiary: Colors.white60,
      onTertiary: Colors.black,
      tertiaryContainer: Color(0xFF353535),
      onTertiaryContainer: Colors.white,
      tertiaryFixed: Colors.white60,
      tertiaryFixedDim: Color(0xFFA0A0A0),
      onTertiaryFixed: Colors.black,
      onTertiaryFixedVariant: Color(0xFF222222),
      surface: Colors.black,
      onSurface: Colors.white,
      surfaceDim: Colors.black,
      surfaceBright: Color(0xFF1C1C1C),
      error: Color(0xFFFF6B6B),
      onError: Colors.black,
      outline: Colors.white,
      outlineVariant: Colors.white54,
    );
  }

  /// Pure AMOLED scheme (no seeds active).
  static ColorScheme _amoledScheme() {
    return const ColorScheme.dark(
      surface: Colors.black,
      surfaceDim: Colors.black,
      surfaceBright: Color(0xFF181818),
      onSurface: Colors.white,
      surfaceContainerLowest: Colors.black,
      surfaceContainerLow: Color(0xFF050505),
      surfaceContainer: Color(0xFF0A0A0A),
      surfaceContainerHigh: Color(0xFF101010),
      surfaceContainerHighest: Color(0xFF151515),
    );
  }

  /// Apply high contrast adjustments on top of a seed-generated scheme.
  static ColorScheme _applyHighContrast(ColorScheme base) {
    return base.copyWith(
      onPrimary: Colors.black,
      onSecondary: Colors.black,
      onTertiary: Colors.black,
      surface: Colors.black,
      surfaceDim: Colors.black,
      surfaceBright: const Color(0xFF1C1C1C),
      onSurface: Colors.white,
      surfaceContainerLowest: Colors.black,
      surfaceContainerLow: const Color(0xFF0A0A0A),
      surfaceContainer: const Color(0xFF121212),
      surfaceContainerHigh: const Color(0xFF1A1A1A),
      surfaceContainerHighest: const Color(0xFF222222),
      outline: Colors.white,
      outlineVariant: Colors.white54,
      onError: Colors.black,
      inverseSurface: Colors.white,
      onInverseSurface: Colors.black,
    );
  }

  /// Apply AMOLED adjustments on top of a seed-generated scheme.
  static ColorScheme _applyAmoled(ColorScheme base) {
    return base.copyWith(
      surface: Colors.black,
      surfaceDim: Colors.black,
      surfaceBright: const Color(0xFF181818),
      surfaceContainerLowest: Colors.black,
      surfaceContainerLow: const Color(0xFF050505),
      surfaceContainer: const Color(0xFF0A0A0A),
      surfaceContainerHigh: const Color(0xFF101010),
      surfaceContainerHighest: const Color(0xFF151515),
    );
  }

  // =========================
  // SEEDS SYSTEM 🔥
  // =========================

  static ColorScheme _fromSeeds(
    ChromaSeeds seeds,
    Brightness brightness,
  ) {
    // Generate the base scheme from the primary seed color
    final base = ColorScheme.fromSeed(
      seedColor: seeds.primary ?? Colors.blue,
      brightness: brightness,
    );

    // 🔥 Smart neutral resolution:
    // - neutralLight/neutralDark → DIRECT color (exact match, user picked this specific color)
    // - neutral (generic) → fromSeed (auto-adapts tonal palette per brightness)
    final bool isDirectSurface = (brightness == Brightness.light && seeds.neutralLight != null) ||
        (brightness == Brightness.dark && seeds.neutralDark != null);

    ColorScheme? neutralScheme;
    Color? directSurface;

    if (isDirectSurface) {
      // 🎯 DIRECT mode: use the exact color the user picked
      directSurface = seeds.resolveNeutral(brightness);
    } else if (seeds.neutral != null) {
      // 🌊 AUTO mode: fromSeed generates brightness-aware palette
      neutralScheme = ColorScheme.fromSeed(
        seedColor: seeds.neutral!,
        brightness: brightness,
      );
    }

    // Same for neutralVariant
    ColorScheme? neutralVariantScheme;
    if (seeds.neutralVariant != null) {
      neutralVariantScheme = ColorScheme.fromSeed(
        seedColor: seeds.neutralVariant!,
        brightness: brightness,
      );
    }

    // Generate secondary scheme if secondary seed is provided
    ColorScheme? secondaryScheme;
    if (seeds.secondary != null) {
      secondaryScheme = ColorScheme.fromSeed(
        seedColor: seeds.secondary!,
        brightness: brightness,
      );
    }

    // Generate tertiary scheme if tertiary seed is provided
    ColorScheme? tertiaryScheme;
    if (seeds.tertiary != null) {
      tertiaryScheme = ColorScheme.fromSeed(
        seedColor: seeds.tertiary!,
        brightness: brightness,
      );
    }

    // Generate error scheme if error seed is provided
    ColorScheme? errorScheme;
    if (seeds.error != null) {
      errorScheme = ColorScheme.fromSeed(
        seedColor: seeds.error!,
        brightness: brightness,
      );
    }

    // 🧱 Resolve surface colors
    final surfaceColors = directSurface != null
        ? _directSurfaceTones(directSurface, brightness)
        : null;

    return base.copyWith(
      // 🎨 Secondary — proper on-color pairs + fixed roles
      secondary: secondaryScheme?.primary ?? base.secondary,
      onSecondary: secondaryScheme?.onPrimary ?? base.onSecondary,
      secondaryContainer: secondaryScheme?.primaryContainer ?? base.secondaryContainer,
      onSecondaryContainer: secondaryScheme?.onPrimaryContainer ?? base.onSecondaryContainer,
      secondaryFixed: secondaryScheme?.primaryFixed ?? base.secondaryFixed,
      secondaryFixedDim: secondaryScheme?.primaryFixedDim ?? base.secondaryFixedDim,
      onSecondaryFixed: secondaryScheme?.onPrimaryFixed ?? base.onSecondaryFixed,
      onSecondaryFixedVariant: secondaryScheme?.onPrimaryFixedVariant ?? base.onSecondaryFixedVariant,

      // 🎨 Tertiary — proper on-color pairs + fixed roles
      tertiary: tertiaryScheme?.primary ?? base.tertiary,
      onTertiary: tertiaryScheme?.onPrimary ?? base.onTertiary,
      tertiaryContainer: tertiaryScheme?.primaryContainer ?? base.tertiaryContainer,
      onTertiaryContainer: tertiaryScheme?.onPrimaryContainer ?? base.onTertiaryContainer,
      tertiaryFixed: tertiaryScheme?.primaryFixed ?? base.tertiaryFixed,
      tertiaryFixedDim: tertiaryScheme?.primaryFixedDim ?? base.tertiaryFixedDim,
      onTertiaryFixed: tertiaryScheme?.onPrimaryFixed ?? base.onTertiaryFixed,
      onTertiaryFixedVariant: tertiaryScheme?.onPrimaryFixedVariant ?? base.onTertiaryFixedVariant,

      // 🧱 Surfaces
      surface: surfaceColors?.surface ?? neutralScheme?.surface ?? base.surface,
      onSurface: surfaceColors?.onSurface ?? neutralScheme?.onSurface ?? base.onSurface,
      onSurfaceVariant: surfaceColors?.onSurfaceVariant ?? neutralScheme?.onSurfaceVariant ?? base.onSurfaceVariant,
      surfaceDim: surfaceColors?.surfaceDim ?? neutralScheme?.surfaceDim ?? base.surfaceDim,
      surfaceBright: surfaceColors?.surfaceBright ?? neutralScheme?.surfaceBright ?? base.surfaceBright,

      surfaceContainerLowest:
          surfaceColors?.containerLowest ?? neutralScheme?.surfaceContainerLowest ?? base.surfaceContainerLowest,
      surfaceContainerLow:
          surfaceColors?.containerLow ?? neutralScheme?.surfaceContainerLow ?? base.surfaceContainerLow,
      surfaceContainer:
          surfaceColors?.container ?? neutralScheme?.surfaceContainer ?? base.surfaceContainer,
      surfaceContainerHigh:
          surfaceColors?.containerHigh ?? neutralScheme?.surfaceContainerHigh ?? base.surfaceContainerHigh,
      surfaceContainerHighest:
          surfaceColors?.containerHighest ??
              neutralVariantScheme?.surfaceContainerHighest ??
              neutralScheme?.surfaceContainerHighest ??
              base.surfaceContainerHighest,

      // Outline
      outline: neutralScheme?.outline ?? base.outline,
      outlineVariant: neutralScheme?.outlineVariant ?? base.outlineVariant,

      // ❗ Errors — proper on-color pairs
      error: errorScheme?.error ?? base.error,
      onError: errorScheme?.onError ?? base.onError,
      errorContainer: errorScheme?.errorContainer ?? base.errorContainer,
      onErrorContainer: errorScheme?.onErrorContainer ?? base.onErrorContainer,

      // 🔄 Inverse (optional)
      inversePrimary: seeds.inverse ?? base.inversePrimary,
    );
  }

  // =========================
  // DIRECT SURFACE TONES 🎯
  // =========================

  static _SurfaceTones _directSurfaceTones(Color color, Brightness brightness) {
    final hsl = HSLColor.fromColor(color);

    if (brightness == Brightness.dark) {
      return _SurfaceTones(
        surface: color,
        onSurface: _contrastFor(color),
        onSurfaceVariant: _contrastFor(color).withValues(alpha: 0.7),
        surfaceDim: _adjustLightness(hsl, -0.04),
        surfaceBright: _adjustLightness(hsl, 0.08),
        containerLowest: _adjustLightness(hsl, -0.03),
        containerLow: _adjustLightness(hsl, 0.02),
        container: _adjustLightness(hsl, 0.05),
        containerHigh: _adjustLightness(hsl, 0.08),
        containerHighest: _adjustLightness(hsl, 0.12),
      );
    } else {
      return _SurfaceTones(
        surface: color,
        onSurface: _contrastFor(color),
        onSurfaceVariant: _contrastFor(color).withValues(alpha: 0.7),
        surfaceDim: _adjustLightness(hsl, -0.06),
        surfaceBright: _adjustLightness(hsl, 0.02),
        containerLowest: _adjustLightness(hsl, 0.03),
        containerLow: _adjustLightness(hsl, -0.02),
        container: _adjustLightness(hsl, -0.05),
        containerHigh: _adjustLightness(hsl, -0.08),
        containerHighest: _adjustLightness(hsl, -0.12),
      );
    }
  }

  static Color _adjustLightness(HSLColor hsl, double delta) {
    return hsl.withLightness((hsl.lightness + delta).clamp(0.0, 1.0)).toColor();
  }

  static Color _contrastFor(Color color) {
    return color.computeLuminance() > 0.5 ? Colors.black : Colors.white;
  }
}

class _SurfaceTones {
  final Color surface;
  final Color onSurface;
  final Color onSurfaceVariant;
  final Color surfaceDim;
  final Color surfaceBright;
  final Color containerLowest;
  final Color containerLow;
  final Color container;
  final Color containerHigh;
  final Color containerHighest;

  const _SurfaceTones({
    required this.surface,
    required this.onSurface,
    required this.onSurfaceVariant,
    required this.surfaceDim,
    required this.surfaceBright,
    required this.containerLowest,
    required this.containerLow,
    required this.container,
    required this.containerHigh,
    required this.containerHighest,
  });
}
