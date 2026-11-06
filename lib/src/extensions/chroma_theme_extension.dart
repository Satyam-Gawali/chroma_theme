import 'package:flutter/material.dart';
import '../core/chroma_theme_controller.dart';
import '../core/chroma_theme_widget.dart';
import '../models/chroma_tones.dart';

/// Extension on [BuildContext] to provide quick access to ChromaTheme properties.
/// This drastically improves Developer Experience (DX).
extension ChromaThemeExtension on BuildContext {
  /// Gets the [ChromaThemeController] for changing theme modes, palettes, and seeds.
  ChromaThemeController get chroma => ChromaTheme.of(this);

  /// Gets the current Material 3 [ColorScheme] active in the theme.
  ColorScheme get chromaColors => Theme.of(this).colorScheme;

  /// Gets the current Material 3 [TextTheme] active in the theme.
  TextTheme get chromaText => Theme.of(this).textTheme;

  /// Gets the primary color of the active theme.
  Color get chromaPrimary => chromaColors.primary;

  /// Gets the secondary accent color of the active theme.
  Color get chromaSecondary => chromaColors.secondary;

  /// Gets the surface / background color of the active theme.
  Color get chromaSurface => chromaColors.surface;

  /// Gets the Material 3 tonal palettes (shades 0-100) for the current theme colors.
  ChromaTones get chromaTones => ChromaTones.generate(chromaColors);

  /// Checks if the current mode is dark (including high contrast, amoled).
  bool get isDarkMode => chroma.isDarkEffective(Theme.of(this).brightness);

  /// Toggles between light and dark modes.
  void toggleTheme({bool supportAmoled = false}) =>
      chroma.toggleThemeMode(supportAmoled: supportAmoled);
}
