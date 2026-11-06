# Document 5: API Design & Usage Specifications

## 1. Overview
This document specifies the public API for **Chroma Theme 2.0**. It serves as the developer-facing contract, ensuring clear, predictable, and boilerplate-free usage.

---

## 2. Public API Surface

### 2.1. Initializing in `main.dart`

#### Recommended Approach: `ChromaTheme.builder`
```dart
import 'package:flutter/material.dart';
import 'package:chroma_theme/chroma_theme.dart';

void main() {
  runApp(
    ChromaTheme.builder(
      initialMode: ChromaThemeMode.system,
      initialPalette: ChromaPalette.blue,
      overrides: const ChromaOverrides(
        appBarTheme: AppBarTheme(centerTitle: true, elevation: 0),
      ),
      builder: (context, theme, darkTheme, themeMode) {
        return MaterialApp(
          title: 'My Chroma App',
          theme: theme,
          darkTheme: darkTheme,
          themeMode: themeMode,
          home: const HomeScreen(),
        );
      },
    ),
  );
}
```

#### Alternative Approach: Standalone Child
For apps using an existing `MaterialApp` or when applying Chroma Theme to an isolated sub-tree:
```dart
ChromaTheme(
  initialPalette: ChromaPalette.neonForest,
  initialMode: ChromaThemeMode.dark,
  child: const MySubView(),
)
```

---

## 3. Controlling Themes in Runtime (`BuildContext` Extensions)

From any widget in the tree, developers have instant access to the controller and theme tokens via `context`:

### 3.1. Switching Modes
```dart
// Switch to Dark mode
context.chroma.setTheme(ChromaThemeMode.dark);

// Switch to AMOLED mode (pure black for OLED screens)
context.chroma.setTheme(ChromaThemeMode.amoled);

// Switch to High Contrast
context.chroma.setTheme(ChromaThemeMode.highContrast);

// Follow device OS setting
context.chroma.setTheme(ChromaThemeMode.system);
```

### 3.2. Switching Palettes
```dart
// Switch to predefined designer palette
context.chroma.setPalette(ChromaPalette.midnightMint);
```

### 3.3. Dynamic Seed Colors
```dart
// Generate entire theme from brand colors
context.chroma.setSeeds(
  const ChromaSeeds(
    primary: Color(0xFF6750A4),
    secondary: Color(0xFF625B71),
    neutralDark: Color(0xFF141218),
  ),
);

// Revert seeds back to selected palette
context.chroma.clearSeeds();
```

---

## 4. Theme & Color Tokens Access

Instead of writing verbose `Theme.of(context).colorScheme.primary`:
```dart
// Quick ColorScheme access
final colors = context.chromaColors;
final primaryColor = colors.primary;
final surfaceColor = colors.surface;

// Quick TextTheme access
final textTheme = context.chromaText;
final headline = textTheme.headlineMedium;

// Material 3 Tonal Palettes (0-100)
final tone50 = context.chromaTones.primary[50];
final tone90 = context.chromaTones.secondary[90];

// Mode status
final isDark = context.isDarkMode;
```

---

## 5. Listening to Theme Changes Outside UI

Developers can listen to stream broadcasts directly from the controller:
```dart
final controller = ChromaTheme.of(context);

final subscription = controller.onThemeChanged.listen((updatedController) {
  print('Theme changed to: ${updatedController.mode}');
});
```

---

## 6. Persistence Integration Example

Implementing persistent settings with SharedPreferences:
```dart
class MyThemeStorage implements ThemePersistence {
  final SharedPreferences prefs;
  MyThemeStorage(this.prefs);

  @override
  Future<void> saveThemeMode(ChromaThemeMode mode) async {
    await prefs.setString('chroma_mode', mode.name);
  }

  @override
  Future<ChromaThemeMode?> loadThemeMode() async {
    final name = prefs.getString('chroma_mode');
    return name != null ? ChromaThemeMode.values.byName(name) : null;
  }

  @override
  Future<void> savePalette(ChromaPalette palette) async {
    await prefs.setString('chroma_palette', palette.name);
  }

  @override
  Future<ChromaPalette?> loadPalette() async {
    final name = prefs.getString('chroma_palette');
    return name != null ? ChromaPalette.values.byName(name) : null;
  }

  @override
  Future<void> saveSeeds(ChromaSeeds? seeds) async {
    // Optional implementation
  }

  @override
  Future<ChromaSeeds?> loadSeeds() async => null;
}
```

Wiring into `ChromaTheme`:
```dart
final storage = MyThemeStorage(await SharedPreferences.getInstance());

ChromaTheme.builder(
  persistence: storage,
  builder: (context, theme, darkTheme, themeMode) => MaterialApp(...),
)
```
