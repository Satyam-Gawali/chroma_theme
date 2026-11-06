# Chroma Theme API Reference 📖

This document provides a comprehensive overview of the classes, enums, extensions, and services in **Chroma Theme 2.0**.

---

## 🏗️ Core Components

### `ChromaTheme.builder` (Recommended)
The primary entrypoint for setting up Chroma Theme in your application. It cleanly injects light `theme`, `darkTheme`, and `themeMode` into your `MaterialApp`.

| Parameter | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `builder` | `ChromaThemeWidgetBuilder` | Required | Callback receiving `(context, theme, darkTheme, themeMode)`. |
| `initialMode` | `ChromaThemeMode` | `ChromaThemeMode.light` | Starting theme mode. |
| `initialPalette` | `ChromaPalette` | `ChromaPalette.blue` | Starting palette. |
| `seeds` | `ChromaSeeds?` | `null` | Optional custom seed colors. |
| `overrides` | `ChromaOverrides?` | `null` | Global component theme overrides. |
| `schedule` | `ChromaSchedule?` | `null` | Sun-aware daylight scheduling configuration. |
| `brandProfiles` | `List<ChromaBrandProfile>?`| `null` | Multi-brand / white-label configurations. |
| `fontFamily` | `String?` | `null` | Global font family applied to both themes. |
| `persistence` | `ThemePersistence?` | `null` | Persistent storage adapter. |
| `controller` | `ChromaThemeController?` | `null` | Optional existing controller instance. |

### `ChromaTheme` (Child Wrapper)
Alternative constructor for wrapping a subtree.
- `ChromaTheme({Key? key, required Widget child, ...})`

---

## 🎮 `ChromaThemeController`
The state management layer (ChangeNotifier) powering dynamic theme changes.

### Getters
- `mode`: Current active `ChromaThemeMode`.
- `palette`: Current active `ChromaPalette`.
- `seeds`: Current active `ChromaSeeds?`.
- `overrides`: Current active `ChromaOverrides?`.
- `schedule`: Active `ChromaSchedule?`.
- `brands`: Unmodifiable list of registered `ChromaBrandProfile`.
- `activeBrandId`: ID of the active brand profile (if any).
- `fontFamily`: Active global font family.
- `isDark`: Returns `true` if current mode is dark or amoled.
- `isHighContrast`: Returns `true` if current mode is highContrast.
- `isAmoled`: Returns `true` if current mode is amoled.
- `onThemeChanged`: Stream broadcasting every configuration change.

### Methods
- `setTheme(ChromaThemeMode mode)`: Update the active theme mode.
- `toggleThemeMode()`: Toggles between light and dark mode.
- `setPalette(ChromaPalette palette)`: Switch to one of the 22 predefined palettes.
- `nextPalette()` / `previousPalette()`: Cycle through palettes sequentially.
- `randomPalette()`: Randomly select a new palette.
- `setSeeds(ChromaSeeds seeds)`: Apply custom seed colors (switches palette to `custom`).
- `setDynamicSeed(Color primaryColor)`: Convenience to generate an entire theme from 1 primary color.
- `clearSeeds()`: Clears custom seeds and reverts to the active palette.
- `setThemeFromImage(ImageProvider provider)`: Asynchronously extracts primary colors from an image.
- `setSchedule(ChromaSchedule? schedule)`: Set or clear daylight time schedule.
- `registerBrand(ChromaBrandProfile brand)`: Register a brand profile.
- `setBrand(String brandId)`: Activate a registered brand profile.
- `setFontFamily(String? fontFamily)`: Dynamically update font family.
- `setOverrides(ChromaOverrides? overrides)`: Dynamically update component overrides.

---

## 🎨 Palettes & Registry

### `ChromaPalette` (Enum)
22 handcrafted palettes:
- `mono`, `blue`, `emerald`
- `mintLatte`, `neonForest`, `emeraldRoad`, `colonialNature`
- `oceanSignal`, `midnightMint`, `softOcean`, `colonialWaterloo`
- `berryBlush`, `raisinCaramel`, `royalBerry`, `noirMauve`, `softMauve`
- `blackMetal`, `onyxSpring`, `midnightChrysocolla`, `khakiSlate`, `armyCoral`
- `iceLatte`, `uniformPalesun`
- `custom`: Special indicator when seeds are active.

### `PaletteRegistry`
- `PaletteRegistry.get(ChromaPalette palette)`: Returns `PaletteEntry?`.
- `PaletteRegistry.registerCustom(ChromaPalette palette, PaletteEntry entry)`: Register your own runtime palette.

### `PaletteEntry`
Holds builders for each mode:
```dart
class PaletteEntry {
  final ColorScheme Function() light;
  final ColorScheme Function() dark;
  final ColorScheme Function() highContrast;
}
```

---

## 🧩 Drop-in Ready-Made UI Widgets

### `ChromaThemeToggle`
A segmented button control for switching theme modes:
```dart
const ChromaThemeToggle({
  Key? key,
  List<ChromaThemeMode> modes = const [
    ChromaThemeMode.light,
    ChromaThemeMode.dark,
    ChromaThemeMode.amoled,
  ],
})
```

### `ChromaPaletteSelector`
A horizontal scrollable swatch selector displaying all 22 palettes:
```dart
const ChromaPaletteSelector({
  Key? key,
  double size = 42.0,
})
```

### `showChromaThemeSheet(BuildContext context)`
Opens a modal bottom sheet displaying the current mode, toggle buttons, and palette selectors.

---

## 🏢 Multi-Brand & Scheduling

### `ChromaBrandProfile`
Represents a white-label brand configuration:
```dart
class ChromaBrandProfile {
  final String id;
  final String name;
  final ChromaPalette palette;
  final ChromaSeeds? seeds;
  final String? fontFamily;
  final ChromaOverrides? overrides;
}
```

### `ChromaSchedule`
Sun-aware schedule based on `TimeOfDay`:
```dart
class ChromaSchedule {
  final TimeOfDay lightTime;
  final TimeOfDay darkTime;
  final ChromaThemeMode darkTargetMode; // amoled or dark
}
```

---

## ♿ WCAG 2.1 Accessibility Auditor

### `ChromaAuditor`
```dart
final ChromaAuditResult result = ChromaAuditor.audit(colorScheme);
```

- `result.isAccessible`: True if all core text/background pairs pass AA normal (>= 4.5:1).
- `result.aaNormalPassRate`: Percentage of pairs passing AA normal text.
- `result.pairs`: Detailed list of `ChromaContrastPair` (ratio, passesAANormal, passesAALarge, passesAAA).

---

## 📤 Theme Exporter

### `ChromaThemeExporter`
Generates standalone, copy-pasteable pure Flutter Dart code:
```dart
String dartCode = ChromaThemeExporter.exportToDart(
  scheme: colorScheme,
  themeName: 'AppTheme',
  isDark: false,
);
```

---

## 🛠️ BuildContext Extensions

| Extension | Return Type | Description |
| :--- | :--- | :--- |
| `context.chroma` | `ChromaThemeController` | Access controller for mode & palette changes. |
| `context.chromaColors` | `ColorScheme` | Current active Material 3 ColorScheme. |
| `context.chromaPrimary` | `Color` | Current primary color. |
| `context.chromaSecondary` | `Color` | Current secondary color. |
| `context.chromaSurface` | `Color` | Current surface color. |
| `context.chromaText` | `TextTheme` | Current active TextTheme. |
| `context.chromaTones` | `ChromaTones` | Cached Material 3 tonal palettes (0-100). |
| `context.isDarkMode` | `bool` | True if the active brightness is dark. |
| `context.toggleTheme()` | `void` | Toggles between Light and Dark mode. |

---

## 💾 Persistence

### `ThemePersistence`
Abstract interface to persist settings into SharedPreferences, Hive, or disk:
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
