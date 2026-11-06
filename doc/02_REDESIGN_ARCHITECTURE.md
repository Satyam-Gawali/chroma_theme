# Document 2: Target Redesign Architecture (v2.0)

## 1. Architectural Goals
The objective of **Chroma Theme 2.0** is to provide an idiomatic, predictable, and robust Material 3 theme management system for Flutter apps.

Key principles:
1. **Idiomatic Flutter Integration:** No nested `MaterialApp` hacks. Use standard builder or controller injection.
2. **Zero Dead Code:** Ensure all 22 Palettes properly support Light, Dark, High Contrast, and AMOLED modes.
3. **Decoupled & Modular:** Clear separation between ColorScheme generation, ThemeData construction, and State Management.
4. **Performance Optimized:** Cache generated tones and color schemes to prevent expensive recalculations during animations and rebuilds.

---

## 2. Core Architecture Components

```text
┌─────────────────────────────────────────────────────────────┐
│                 ChromaThemeController (ChangeNotifier)     │
│  - mode: ChromaThemeMode (system / light / dark / hc / amoled)│
│  - palette: ChromaPalette (22 presets + custom)             │
│  - seeds: ChromaSeeds? (optional custom overrides)          │
│  - overrides: ChromaOverrides? (component styling)           │
│  - persistence: ThemePersistence? (optional auto-save)      │
└──────────────────────────────┬──────────────────────────────┘
                               │
            ┌──────────────────┴──────────────────┐
            ▼                                     ▼
┌───────────────────────────────┐   ┌───────────────────────────────┐
│   ChromaColorSchemeBuilder    │   │      ChromaThemeBuilder       │
│  Resolves:                    │   │  Assembles ThemeData:        │
│  1. Seeds (top priority)      │   │  - ColorScheme                │
│  2. Palette (Registry lookup) │──▶│  - TextTheme                  │
│  3. Mode tweaks:              │   │  - Component Overrides        │
│     - High Contrast           │   │  - Transitions & Shapes       │
│     - AMOLED (#000000 surfaces│   └───────────────┬───────────────┘
└───────────────────────────────┘                   │
                                                    ▼
┌───────────────────────────────────────────────────────────────────┐
│                      ChromaTheme (Widget)                         │
│                                                                   │
│  Option A (Builder Pattern - Preferred):                          │
│  ChromaTheme(                                                     │
│    builder: (context, theme, darkTheme, themeMode) {              │
│      return MaterialApp(                                          │
│        theme: theme,                                              │
│        darkTheme: darkTheme,                                      │
│        themeMode: themeMode,                                      │
│        ...                                                        │
│      );                                                           │
│    }                                                              │
│  )                                                                │
│                                                                   │
│  Option B (Wrapped Child with AnimatedTheme):                     │
│  ChromaTheme(                                                     │
│    child: MyScaffoldContent(),                                    │
│  )                                                                │
└───────────────────────────────────────────────────────────────────┘
```

---

## 3. Detailed Component Redesign

### 3.1. `ChromaTheme` Widget (Builder Pattern)
Instead of guessing whether `widget.child` is a `MaterialApp`, `ChromaTheme` will provide a standard builder constructor:
```dart
typedef ChromaThemeBuilderCallback = Widget Function(
  BuildContext context,
  ThemeData theme,
  ThemeData darkTheme,
  ThemeMode themeMode,
);

class ChromaTheme extends StatefulWidget {
  final ChromaThemeBuilderCallback? builder;
  final Widget? child;
  final ChromaThemeController? controller;
  // default initial values if controller is not provided
  final ChromaThemeMode initialMode;
  final ChromaPalette initialPalette;
  final ChromaSeeds? seeds;
  final ChromaOverrides? overrides;
  final Duration animationDuration;
  final Curve animationCurve;
  ...
}
```

This guarantees:
1. The developer passes `theme`, `darkTheme`, and `themeMode` directly to their `MaterialApp`.
2. No nested `MaterialApp` is ever created behind the developer's back.
3. System brightness changes and OS theme switches work seamlessly out of the box.

---

### 3.2. Palette Registry Overhaul
The registry will support 3 distinct variants per palette:
- **Light Scheme**
- **Dark Scheme**
- **High Contrast Scheme**

```dart
class PaletteEntry {
  final ColorScheme Function() light;
  final ColorScheme Function() dark;
  final ColorScheme Function() highContrast;

  const PaletteEntry({
    required this.light,
    required this.dark,
    required this.highContrast,
  });
}
```

When building:
- **Mode = `light`** ➔ `entry.light()`
- **Mode = `dark`** ➔ `entry.dark()`
- **Mode = `highContrast`** ➔ `entry.highContrast()`
- **Mode = `amoled`** ➔ Takes `entry.dark()` and transforms surfaces to pure black (`#000000`) while preserving all primary, secondary, and tertiary brand colors!

This connects all 22 existing `_high_contrast.dart` files and fixes the AMOLED color-wipe bug completely.

---

### 3.3. Custom Palette Registration API
Developers can dynamically register custom palettes at runtime:
```dart
PaletteRegistry.register(
  ChromaPalette.custom,
  PaletteEntry(
    light: () => myCustomLightScheme,
    dark: () => myCustomDarkScheme,
    highContrast: () => myCustomHCScheme,
  ),
);
```

---

### 3.4. Cache-Optimized Tonal Extraction (`ChromaTones`)
Instead of regenerating 78 color tones on every `context.chromaTones` property access:
1. Cache `ChromaTones` inside the controller or the active theme state.
2. Only invalidate and recompute the cache when the active `ColorScheme` actually changes.
3. Use Flutter's built-in `package:material_color_utilities` or perceptual HCT luminance formulas for accurate tonal steps.

---

### 3.5. Persistence Integration
Add native persistence hooks to `ChromaThemeController`:
```dart
class ChromaThemeController extends ChangeNotifier {
  final ThemePersistence? persistence;

  ChromaThemeController({
    this.persistence,
    ...
  }) {
    if (persistence != null) {
      _loadFromPersistence();
    }
  }

  Future<void> setTheme(ChromaThemeMode mode) async {
    _mode = mode;
    notifyListeners();
    await persistence?.saveThemeMode(mode);
  }
}
```
Provide a ready-to-use in-memory persistence implementation, plus simple copy-paste adapters for `shared_preferences` and `hive`.
