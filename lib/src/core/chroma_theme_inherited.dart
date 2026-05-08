import 'package:flutter/material.dart';
import 'chroma_theme_controller.dart';

class ChromaThemeInherited extends InheritedWidget {
  final ChromaThemeController controller;

  const ChromaThemeInherited({
    super.key,
    required this.controller,
    required super.child,
  });

  @override
  bool updateShouldNotify(_) => true;
}