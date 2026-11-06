import 'package:flutter/material.dart';

/// A data class holding specific component theme overrides.
/// Pass this to [ChromaTheme] to fine-tune the generated Material 3 theme.
class ChromaOverrides {
  final AppBarTheme? appBarTheme;
  final CardThemeData? cardTheme;
  final TextTheme? textTheme;
  final ElevatedButtonThemeData? elevatedButtonTheme;
  final FilledButtonThemeData? filledButtonTheme;
  final OutlinedButtonThemeData? outlinedButtonTheme;
  final InputDecorationTheme? inputDecorationTheme;
  final FloatingActionButtonThemeData? floatingActionButtonTheme;
  final NavigationBarThemeData? navigationBarTheme;
  final NavigationRailThemeData? navigationRailTheme;
  final BottomNavigationBarThemeData? bottomNavigationBarTheme;
  final BottomSheetThemeData? bottomSheetTheme;
  final SnackBarThemeData? snackBarTheme;
  final SearchBarThemeData? searchBarTheme;
  final SegmentedButtonThemeData? segmentedButtonTheme;
  final DialogThemeData? dialogTheme;

  const ChromaOverrides({
    this.appBarTheme,
    this.cardTheme,
    this.textTheme,
    this.elevatedButtonTheme,
    this.filledButtonTheme,
    this.outlinedButtonTheme,
    this.inputDecorationTheme,
    this.floatingActionButtonTheme,
    this.navigationBarTheme,
    this.navigationRailTheme,
    this.bottomNavigationBarTheme,
    this.bottomSheetTheme,
    this.snackBarTheme,
    this.searchBarTheme,
    this.segmentedButtonTheme,
    this.dialogTheme,
  });

  /// Merges two overrides together.
  ChromaOverrides copyWith({
    AppBarTheme? appBarTheme,
    CardThemeData? cardTheme,
    TextTheme? textTheme,
    ElevatedButtonThemeData? elevatedButtonTheme,
    FilledButtonThemeData? filledButtonTheme,
    OutlinedButtonThemeData? outlinedButtonTheme,
    InputDecorationTheme? inputDecorationTheme,
    FloatingActionButtonThemeData? floatingActionButtonTheme,
    NavigationBarThemeData? navigationBarTheme,
    NavigationRailThemeData? navigationRailTheme,
    BottomNavigationBarThemeData? bottomNavigationBarTheme,
    BottomSheetThemeData? bottomSheetTheme,
    SnackBarThemeData? snackBarTheme,
    SearchBarThemeData? searchBarTheme,
    SegmentedButtonThemeData? segmentedButtonTheme,
    DialogThemeData? dialogTheme,
  }) {
    return ChromaOverrides(
      appBarTheme: appBarTheme ?? this.appBarTheme,
      cardTheme: cardTheme ?? this.cardTheme,
      textTheme: textTheme ?? this.textTheme,
      elevatedButtonTheme: elevatedButtonTheme ?? this.elevatedButtonTheme,
      filledButtonTheme: filledButtonTheme ?? this.filledButtonTheme,
      outlinedButtonTheme: outlinedButtonTheme ?? this.outlinedButtonTheme,
      inputDecorationTheme: inputDecorationTheme ?? this.inputDecorationTheme,
      floatingActionButtonTheme: floatingActionButtonTheme ?? this.floatingActionButtonTheme,
      navigationBarTheme: navigationBarTheme ?? this.navigationBarTheme,
      navigationRailTheme: navigationRailTheme ?? this.navigationRailTheme,
      bottomNavigationBarTheme: bottomNavigationBarTheme ?? this.bottomNavigationBarTheme,
      bottomSheetTheme: bottomSheetTheme ?? this.bottomSheetTheme,
      snackBarTheme: snackBarTheme ?? this.snackBarTheme,
      searchBarTheme: searchBarTheme ?? this.searchBarTheme,
      segmentedButtonTheme: segmentedButtonTheme ?? this.segmentedButtonTheme,
      dialogTheme: dialogTheme ?? this.dialogTheme,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ChromaOverrides &&
        other.appBarTheme == appBarTheme &&
        other.cardTheme == cardTheme &&
        other.textTheme == textTheme &&
        other.elevatedButtonTheme == elevatedButtonTheme &&
        other.filledButtonTheme == filledButtonTheme &&
        other.outlinedButtonTheme == outlinedButtonTheme &&
        other.inputDecorationTheme == inputDecorationTheme &&
        other.floatingActionButtonTheme == floatingActionButtonTheme &&
        other.navigationBarTheme == navigationBarTheme &&
        other.navigationRailTheme == navigationRailTheme &&
        other.bottomNavigationBarTheme == bottomNavigationBarTheme &&
        other.bottomSheetTheme == bottomSheetTheme &&
        other.snackBarTheme == snackBarTheme &&
        other.searchBarTheme == searchBarTheme &&
        other.segmentedButtonTheme == segmentedButtonTheme &&
        other.dialogTheme == dialogTheme;
  }

  @override
  int get hashCode => Object.hash(
        appBarTheme,
        cardTheme,
        textTheme,
        elevatedButtonTheme,
        filledButtonTheme,
        outlinedButtonTheme,
        inputDecorationTheme,
        floatingActionButtonTheme,
        navigationBarTheme,
        navigationRailTheme,
        bottomNavigationBarTheme,
        bottomSheetTheme,
        snackBarTheme,
        searchBarTheme,
        segmentedButtonTheme,
        dialogTheme,
      );
}
