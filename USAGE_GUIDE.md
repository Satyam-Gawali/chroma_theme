# Chroma Theme Usage Guide 🚀

Master dynamic theming, accessibility, and modern Material 3 architecture in Flutter with **Chroma Theme 2.0**.

---

## 🏗️ 1. Modern Architecture: The Builder Pattern

In Chroma Theme 2.0, the recommended setup pattern is `ChromaTheme.builder`. It exposes `theme`, `darkTheme`, and `themeMode` directly to your root `MaterialApp`, ensuring that Flutter's internal routing, MediaQuery, and hero animations function without conflicts.

```dart
import 'package:flutter/material.dart';
import 'package:chroma_theme/chroma_theme.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChromaTheme.builder(
      initialMode: ChromaThemeMode.system,
      initialPalette: ChromaPalette.emerald,
      builder: (context, theme, darkTheme, themeMode) {
        return MaterialApp(
          title: 'My App',
          theme: theme,
          darkTheme: darkTheme,
          themeMode: themeMode,
          home: const HomeScreen(),
        );
      },
    );
  }
}
```

---

## 🎨 2. Choosing Your Theming Strategy

### Strategy A: Designer's Choice (Predefined Palettes)
Ideal for standard applications. Pick from 22 designer-curated palettes:

```dart
// Switch palette instantly
context.chroma.setPalette(ChromaPalette.oceanSignal);

// Or cycle through them
context.chroma.nextPalette();
context.chroma.randomPalette();
```

### Strategy B: Brand Identity (Dynamic Seeds)
Generate an entire theme from your brand's core colors:

```dart
// Quick single-color generation:
context.chroma.setDynamicSeed(const Color(0xFF6750A4));

// Or granular multi-seed control:
context.chroma.setSeeds(
  const ChromaSeeds(
    primary: Color(0xFF00A19B),
    secondary: Color(0xFFE4DDD3),
    neutralLight: Color(0xFFF5F1EA),
    neutralDark: Color(0xFF0C1413),
  ),
);
```

> [!TIP]
> If custom seeds are set, calling `context.chroma.clearSeeds()` immediately reverts back to the last active curated palette.

---

## 🖼️ 3. Dynamic Theming From Images

Extract a cohesive Material 3 theme dynamically from any image provider (album art, brand logos, user avatars):

```dart
// Network image:
await context.chroma.setThemeFromImage(
  const NetworkImage('https://picsum.photos/400/400'),
);

// Asset image:
await context.chroma.setThemeFromImage(
  const AssetImage('assets/images/header.jpg'),
);
```

---

## 🌑 4. Mastering AMOLED & High-Contrast Modes

Chroma Theme includes dedicated support for OLED displays and accessibility:

### AMOLED Mode
Unlike basic dark modes that use dark gray, `ChromaThemeMode.amoled` forces true `#000000` surfaces for maximum OLED battery savings, while preserving your brand's primary and secondary accents.

```dart
context.chroma.setTheme(ChromaThemeMode.amoled);
```

### High-Contrast Mode
`ChromaThemeMode.highContrast` enhances borders, surfaces, and text contrast for maximum visibility and accessibility.

```dart
context.chroma.setTheme(ChromaThemeMode.highContrast);
```

---

## 🧩 5. Drop-in UI Widgets

Build clean, reactive settings screens without writing custom controls:

### 1-Line Modal Theme Sheet
```dart
IconButton(
  icon: const Icon(Icons.palette_outlined),
  onPressed: () => showChromaThemeSheet(context),
)
```

### In-Page Theme Toggle
```dart
// Renders Light, Dark, AMOLED toggle buttons
const ChromaThemeToggle()
```

### Palette Swatch Grid/List
```dart
// Horizontal color swatches for all 22 palettes
const ChromaPaletteSelector(size: 40.0)
```

---

## ⏰ 6. Sun-Aware / Scheduled Theming

Automatically adapt theme modes according to daylight hours:

```dart
ChromaTheme.builder(
  schedule: const ChromaSchedule(
    lightTime: TimeOfDay(hour: 6, minute: 30), // Sunrise
    darkTime: TimeOfDay(hour: 19, minute: 0),  // Sunset
    darkTargetMode: ChromaThemeMode.amoled,     // Use AMOLED at night
  ),
  builder: (context, theme, darkTheme, themeMode) => MaterialApp(/* ... */),
)
```

---

## 🏢 7. Multi-Brand & White-Label Theming

If your app serves multiple clients or brands, configure them with `ChromaBrandProfile`:

```dart
final controller = ChromaThemeController(
  brands: const [
    ChromaBrandProfile(
      id: 'brand_fintech',
      name: 'Fintech Pro',
      palette: ChromaPalette.blue,
      fontFamily: 'Inter',
    ),
    ChromaBrandProfile(
      id: 'brand_eco',
      name: 'Eco Green',
      palette: ChromaPalette.emerald,
      fontFamily: 'Poppins',
    ),
  ],
);

// Switch brand with 1 call:
controller.setBrand('brand_eco');
```

---

## ♿ 8. WCAG 2.1 Accessibility Auditing

Verify your color choices in unit tests or at runtime:

```dart
final audit = ChromaAuditor.audit(context.chromaColors);

if (!audit.isAccessible) {
  for (final failed in audit.failingAAPairs) {
    debugPrint('Contrast Warning: ${failed.foregroundRole} on ${failed.backgroundRole} ratio is ${failed.ratio.toStringAsFixed(2)}:1');
  }
}
```

---

## 📤 9. Exporting Themes to Pure Dart Code

Need to share your theme or use it in an isolated project without package dependencies? Export it directly:

```dart
final code = ChromaThemeExporter.exportToDart(
  scheme: context.chromaColors,
  themeName: 'AppCustomTheme',
  isDark: context.isDarkMode,
);

// Outputs complete ThemeData and ColorScheme ready for production!
```

---

## 🏛️ 10. Global Component Overrides

Style Material components globally once at the root:

```dart
ChromaTheme.builder(
  overrides: ChromaOverrides(
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
    ),
    cardTheme: CardThemeData(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
      ),
    ),
  ),
  builder: (context, theme, darkTheme, themeMode) => MaterialApp(/* ... */),
)
```

---

## 💾 11. Theme Persistence (SharedPreferences Example)

Save settings across app restarts:

```dart
class MyStorage implements ThemePersistence {
  final SharedPreferences prefs;
  MyStorage(this.prefs);

  @override
  Future<void> saveThemeMode(ChromaThemeMode mode) async =>
      prefs.setString('theme_mode', mode.name);

  @override
  Future<ChromaThemeMode?> loadThemeMode() async {
    final val = prefs.getString('theme_mode');
    return val != null ? ChromaThemeMode.values.byName(val) : null;
  }

  @override
  Future<void> savePalette(ChromaPalette palette) async =>
      prefs.setString('palette', palette.name);

  @override
  Future<ChromaPalette?> loadPalette() async {
    final val = prefs.getString('palette');
    return val != null ? ChromaPalette.values.byName(val) : null;
  }

  @override
  Future<void> saveSeeds(ChromaSeeds? seeds) async {
    if (seeds == null) {
      prefs.remove('primary_seed');
    } else if (seeds.primary != null) {
      prefs.setInt('primary_seed', seeds.primary!.toARGB32());
    }
  }

  @override
  Future<ChromaSeeds?> loadSeeds() async {
    final val = prefs.getInt('primary_seed');
    return val != null ? ChromaSeeds.fromPrimary(Color(val)) : null;
  }
}
```
