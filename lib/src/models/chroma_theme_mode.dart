/// Defines the supported theme modes for Chroma Theme.
enum ChromaThemeMode {
  /// Follows the system settings (Light or Dark).
  system,

  /// Always use Light mode.
  light,

  /// Always use Dark mode.
  dark,

  /// High contrast mode (Pure Black & High Visibility Colors).
  highContrast,

  /// AMOLED mode (Pure Black #000000 for OLED screens).
  amoled;

  /// Returns true if the mode is dark-based (dark, highContrast, amoled).
  bool get isDark {
    return this == ChromaThemeMode.dark ||
        this == ChromaThemeMode.highContrast ||
        this == ChromaThemeMode.amoled;
  }
}