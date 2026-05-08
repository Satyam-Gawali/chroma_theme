import '../models/chroma_theme_mode.dart';
import '../models/chroma_palette.dart';
import '../models/chroma_seeds.dart';

/// An abstract interface for persisting [ChromaTheme] state.
/// Developers can implement this using SharedPreferences, Hive, Isar, etc., 
/// keeping the core package decoupled and native-dependency free.
abstract class ThemePersistence {
  /// Save the current theme mode.
  Future<void> saveThemeMode(ChromaThemeMode mode);

  /// Load the saved theme mode.
  Future<ChromaThemeMode?> loadThemeMode();

  /// Save the current palette.
  Future<void> savePalette(ChromaPalette palette);

  /// Load the saved palette.
  Future<ChromaPalette?> loadPalette();

  /// Save the custom seeds. If [seeds] is null, it should clear the saved seeds.
  Future<void> saveSeeds(ChromaSeeds? seeds);

  /// Load the saved custom seeds.
  Future<ChromaSeeds?> loadSeeds();
}
