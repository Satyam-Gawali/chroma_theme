import '../models/chroma_palette.dart';
import '../models/chroma_seeds.dart';
import '../models/chroma_theme_mode.dart';

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

/// A lightweight, in-memory implementation of [ThemePersistence] useful for testing
/// and ephemeral session state.
class InMemoryThemePersistence implements ThemePersistence {
  ChromaThemeMode? _mode;
  ChromaPalette? _palette;
  ChromaSeeds? _seeds;

  InMemoryThemePersistence({
    ChromaThemeMode? initialMode,
    ChromaPalette? initialPalette,
    ChromaSeeds? initialSeeds,
  })  : _mode = initialMode,
        _palette = initialPalette,
        _seeds = initialSeeds;

  @override
  Future<ChromaThemeMode?> loadThemeMode() async => _mode;

  @override
  Future<void> saveThemeMode(ChromaThemeMode mode) async {
    _mode = mode;
  }

  @override
  Future<ChromaPalette?> loadPalette() async => _palette;

  @override
  Future<void> savePalette(ChromaPalette palette) async {
    _palette = palette;
  }

  @override
  Future<ChromaSeeds?> loadSeeds() async => _seeds;

  @override
  Future<void> saveSeeds(ChromaSeeds? seeds) async {
    _seeds = seeds;
  }
}
