import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/chroma_theme_mode.dart';
import '../models/chroma_palette.dart';
import '../models/chroma_seeds.dart';
import '../models/chroma_overrides.dart';
import '../palettes/palette_registry.dart';
import 'chroma_theme_controller.dart';
import 'chroma_theme_inherited.dart';

class ChromaTheme extends StatefulWidget {
  final Widget child;
  final ChromaThemeMode initialMode;
  final ChromaPalette initialPalette;
  final ChromaSeeds? seeds;

  /// Optional component-level overrides applied on top of the generated theme.
  final ChromaOverrides? overrides;

  /// Duration for theme transition animations.
  final Duration animationDuration;

  /// Curve for theme transition animations.
  final Curve animationCurve;

  const ChromaTheme({
    super.key,
    required this.child,
    this.initialMode = ChromaThemeMode.light,
    this.initialPalette = ChromaPalette.blue,
    this.seeds,
    this.overrides,
    this.animationDuration = const Duration(milliseconds: 300),
    this.animationCurve = Curves.easeInOut,
  });

  static ChromaThemeController of(BuildContext context) {
    final inherited =
        context.dependOnInheritedWidgetOfExactType<ChromaThemeInherited>();
    assert(
      inherited != null,
      'No ChromaTheme found in the widget tree. '
      'Make sure to wrap your app with ChromaTheme(...).',
    );
    return inherited!.controller;
  }

  static ChromaThemeController? maybeOf(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<ChromaThemeInherited>()
        ?.controller;
  }

  @override
  State<ChromaTheme> createState() => _ChromaThemeState();
}

class _ChromaThemeState extends State<ChromaTheme> {
  late ChromaThemeController controller;

  @override
  void initState() {
    super.initState();
    registerDefaultPalettes();
    controller = ChromaThemeController(
      initialMode: widget.initialMode,
      initialPalette: widget.initialPalette,
      initialSeeds: widget.seeds,
      initialOverrides: widget.overrides,
    );
  }

  @override
  void didUpdateWidget(ChromaTheme oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialMode != oldWidget.initialMode) {
      controller.setTheme(widget.initialMode);
    }
    if (widget.initialPalette != oldWidget.initialPalette) {
      controller.setPalette(widget.initialPalette);
    }
    if (widget.seeds != oldWidget.seeds) {
      controller.setSeeds(widget.seeds);
    }
    if (widget.overrides != oldWidget.overrides) {
      controller.setOverrides(widget.overrides);
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        final platformBrightness =
            View.of(context).platformDispatcher.platformBrightness;
        final themeData = controller.buildThemeData(platformBrightness);
        final usesAppRoot =
            widget.child is MaterialApp || widget.child is CupertinoApp;

        final themedChild = AnimatedTheme(
          data: themeData,
          duration: widget.animationDuration,
          curve: widget.animationCurve,
          child: widget.child,
        );

        return ChromaThemeInherited(
          controller: controller,
          child: usesAppRoot
              ? themedChild
              : MaterialApp(
                  debugShowCheckedModeBanner: false,
                  home: themedChild,
                ),
        );
      },
    );
  }
}
