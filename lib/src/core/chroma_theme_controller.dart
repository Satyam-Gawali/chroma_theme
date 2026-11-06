import 'dart:async';
import 'package:flutter/material.dart';

import '../builder/chroma_color_scheme_builder.dart';
import '../builder/chroma_theme_builder.dart';
import '../models/chroma_overrides.dart';
import '../models/chroma_palette.dart';
import '../models/chroma_seeds.dart';
import '../models/chroma_theme_mode.dart';
import '../services/theme_persistence.dart';

class ChromaThemeController extends ChangeNotifier {
  ChromaThemeMode _mode;
  ChromaPalette _palette;
  ChromaSeeds? _seeds;
  ChromaOverrides? _overrides;
  final ThemePersistence? _persistence;

  final _themeChangeController =
      StreamController<ChromaThemeController>.broadcast();

  // Cache to prevent rebuilding ThemeData needlessly
  ThemeData? _cachedThemeData;
  Brightness? _cachedBrightness;

  ChromaThemeController({
    ChromaThemeMode initialMode = ChromaThemeMode.light,
    ChromaPalette initialPalette = ChromaPalette.blue,
    ChromaSeeds? initialSeeds,
    ChromaOverrides? initialOverrides,
    ThemePersistence? persistence,
  })  : _mode = initialMode,
        _palette = initialPalette,
        _seeds = initialSeeds,
        _overrides = initialOverrides,
        _persistence = persistence {
    if (_persistence != null) {
      loadFromPersistence();
    }
  }

  // =========================
  // Getters
  // =========================

  ChromaThemeMode get mode => _mode;
  ChromaPalette get palette => _palette;
  ChromaSeeds? get seeds => _seeds;
  ChromaOverrides? get overrides => _overrides;
  ThemePersistence? get persistence => _persistence;

  /// Stream that emits whenever the theme changes.
  Stream<ChromaThemeController> get onThemeChanged =>
      _themeChangeController.stream;

  /// Resolves the current [ChromaThemeMode] to Flutter's native [ThemeMode].
  ThemeMode get flutterThemeMode {
    switch (_mode) {
      case ChromaThemeMode.system:
        return ThemeMode.system;
      case ChromaThemeMode.light:
        return ThemeMode.light;
      case ChromaThemeMode.dark:
      case ChromaThemeMode.highContrast:
      case ChromaThemeMode.amoled:
        return ThemeMode.dark;
    }
  }

  // =========================
  // Setters & Persistence
  // =========================

  void setTheme(ChromaThemeMode mode) {
    if (_mode == mode) return;
    _mode = mode;
    _invalidateCache();
    _notify();
    _persistence?.saveThemeMode(mode);
  }

  void setPalette(ChromaPalette palette) {
    if (_palette == palette) return;
    _palette = palette;
    _invalidateCache();
    _notify();
    _persistence?.savePalette(palette);
  }

  void setSeeds(ChromaSeeds? seeds) {
    _seeds = seeds;
    _invalidateCache();
    _notify();
    _persistence?.saveSeeds(seeds);
  }

  void clearSeeds() {
    _seeds = null;
    _invalidateCache();
    _notify();
    _persistence?.saveSeeds(null);
  }

  void setOverrides(ChromaOverrides? overrides) {
    _overrides = overrides;
    _invalidateCache();
    _notify();
  }

  /// Loads saved theme preferences from the configured [persistence] adapter.
  Future<void> loadFromPersistence() async {
    if (_persistence == null) return;
    final savedMode = await _persistence.loadThemeMode();
    final savedPalette = await _persistence.loadPalette();
    final savedSeeds = await _persistence.loadSeeds();

    bool changed = false;
    if (savedMode != null && savedMode != _mode) {
      _mode = savedMode;
      changed = true;
    }
    if (savedPalette != null && savedPalette != _palette) {
      _palette = savedPalette;
      changed = true;
    }
    if (savedSeeds != null && savedSeeds != _seeds) {
      _seeds = savedSeeds;
      changed = true;
    }

    if (changed) {
      _invalidateCache();
      _notify();
    }
  }

  void _invalidateCache() {
    _cachedThemeData = null;
    _cachedBrightness = null;
  }

  void _notify() {
    notifyListeners();
    if (!_themeChangeController.isClosed) {
      _themeChangeController.add(this);
    }
  }

  // =========================
  // Theme Building 🔥
  // =========================

  /// Generates the [ThemeData] for the current state.
  /// [systemBrightness] is required when mode is [ChromaThemeMode.system].
  ThemeData buildThemeData(Brightness? systemBrightness) {
    if (_cachedThemeData != null && _cachedBrightness == systemBrightness) {
      return _cachedThemeData!;
    }

    final scheme = ChromaColorSchemeBuilder.build(
      palette: _palette,
      mode: _mode,
      seeds: _seeds,
      systemBrightness: systemBrightness,
    );

    final bool effectiveDark;
    if (_mode == ChromaThemeMode.system) {
      effectiveDark = systemBrightness == Brightness.dark;
    } else {
      effectiveDark = _mode.isDark;
    }

    final themeData = ChromaThemeBuilder.build(
      scheme: scheme,
      textTheme: effectiveDark
          ? ThemeData.dark().textTheme
          : ThemeData.light().textTheme,
      overrides: _overrides,
    );

    _cachedThemeData = themeData;
    _cachedBrightness = systemBrightness;

    return themeData;
  }

  /// Builds a daytime [ThemeData] for [MaterialApp.theme].
  ThemeData buildLightThemeData() {
    final scheme = ChromaColorSchemeBuilder.build(
      palette: _palette,
      mode: ChromaThemeMode.light,
      seeds: _seeds,
    );
    return ChromaThemeBuilder.build(
      scheme: scheme,
      textTheme: ThemeData.light().textTheme,
      overrides: _overrides,
    );
  }

  /// Builds a dark [ThemeData] for [MaterialApp.darkTheme].
  /// Honors AMOLED and High-Contrast modes if active.
  ThemeData buildDarkThemeData() {
    final darkEffectiveMode = (_mode == ChromaThemeMode.amoled ||
            _mode == ChromaThemeMode.highContrast)
        ? _mode
        : ChromaThemeMode.dark;

    final scheme = ChromaColorSchemeBuilder.build(
      palette: _palette,
      mode: darkEffectiveMode,
      seeds: _seeds,
    );
    return ChromaThemeBuilder.build(
      scheme: scheme,
      textTheme: ThemeData.dark().textTheme,
      overrides: _overrides,
    );
  }

  // =========================
  // Helpers
  // =========================

  bool get isDark => _mode.isDark;
  bool isDarkEffective(Brightness? systemBrightness) {
    if (_mode == ChromaThemeMode.system) {
      return systemBrightness == Brightness.dark;
    }
    return _mode.isDark;
  }

  bool get isLight => _mode == ChromaThemeMode.light;
  bool get isHighContrast => _mode == ChromaThemeMode.highContrast;
  bool get isAmoled => _mode == ChromaThemeMode.amoled;
  bool get isSystem => _mode == ChromaThemeMode.system;
  bool get hasSeeds => _seeds != null && !_seeds!.isEmpty;

  @override
  void dispose() {
    _themeChangeController.close();
    super.dispose();
  }
}
