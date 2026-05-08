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

      // 🔥 Background
      scaffoldBackgroundColor: scheme.surface,

      // 🔥 AppBar — user can override
      appBarTheme: overrides?.appBarTheme ??
          AppBarTheme(
            backgroundColor: scheme.surface,
            foregroundColor: scheme.onSurface,
            elevation: 0,
          ),

      // 🔥 Buttons — user can override
      elevatedButtonTheme: overrides?.elevatedButtonTheme ??
          ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: scheme.primary,
              foregroundColor: scheme.onPrimary,
            ),
          ),

      // 🔥 Card — user can override
      cardTheme: overrides?.cardTheme,

      // 🔥 InputDecoration — user can override
      inputDecorationTheme: overrides?.inputDecorationTheme,

      // 🔥 Divider
      dividerTheme: DividerThemeData(
        color: scheme.outlineVariant,
      ),

      // 🔥 Floating Action Button — user can override
      floatingActionButtonTheme: overrides?.floatingActionButtonTheme ??
          FloatingActionButtonThemeData(
            backgroundColor: scheme.primaryContainer,
            foregroundColor: scheme.onPrimaryContainer,
          ),

      // 🔥 BottomNavigationBar — user can override
      bottomNavigationBarTheme: overrides?.bottomNavigationBarTheme,

      // 🔥 SnackBar — user can override
      snackBarTheme: overrides?.snackBarTheme,
    );
  }
}