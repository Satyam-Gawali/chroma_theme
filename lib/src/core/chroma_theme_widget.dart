import 'package:flutter/material.dart';

import '../models/chroma_brand_profile.dart';
import '../models/chroma_overrides.dart';
import '../models/chroma_palette.dart';
import '../models/chroma_schedule.dart';
import '../models/chroma_seeds.dart';
import '../models/chroma_theme_mode.dart';
import '../palettes/palette_registry.dart';
import '../services/theme_persistence.dart';
import 'chroma_theme_controller.dart';
import 'chroma_theme_inherited.dart';

/// Callback signature for [ChromaTheme.builder].
typedef ChromaThemeBuilderCallback = Widget Function(
  BuildContext context,
  ThemeData theme,
  ThemeData darkTheme,
  ThemeMode themeMode,
);

/// Root widget that provides and animates dynamic Material 3 themes.
///
/// Use the recommended [ChromaTheme.builder] constructor to configure
/// your root [MaterialApp]:
/// ```dart
/// ChromaTheme.builder(
///   initialMode: ChromaThemeMode.system,
///   initialPalette: ChromaPalette.blue,
///   builder: (context, theme, darkTheme, themeMode) {
///     return MaterialApp(
///       theme: theme,
///       darkTheme: darkTheme,
///       themeMode: themeMode,
///       home: const HomeScreen(),
///     );
///   },
/// )
/// ```
class ChromaTheme extends StatefulWidget {
  /// The builder function that receives the active [ThemeData], [darkTheme],
  /// and [themeMode] to pass directly into your [MaterialApp].
  final ChromaThemeBuilderCallback? builder;

  /// Optional child widget when using [ChromaTheme] as a subtree wrapper.
  final Widget? child;

  /// Optional pre-instantiated [ChromaThemeController].
  final ChromaThemeController? controller;

  /// Initial theme mode if [controller] is not provided.
  final ChromaThemeMode initialMode;

  /// Initial palette if [controller] is not provided.
  final ChromaPalette initialPalette;

  /// Initial seed colors if [controller] is not provided.
  final ChromaSeeds? seeds;

  /// Component-level theme overrides.
  final ChromaOverrides? overrides;

  /// Global typography font family (e.g. 'Poppins', 'Inter').
  final String? fontFamily;

  /// Sunrise / sunset automated schedule.
  final ChromaSchedule? schedule;

  /// White-label / multi-brand styling profiles.
  final List<ChromaBrandProfile>? brandProfiles;

  /// Optional persistence adapter for auto-saving theme choices.
  final ThemePersistence? persistence;

  /// Duration for theme transition animations when using [child].
  final Duration animationDuration;

  /// Curve for theme transition animations when using [child].
  final Curve animationCurve;

  /// Primary builder constructor for root-level app theming.
  const ChromaTheme.builder({
    super.key,
    required ChromaThemeBuilderCallback this.builder,
    this.controller,
    this.initialMode = ChromaThemeMode.system,
    this.initialPalette = ChromaPalette.blue,
    this.seeds,
    this.overrides,
    this.fontFamily,
    this.schedule,
    this.brandProfiles,
    this.persistence,
    this.animationDuration = const Duration(milliseconds: 300),
    this.animationCurve = Curves.easeInOut,
  }) : child = null;

  /// Standalone constructor when wrapping a subtree with [AnimatedTheme].
  const ChromaTheme({
    super.key,
    required Widget this.child,
    this.controller,
    this.initialMode = ChromaThemeMode.light,
    this.initialPalette = ChromaPalette.blue,
    this.seeds,
    this.overrides,
    this.fontFamily,
    this.schedule,
    this.brandProfiles,
    this.persistence,
    this.animationDuration = const Duration(milliseconds: 300),
    this.animationCurve = Curves.easeInOut,
  }) : builder = null;

  /// Access the nearest [ChromaThemeController] in the widget tree.
  static ChromaThemeController of(BuildContext context) {
    final inherited =
        context.dependOnInheritedWidgetOfExactType<ChromaThemeInherited>();
    assert(
      inherited != null,
      'No ChromaTheme found in the widget tree. '
      'Make sure your app root is wrapped with ChromaTheme.builder(...) or ChromaTheme(...).',
    );
    return inherited!.controller;
  }

  /// Access the nearest [ChromaThemeController] safely, returning null if not found.
  static ChromaThemeController? maybeOf(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<ChromaThemeInherited>()
        ?.controller;
  }

  @override
  State<ChromaTheme> createState() => _ChromaThemeState();
}

class _ChromaThemeState extends State<ChromaTheme> {
  late ChromaThemeController _controller;
  bool _createdInternalController = false;

  @override
  void initState() {
    super.initState();
    registerDefaultPalettes();

    if (widget.controller != null) {
      _controller = widget.controller!;
    } else {
      _createdInternalController = true;
      _controller = ChromaThemeController(
        initialMode: widget.initialMode,
        initialPalette: widget.initialPalette,
        initialSeeds: widget.seeds,
        initialOverrides: widget.overrides,
        fontFamily: widget.fontFamily,
        schedule: widget.schedule,
        brandProfiles: widget.brandProfiles,
        persistence: widget.persistence,
      );
    }
  }

  @override
  void didUpdateWidget(ChromaTheme oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != null && widget.controller != _controller) {
      if (_createdInternalController) {
        _controller.dispose();
        _createdInternalController = false;
      }
      _controller = widget.controller!;
    } else if (_createdInternalController) {
      if (widget.initialMode != oldWidget.initialMode) {
        _controller.setTheme(widget.initialMode);
      }
      if (widget.initialPalette != oldWidget.initialPalette) {
        _controller.setPalette(widget.initialPalette);
      }
      if (widget.seeds != oldWidget.seeds) {
        _controller.setSeeds(widget.seeds);
      }
      if (widget.overrides != oldWidget.overrides) {
        _controller.setOverrides(widget.overrides);
      }
      if (widget.fontFamily != oldWidget.fontFamily) {
        _controller.setFontFamily(widget.fontFamily);
      }
      if (widget.schedule != oldWidget.schedule) {
        _controller.setSchedule(widget.schedule);
      }
    }
  }

  @override
  void dispose() {
    if (_createdInternalController) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        if (widget.builder != null) {
          final lightTheme = _controller.buildLightThemeData();
          final darkTheme = _controller.buildDarkThemeData();
          final themeMode = _controller.flutterThemeMode;

          return ChromaThemeInherited(
            controller: _controller,
            child: widget.builder!(context, lightTheme, darkTheme, themeMode),
          );
        }

        // Subtree fallback using AnimatedTheme with reactive MediaQuery listening
        final platformBrightness =
            MediaQuery.maybePlatformBrightnessOf(context) ??
                View.of(context).platformDispatcher.platformBrightness;
        final themeData = _controller.buildThemeData(platformBrightness);

        return ChromaThemeInherited(
          controller: _controller,
          child: AnimatedTheme(
            data: themeData,
            duration: widget.animationDuration,
            curve: widget.animationCurve,
            child: widget.child!,
          ),
        );
      },
    );
  }
}
