# Chroma Theme Usage Guide 🚀

Master the art of dynamic theming in Flutter. This guide covers common patterns and best practices for using **Chroma Theme**.

---

## 🚦 Choosing Your Strategy

### 1. The "Designer's Choice" (Predefined Palettes)
Best for most apps. Use our curated palettes to ensure perfect color harmony without any effort.

```dart
// Switch to a premium palette instantly
context.chroma.setPalette(ChromaPalette.oceanSignal);
```

### 2. The "Brand Identity" (Custom Seeds)
Best when you have specific brand colors or allow users to pick their own primary color.

```dart
context.chroma.setSeeds(
  const ChromaSeeds(
    primary: Color(0xFF23A9BD),
    secondary: Color(0xFFFBFC09),
    neutral: Color(0xFF122837),
  ),
);
```

> [!TIP]
> **Priority Rule:** If `seeds` are provided, they override the selected `palette`. To go back to palettes, call `context.chroma.clearSeeds()`.

---

## 🌑 Mastering Dark & AMOLED Modes

Chroma Theme handles transitions between light and dark modes automatically. 

### Forced Modes vs. System
- Use `ChromaThemeMode.system` to respect OS settings.
- Use `ChromaThemeMode.amoled` for battery-saving pure black backgrounds.

### AMOLED-Specific Colors
To prevent "muddy" or "grayish" looks on OLED screens, use `neutralDark` in your seeds:

```dart
ChromaSeeds(
  primary: Colors.blue,
  neutralDark: Color(0xFF000000), // Ensures pure black backgrounds in AMOLED mode
)
```

---

## 🛠️ Global Component Tuning

Instead of cluttering your widget tree with `Theme` widgets, use `ChromaOverrides` at the root. This ensures every `Card`, `AppBar`, and `Button` looks consistent across the whole app.

```dart
ChromaTheme(
  overrides: ChromaOverrides(
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
    ),
    cardTheme: CardThemeData(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
  ),
  child: const MyApp(),
)
```

---

## 💎 Accessing Tonal Palettes

Material 3 uses **Tonal Palettes** (shades from 0 to 100) to build its ColorScheme. Chroma Theme gives you direct access to these palettes.

```dart
final primary50 = context.chromaTones.primary[50];
final secondary90 = context.chromaTones.secondary[90];
```

| Tone | Description |
| :--- | :--- |
| `0` | Pure Black |
| `40` | Standard Primary |
| `90` | Light Surface Accent |
| `100` | Pure White |

---

## 💾 Saving User Preferences

To make theme settings stick after an app restart, implement the `ThemePersistence` interface using your favorite storage engine (Hive, Shared Preferences, etc.).

### Example Implementation (Shared Preferences)
```dart
class ThemeStorage implements ThemePersistence {
  @override
  Future<void> saveThemeMode(ChromaThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('theme_mode', mode.name);
  }
  
  // Implement other methods (load, savePalette, etc.)
}
```

---

## 📱 Visualizing Your Theme

Check out the `example/` folder in the repository. It contains a full-featured "Theme Playground" where you can:
- Live-preview all 20+ palettes.
- Test custom seed combinations.
- Inspect every generated M3 color token.
- Toggle between all 5 theme modes.
