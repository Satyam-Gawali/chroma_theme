# Chroma Theme API Reference 📖

This document provides a comprehensive overview of the classes, enums, and extensions available in the **Chroma Theme** package.

---

## 🏗️ Core Components

### `ChromaTheme`
The root widget that manages theme state and provides animated transitions.

| Property | Type | Description |
| :--- | :--- | :--- |
| `child` | `Widget` | The root widget of your application. |
| `initialMode` | `ChromaThemeMode` | The starting theme mode (default: `light`). |
| `initialPalette` | `ChromaPalette` | The starting palette (default: `blue`). |
| `seeds` | `ChromaSeeds?` | Optional custom seed colors. |
| `overrides` | `ChromaOverrides?` | Global component theme overrides. |
| `animationDuration` | `Duration` | Duration of theme transitions (default: `300ms`). |
| `animationCurve` | `Curve` | Curve of theme transitions (default: `Curves.easeInOut`). |

**Static Accessors:**
- `ChromaTheme.of(context)`: Returns the nearest `ChromaThemeController`.
- `ChromaTheme.maybeOf(context)`: Null-safe version of `of(context)`.

---

### `ChromaThemeController`
The business logic layer (ChangeNotifier) that controls the theme.

#### Getters
- `mode`: Current active `ChromaThemeMode`.
- `palette`: Current active `ChromaPalette`.
- `seeds`: Current active `ChromaSeeds`.
- `isDark`: Returns `true` if the theme is currently in a dark state (Brightness-aware).
- `onThemeChanged`: A `Stream` that broadcasts whenever the theme configuration changes.

#### Methods
- `setTheme(mode)`: Update the theme mode.
- `setPalette(palette)`: Update the palette (clears custom seeds).
- `setSeeds(seeds)`: Update custom seed colors (switches palette to `custom`).
- `clearSeeds()`: Reverts to the last selected palette.
- `setOverrides(overrides)`: Dynamically update global component overrides.

---

## 🎨 Design Models

### `ChromaSeeds`
A configuration object for dynamic Material 3 color generation.

| Field | Description |
| :--- | :--- |
| `primary` | The core accent color. |
| `secondary` | Complementary accent color. |
| `tertiary` | Highlight accent color. |
| `neutral` | Core surface/background seed. |
| `neutralLight` | Specific neutral seed for Light Mode. |
| `neutralDark` | Specific neutral seed for Dark Mode (prevents "muddy" AMOLED). |

---

### `ChromaOverrides`
A utility class to centralize Material component themes.

Supported Overrides:
- `appBarTheme`
- `cardTheme`
- `textTheme`
- `elevatedButtonTheme`
- `inputDecorationTheme`
- `floatingActionButtonTheme`
- `bottomNavigationBarTheme`
- `snackBarTheme`

---

## 🔢 Enums

### `ChromaThemeMode`
| Value | Description |
| :--- | :--- |
| `system` | Follows the OS brightness setting. |
| `light` | Force Light Mode. |
| `dark` | Force Dark Mode (Standard M3). |
| `highContrast` | Enhanced accessibility colors. |
| `amoled` | Pure black backgrounds for OLED screens. |

### `ChromaPalette`
Over 20+ professionally curated palettes including:
- `mono`, `blue`, `emerald`
- `mintLatte`, `berryBlush`, `neonForest`, `oceanSignal`
- `blackMetal`, `softOcean`, `royalBerry`, `onyxSpring`
- ... and more.

---

## 🛠️ Extensions

### `BuildContext`
The most convenient way to access Chroma Theme data.

| Extension | Returns | Usage |
| :--- | :--- | :--- |
| `.chroma` | `ChromaThemeController` | `context.chroma.setTheme(...)` |
| `.chromaColors` | `ColorScheme` | `context.chromaColors.primary` |
| `.chromaText` | `TextTheme` | `context.chromaText.displayLarge` |
| `.chromaTones` | `ChromaTones` | `context.chromaTones.primary[50]` |
| `.isDarkMode` | `bool` | `if (context.isDarkMode) ...` |

---

## 💾 Persistence

### `ThemePersistence`
An abstract class for implementing custom storage.

```dart
abstract class ThemePersistence {
  Future<void> saveThemeMode(ChromaThemeMode mode);
  Future<ChromaThemeMode?> loadThemeMode();
  Future<void> savePalette(ChromaPalette palette);
  Future<ChromaPalette?> loadPalette();
  Future<void> saveSeeds(ChromaSeeds? seeds);
  Future<ChromaSeeds?> loadSeeds();
}
```
