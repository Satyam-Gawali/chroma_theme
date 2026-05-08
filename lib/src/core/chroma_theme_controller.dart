import 'dart:async';
import 'package:flutter/material.dart';

import '../models/chroma_theme_mode.dart';
import '../models/chroma_palette.dart';
import '../models/chroma_seeds.dart';
import '../models/chroma_overrides.dart';
import '../builder/chroma_theme_builder.dart';
import '../builder/chroma_color_scheme_builder.dart';

class ChromaThemeController extends ChangeNotifier {
  ChromaThemeMode _mode;
  ChromaPalette _palette;
  ChromaSeeds? _seeds;
  ChromaOverrides? _overrides;

  final _themeChangeController = StreamController<ChromaThemeController>.broadcast();

  ChromaThemeController({
    ChromaThemeMode initialMode = ChromaThemeMode.light,
    ChromaPalette initialPalette = ChromaPalette.blue,
    ChromaSeeds? initialSeeds,
    ChromaOverrides? initialOverrides,
  })  : _mode = initialMode,
        _palette = initialPalette,
        _seeds = initialSeeds,
        _overrides = initialOverrides;

  // =========================
  // Getters
  // =========================

  ChromaThemeMode get mode => _mode;
  ChromaPalette get palette => _palette;
  ChromaSeeds? get seeds => _seeds;
  ChromaOverrides? get overrides => _overrides;

  /// Stream that emits whenever the theme changes.
  Stream<ChromaThemeController> get onThemeChanged => _themeChangeController.stream;

  // =========================
  // Setters
  // =========================

  void setTheme(ChromaThemeMode mode) {
    if (_mode == mode) return;
    _mode = mode;
    _notify();
  }

  void setPalette(ChromaPalette palette) {
    if (_palette == palette) return;
    _palette = palette;
    _notify();
  }

  void setSeeds(ChromaSeeds? seeds) {
    _seeds = seeds;
    _notify();
  }

  void clearSeeds() {
    _seeds = null;
    _notify();
  }

  void setOverrides(ChromaOverrides? overrides) {
    _overrides = overrides;
    _notify();
  }

  void _notify() {
    notifyListeners();
    _themeChangeController.add(this);
  }

  // =========================
  // Theme Building 🔥
  // =========================

  /// Generates the [ThemeData] for the current state.
  /// [systemBrightness] is required when mode is [ChromaThemeMode.system].
  ThemeData buildThemeData(Brightness? systemBrightness) {
    final scheme = ChromaColorSchemeBuilder.build(
      palette: _palette,
      mode: _mode,
      seeds: _seeds,
      systemBrightness: systemBrightness,
    );

    // Determine if the effective brightness is dark
    final bool effectiveDark;
    if (_mode == ChromaThemeMode.system) {
      effectiveDark = systemBrightness == Brightness.dark;
    } else {
      effectiveDark = _mode.isDark;
    }

    return ChromaThemeBuilder.build(
      scheme: scheme,
      textTheme: effectiveDark
          ? ThemeData.dark().textTheme
          : ThemeData.light().textTheme,
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
