# Document 3: Features & Strategic Roadmap

## 1. Feature Overview
This document specifies the core features for Chroma Theme 2.0 and the future roadmap that positions it as the premier Material 3 theming library for Flutter.

---

## 2. Core Features & Superpowers (v2.0 Deliverables)

### 2.1. 22 Handcrafted Color Palettes
Every palette comes with Light, Dark, and High-Contrast definitions:
1. `blue`, 2. `mono`, 3. `emerald`, 4. `mintLatte`, 5. `berryBlush`, 6. `raisinCaramel`, 7. `khakiSlate`, 8. `armyCoral`, 9. `neonForest`, 10. `oceanSignal`, 11. `midnightMint`, 12. `softMauve`, 13. `colonialNature`, 14. `iceLatte`, 15. `emeraldRoad`, 16. `blackMetal`, 17. `softOcean`, 18. `royalBerry`, 19. `onyxSpring`, 20. `midnightChrysocolla`, 21. `uniformPalesun`, 22. `colonialWaterloo`, 23. `noirMauve`.

### 2.2. Five Distinct Theme Modes
| Mode | Behavior |
| :--- | :--- |
| `ChromaThemeMode.system` | Automatically syncs with operating system brightness changes. |
| `ChromaThemeMode.light` | Forces daytime light color scheme. |
| `ChromaThemeMode.dark` | Standard Material 3 dark color scheme. |
| `ChromaThemeMode.highContrast` | Accessible palette with boosted contrast and distinct borders. |
| `ChromaThemeMode.amoled` | Pure black (`#000000`) surfaces for OLED battery savings, retaining brand accents. |

### 2.3. Dynamic Multi-Seed Engine (`ChromaSeeds`)
Enables custom brand generation with granular surface control:
- `primary`: Foundation color for the scheme.
- `secondary`: Subdued accent.
- `tertiary`: Complementary pop color.
- `neutral`: Adaptive surface seed.
- `neutralLight`: Explicit light surface override.
- `neutralDark`: Explicit dark surface override.
- `neutralVariant`: Card and container border tint.
- `error`: Custom alert color.

### 2.4. Image-to-Theme Extractor (`setThemeFromImage`)
- Extracts primary seed colors from any image (album covers, logos, user profile photos).
- Automatically converts image colors into a rich Material 3 theme.
- `context.chroma.setThemeFromImage(imageProvider)`.

### 2.5. Drop-in Ready-Made UI Widgets
Pre-built UI components for instant settings screens:
- `ChromaThemeToggle`: Segmented toggle button for Light, Dark, and AMOLED.
- `ChromaPaletteSelector`: Color circle swatch selector for all 22 palettes.
- `showChromaThemeSheet(context)`: Ready-to-use modal bottom sheet with theme toggles and palette pickers in 1 line of code.

### 2.6. Sun-Aware / Scheduled Theming (`ChromaSchedule`)
- Automatically transitions between daytime light mode and nighttime dark/amoled mode based on clock time.
- Configurable sunrise/sunset times: `ChromaSchedule(lightTime: TimeOfDay(6, 0), darkTime: TimeOfDay(19, 0))`.

### 2.7. Multi-Brand & White-Label Theming (`ChromaBrandProfile`)
- Register multiple client/brand profiles in one app:
  `controller.registerBrand(ChromaBrandProfile(name: 'ClientA', palette: ChromaPalette.emerald, fontFamily: 'Inter'))`.
- Instant hot-swapping between brands: `controller.setBrand('ClientA')`.

### 2.8. WCAG Accessibility Contrast Auto-Auditor (`ChromaAuditor`)
- Evaluates `ColorScheme` against W3C WCAG 2.1 contrast formulas.
- Reports contrast ratios and pass/fail status for normal text (AA >= 4.5:1), large text (AA >= 3:1), and AAA (>= 7:1).

### 2.9. Standalone Theme Exporter (`ChromaThemeExporter`)
- Exports any active theme directly to dependency-free, pure Flutter `ThemeData` and `ColorScheme` Dart source code.

### 2.10. Material 3 Color Harmonization (`ChromaThemeUtils.harmonize`)
- Automatically blends arbitrary custom colors with the active theme's primary color so they never visually clash.

### 2.11. Global Component Overrides (`ChromaOverrides`)
Directly applies styling to key Material 3 components:
- `appBarTheme`, `cardTheme`, `elevatedButtonTheme`, `filledButtonTheme`, `outlinedButtonTheme`
- `navigationBarTheme`, `navigationRailTheme`, `bottomNavigationBarTheme`, `bottomSheetTheme`
- `inputDecorationTheme`, `floatingActionButtonTheme`, `snackBarTheme`, `searchBarTheme`, `segmentedButtonTheme`, `dialogTheme`.
