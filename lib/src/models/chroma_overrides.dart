import 'package:flutter/material.dart';

/// A data class holding specific component theme overrides.
/// Pass this to [ChromaTheme] to fine-tune the generated Material 3 theme.
class ChromaOverrides {
  final AppBarTheme? appBarTheme;
  final CardThemeData? cardTheme;
  final TextTheme? textTheme;
  final ElevatedButtonThemeData? elevatedButtonTheme;
  final InputDecorationTheme? inputDecorationTheme;
  final FloatingActionButtonThemeData? floatingActionButtonTheme;
  final BottomNavigationBarThemeData? bottomNavigationBarTheme;
  final SnackBarThemeData? snackBarTheme;

  const ChromaOverrides({
    this.appBarTheme,
    this.cardTheme,
    this.textTheme,
    this.elevatedButtonTheme,
    this.inputDecorationTheme,
    this.floatingActionButtonTheme,
    this.bottomNavigationBarTheme,
    this.snackBarTheme,
  });

  /// Merges two overrides together.
  ChromaOverrides copyWith({
    AppBarTheme? appBarTheme,
    CardThemeData? cardTheme,
    TextTheme? textTheme,
    ElevatedButtonThemeData? elevatedButtonTheme,
    InputDecorationTheme? inputDecorationTheme,
    FloatingActionButtonThemeData? floatingActionButtonTheme,
    BottomNavigationBarThemeData? bottomNavigationBarTheme,
    SnackBarThemeData? snackBarTheme,
  }) {
    return ChromaOverrides(
      appBarTheme: appBarTheme ?? this.appBarTheme,
      cardTheme: cardTheme ?? this.cardTheme,
      textTheme: textTheme ?? this.textTheme,
      elevatedButtonTheme: elevatedButtonTheme ?? this.elevatedButtonTheme,
      inputDecorationTheme: inputDecorationTheme ?? this.inputDecorationTheme,
      floatingActionButtonTheme: floatingActionButtonTheme ?? this.floatingActionButtonTheme,
      bottomNavigationBarTheme: bottomNavigationBarTheme ?? this.bottomNavigationBarTheme,
      snackBarTheme: snackBarTheme ?? this.snackBarTheme,
    );
  }
}
