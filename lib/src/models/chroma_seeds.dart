import 'package:flutter/material.dart';

/// ChromaSeeds defines optional seed colors for generating a ColorScheme.
///
/// Adaptive system:
/// - 1 color → full theme auto generated
/// - multiple colors → selective overrides
///
/// Surface Strategy:
/// - Set [neutral] alone → auto adapts to light/dark brightness
/// - Set [neutralLight] and/or [neutralDark] → explicit control per mode
/// - Mode-specific overrides take priority over generic [neutral]
///
/// Priority:
/// seeds > palette > default
class ChromaSeeds {
  /// Main brand color (REQUIRED fallback base)
  final Color? primary;

  /// Less prominent accent
  final Color? secondary;

  /// Accent / contrast color
  final Color? tertiary;

  /// Surface / background base (auto adapts to brightness)
  final Color? neutral;

  /// Explicit surface seed for LIGHT mode only.
  /// Takes priority over [neutral] when brightness is light.
  final Color? neutralLight;

  /// Explicit surface seed for DARK mode only.
  /// Takes priority over [neutral] when brightness is dark.
  final Color? neutralDark;

  /// Surface variant (cards, borders, etc.)
  final Color? neutralVariant;

  /// Optional advanced overrides
  final Color? error;
  final Color? inverse;

  const ChromaSeeds({
    this.primary,
    this.secondary,
    this.tertiary,
    this.neutral,
    this.neutralLight,
    this.neutralDark,
    this.neutralVariant,
    this.error,
    this.inverse,
  });

  /// Helper: check if empty
  bool get isEmpty =>
      primary == null &&
      secondary == null &&
      tertiary == null &&
      neutral == null &&
      neutralLight == null &&
      neutralDark == null &&
      neutralVariant == null &&
      error == null &&
      inverse == null;

  /// Resolves the correct neutral seed for the given brightness.
  /// Priority: mode-specific (neutralLight/neutralDark) > generic (neutral) > null
  Color? resolveNeutral(Brightness brightness) {
    if (brightness == Brightness.light && neutralLight != null) {
      return neutralLight;
    }
    if (brightness == Brightness.dark && neutralDark != null) {
      return neutralDark;
    }
    return neutral;
  }

  /// Copy with support
  ChromaSeeds copyWith({
    Color? primary,
    Color? secondary,
    Color? tertiary,
    Color? neutral,
    Color? neutralLight,
    Color? neutralDark,
    Color? neutralVariant,
    Color? error,
    Color? inverse,
  }) {
    return ChromaSeeds(
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
      tertiary: tertiary ?? this.tertiary,
      neutral: neutral ?? this.neutral,
      neutralLight: neutralLight ?? this.neutralLight,
      neutralDark: neutralDark ?? this.neutralDark,
      neutralVariant: neutralVariant ?? this.neutralVariant,
      error: error ?? this.error,
      inverse: inverse ?? this.inverse,
    );
  }
}