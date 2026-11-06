# Document 3: Features & Strategic Roadmap

## 1. Feature Overview
This document specifies the core features for Chroma Theme 2.0 and the future roadmap to position it as the premier Material 3 theming library for Flutter.

---

## 2. Core Features (v2.0 Deliverables)

### 2.1. 22 Handcrafted Color Palettes
Every palette comes with Light, Dark, and High-Contrast definitions:
1. `blue`
2. `mono`
3. `emerald`
4. `mintLatte`
5. `berryBlush`
6. `raisinCaramel`
7. `khakiSlate`
8. `armyCoral`
9. `neonForest`
10. `oceanSignal`
11. `midnightMint`
12. `softMauve`
13. `colonialNature`
14. `iceLatte`
15. `emeraldRoad`
16. `blackMetal`
17. `softOcean`
18. `royalBerry`
19. `onyxSpring`
20. `midnightChrysocolla`
21. `uniformPalesun`
22. `colonialWaterloo`
23. `noirMauve`

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

### 2.4. Global Component Overrides (`ChromaOverrides`)
Directly applies styling to key Material 3 components:
- `appBarTheme`
- `cardTheme`
- `elevatedButtonTheme`
- `outlinedButtonTheme` (New)
- `filledButtonTheme` (New)
- `navigationBarTheme` (New - Replaces legacy BottomNavigationBar)
- `inputDecorationTheme`
- `floatingActionButtonTheme`
- `snackBarTheme`
- `dividerTheme`
- `textTheme`

---

## 3. Future Roadmap (v2.1 & Beyond)

### Phase 2.1: Dynamic Color / Material You (Monet Integration)
- Connect with Android 12+ wallpaper seed colors (`dynamic_color`).
- Add `ChromaThemeMode.dynamic` or `useDynamicColor: true` flag.

### Phase 2.2: Built-in SharedPreferences Storage Adapter
- Provide an optional lightweight adapter package or helper class (`ChromaStorage`) that saves theme mode, active palette, and custom seeds automatically to device disk.

### Phase 2.3: Visual Theme Playground Web App
- Host a public live web demo (`chromatheme.dev` or GitHub Pages) allowing developers to:
  1. Click through all 22 palettes.
  2. Pick custom hex colors and preview full UI kits.
  3. Export ready-to-paste Flutter code.

### Phase 2.4: Code Generator / Theme Export Tool
- CLI tool to export a selected palette directly into standalone Dart code for projects that do not want runtime dependencies.
