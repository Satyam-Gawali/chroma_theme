import 'package:flutter/material.dart';
import '../models/chroma_overrides.dart';

class ChromaThemeBuilder {
  ChromaThemeBuilder._();

  static ThemeData build({
    required ColorScheme scheme,
    required TextTheme textTheme,
    ChromaOverrides? overrides,
    String? fontFamily,
  }) {
    final isAmoled = scheme.surface == Colors.black && scheme.brightness == Brightness.dark;

    return ThemeData(
      useMaterial3: true,
      fontFamily: fontFamily,
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
            scrolledUnderElevation: isAmoled ? 0 : null,
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

      // Card - In AMOLED mode, if not overridden, use surfaceContainerLow to contrast with black
      cardTheme: overrides?.cardTheme ??
          (isAmoled
              ? CardThemeData(
                  color: scheme.surfaceContainerLow,
                  elevation: 0,
                )
              : null),

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

      // Sheets & Dialogs
      bottomSheetTheme: overrides?.bottomSheetTheme ??
          (isAmoled
              ? const BottomSheetThemeData(
                  backgroundColor: Colors.black,
                  modalBackgroundColor: Colors.black,
                )
              : null),
      dialogTheme: overrides?.dialogTheme ??
          (isAmoled
              ? DialogThemeData(
                  backgroundColor: scheme.surfaceContainerLow,
                )
              : null),

      snackBarTheme: overrides?.snackBarTheme,
      searchBarTheme: overrides?.searchBarTheme,
      segmentedButtonTheme: overrides?.segmentedButtonTheme,
    );
  }
}
