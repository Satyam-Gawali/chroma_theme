import 'package:flutter/material.dart';
import '../../chroma_theme.dart';

/// Extension on [BuildContext] to provide quick access to ChromaTheme properties.
/// This drastically improves Developer Experience (DX).
extension ChromaThemeExtension on BuildContext {
  /// Gets the [ChromaThemeController] for changing theme modes, palettes, and seeds.
  ChromaThemeController get chroma => ChromaTheme.of(this);

  /// Gets the current Material 3 [ColorScheme] active in the theme.
  ColorScheme get chromaColors => Theme.of(this).colorScheme;

  /// Gets the current Material 3 [TextTheme] active in the theme.
  TextTheme get chromaText => Theme.of(this).textTheme;

  /// Gets the Material 3 tonal palettes (shades 0-100) for the current theme colors.
  ChromaTones get chromaTones => ChromaTones.generate(chromaColors);

  /// Checks if the current mode is dark (including high contrast, amoled).
  bool get isDarkMode => chroma.isDarkEffective(Theme.of(this).brightness);
}
