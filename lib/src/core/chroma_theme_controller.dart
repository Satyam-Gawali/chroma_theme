import 'dart:async';
import 'package:flutter/material.dart';

import '../builder/chroma_color_scheme_builder.dart';
import '../builder/chroma_theme_builder.dart';
import '../models/chroma_brand_profile.dart';
import '../models/chroma_overrides.dart';
import '../models/chroma_palette.dart';
import '../models/chroma_schedule.dart';
import '../models/chroma_seeds.dart';
import '../models/chroma_theme_mode.dart';
import '../services/image_theme_extractor.dart';
import '../services/theme_persistence.dart';

class ChromaThemeController extends ChangeNotifier {
  ChromaThemeMode _mode;
  ChromaPalette _palette;
  ChromaSeeds? _seeds;
  ChromaOverrides? _overrides;
  String? _fontFamily;
  ChromaSchedule? _schedule;
  final ThemePersistence? _persistence;

  // Multi-brand profiles registry
  final Map<String, ChromaBrandProfile> _brands = {};
  String? _activeBrand;

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
    String? fontFamily,
    ChromaSchedule? schedule,
    ThemePersistence? persistence,
    List<ChromaBrandProfile>? brandProfiles,
  })  : _mode = initialMode,
        _palette = initialPalette,
        _seeds = initialSeeds,
        _overrides = initialOverrides,
        _fontFamily = fontFamily,
        _schedule = schedule,
        _persistence = persistence {
    if (brandProfiles != null) {
      for (final profile in brandProfiles) {
        _brands[profile.name] = profile;
      }
    }
    if (_persistence != null) {
      loadFromPersistence();
    }
  }

  // =========================
  // Getters
  // =========================

  ChromaThemeMode get mode => _schedule != null ? _schedule!.resolveMode() : _mode;
  ChromaPalette get palette => _palette;
  ChromaSeeds? get seeds => _seeds;
  ChromaOverrides? get overrides => _overrides;
  String? get fontFamily => _fontFamily;
  ChromaSchedule? get schedule => _schedule;
  ThemePersistence? get persistence => _persistence;
  String? get activeBrand => _activeBrand;
  List<ChromaBrandProfile> get brands => _brands.values.toList();

  /// Stream that emits whenever the theme changes.
  Stream<ChromaThemeController> get onThemeChanged =>
      _themeChangeController.stream;

  /// Resolves the current [ChromaThemeMode] to Flutter's native [ThemeMode].
  ThemeMode get flutterThemeMode {
    final effectiveMode = mode;
    switch (effectiveMode) {
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

  void setFontFamily(String? fontFamily) {
    if (_fontFamily == fontFamily) return;
    _fontFamily = fontFamily;
    _invalidateCache();
    _notify();
  }

  void setSchedule(ChromaSchedule? schedule) {
    _schedule = schedule;
    _invalidateCache();
    _notify();
  }

  // =========================
  // Superpowers 🚀
  // =========================

  /// Extracts the dominant seed color from an [ImageProvider] (e.g. album art, profile picture, logo)
  /// and dynamically creates a matching theme!
  Future<void> setThemeFromImage(ImageProvider provider) async {
    final primarySeed = await ImageThemeExtractor.extractPrimarySeed(provider: provider);
    setDynamicSeed(primarySeed);
  }

  /// Registers a [ChromaBrandProfile] for white-label or multi-tenant theming.
  void registerBrand(ChromaBrandProfile profile) {
    _brands[profile.name] = profile;
  }

  /// Activates a registered brand profile by [brandName].
  void setBrand(String brandName) {
    final profile = _brands[brandName];
    if (profile == null) return;

    _activeBrand = brandName;
    if (profile.palette != null) _palette = profile.palette!;
    if (profile.seeds != null) _seeds = profile.seeds;
    if (profile.overrides != null) _overrides = profile.overrides;
    if (profile.fontFamily != null) _fontFamily = profile.fontFamily;

    _invalidateCache();
    _notify();
  }

  /// Sets dynamic seed colors from an OS wallpaper or single brand color.
  /// Perfect for Material You (Monet) dynamic theming.
  void setDynamicSeed(Color primaryColor) {
    setSeeds(ChromaSeeds.fromPrimary(primaryColor));
  }

  /// Toggles between light and dark modes.
  /// If [supportAmoled] is true, toggles between [ChromaThemeMode.light] and [ChromaThemeMode.amoled].
  void toggleThemeMode({bool supportAmoled = false}) {
    if (mode == ChromaThemeMode.light) {
      setTheme(supportAmoled ? ChromaThemeMode.amoled : ChromaThemeMode.dark);
    } else {
      setTheme(ChromaThemeMode.light);
    }
  }

  /// Cycles to the next available built-in palette.
  void nextPalette() {
    final values = ChromaPalette.values.where((p) => p != ChromaPalette.custom).toList();
    final currentIndex = values.indexOf(_palette);
    final nextIndex = (currentIndex + 1) % values.length;
    setPalette(values[nextIndex]);
  }

  /// Cycles to the previous built-in palette.
  void previousPalette() {
    final values = ChromaPalette.values.where((p) => p != ChromaPalette.custom).toList();
    final currentIndex = values.indexOf(_palette);
    final prevIndex = (currentIndex - 1 + values.length) % values.length;
    setPalette(values[prevIndex]);
  }

  /// Selects a random built-in palette.
  void randomPalette() {
    final values = ChromaPalette.values.where((p) => p != ChromaPalette.custom).toList();
    values.shuffle();
    setPalette(values.first);
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

    final effectiveMode = mode;
    final scheme = ChromaColorSchemeBuilder.build(
      palette: _palette,
      mode: effectiveMode,
      seeds: _seeds,
      systemBrightness: systemBrightness,
    );

    final bool effectiveDark;
    if (effectiveMode == ChromaThemeMode.system) {
      effectiveDark = systemBrightness == Brightness.dark;
    } else {
      effectiveDark = effectiveMode.isDark;
    }

    final themeData = ChromaThemeBuilder.build(
      scheme: scheme,
      textTheme: effectiveDark
          ? ThemeData.dark().textTheme
          : ThemeData.light().textTheme,
      overrides: _overrides,
      fontFamily: _fontFamily,
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
      fontFamily: _fontFamily,
    );
  }

  /// Builds a dark [ThemeData] for [MaterialApp.darkTheme].
  /// Honors AMOLED and High-Contrast modes if active.
  ThemeData buildDarkThemeData() {
    final effectiveMode = mode;
    final darkEffectiveMode = (effectiveMode == ChromaThemeMode.amoled ||
            effectiveMode == ChromaThemeMode.highContrast)
        ? effectiveMode
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
      fontFamily: _fontFamily,
    );
  }

  // =========================
  // Helpers
  // =========================

  bool get isDark => mode.isDark;
  bool isDarkEffective(Brightness? systemBrightness) {
    final effectiveMode = mode;
    if (effectiveMode == ChromaThemeMode.system) {
      return systemBrightness == Brightness.dark;
    }
    return effectiveMode.isDark;
  }

  bool get isLight => mode == ChromaThemeMode.light;
  bool get isHighContrast => mode == ChromaThemeMode.highContrast;
  bool get isAmoled => mode == ChromaThemeMode.amoled;
  bool get isSystem => mode == ChromaThemeMode.system;
  bool get hasSeeds => _seeds != null && !_seeds!.isEmpty;

  @override
  void dispose() {
    _themeChangeController.close();
    super.dispose();
  }
}
