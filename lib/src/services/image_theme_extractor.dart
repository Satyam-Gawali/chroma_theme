import 'package:flutter/material.dart';

/// Helper to extract dynamic Material 3 [ColorScheme] and primary seed colors
/// from any Flutter [ImageProvider] (network, asset, file, or memory).
class ImageThemeExtractor {
  ImageThemeExtractor._();

  /// Generates a [ColorScheme] based on the dominant colors of the given [provider].
  static Future<ColorScheme> extractScheme({
    required ImageProvider provider,
    Brightness brightness = Brightness.light,
  }) async {
    return ColorScheme.fromImageProvider(
      provider: provider,
      brightness: brightness,
    );
  }

  /// Extracts the primary seed color from the given [provider].
  static Future<Color> extractPrimarySeed({
    required ImageProvider provider,
  }) async {
    final scheme = await extractScheme(provider: provider);
    return scheme.primary;
  }
}
