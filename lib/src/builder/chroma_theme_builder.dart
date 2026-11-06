import 'package:flutter/material.dart';
import '../models/chroma_overrides.dart';

class ChromaThemeBuilder {
  ChromaThemeBuilder._();

  static ThemeData build({
    required ColorScheme scheme,
    required TextTheme textTheme,
    ChromaOverrides? overrides,
  }) {
    return ThemeData(
      useMaterial3: true,
      brightness: scheme.brightness,
      colorScheme: scheme,
      textTheme: overrides?.textTheme ?? textTheme,

      // Scaffold background
      scaffoldBackgroundColor: scheme.surface,

      // AppBar
      appBarTheme: overrides?.appBarTheme ??
          AppBarTheme(
            backgroundColor: scheme.surface,
            foregroundColor: scheme.onSurface,
            elevation: 0,
          ),

      // Buttons
      elevatedButtonTheme: overrides?.elevatedButtonTheme ??
          ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: scheme.primary,
              foregroundColor: scheme.onPrimary,
            ),
          ),
      filledButtonTheme: overrides?.filledButtonTheme,
      outlinedButtonTheme: overrides?.outlinedButtonTheme,

      // Card
      cardTheme: overrides?.cardTheme,

      // Inputs
      inputDecorationTheme: overrides?.inputDecorationTheme,

      // Divider
      dividerTheme: DividerThemeData(
        color: scheme.outlineVariant,
      ),

      // Floating Action Button
      floatingActionButtonTheme: overrides?.floatingActionButtonTheme ??
          FloatingActionButtonThemeData(
            backgroundColor: scheme.primaryContainer,
            foregroundColor: scheme.onPrimaryContainer,
          ),

      // Navigation
      navigationBarTheme: overrides?.navigationBarTheme,
      navigationRailTheme: overrides?.navigationRailTheme,
      bottomNavigationBarTheme: overrides?.bottomNavigationBarTheme,

      // SnackBar & Dialogs
      snackBarTheme: overrides?.snackBarTheme,
      searchBarTheme: overrides?.searchBarTheme,
      segmentedButtonTheme: overrides?.segmentedButtonTheme,
      dialogTheme: overrides?.dialogTheme,
    );
  }
}
