# Changelog

All notable changes to `chroma_theme` will be documented in this file.

## 2.0.0 - Chroma Theme 2.0 Architectural Overhaul 🚀

### 💥 Breaking Changes
- The recommended pattern for application setup is now `ChromaTheme.builder` which cleanly exposes `(context, theme, darkTheme, themeMode)` to `MaterialApp`, eliminating nested MaterialApp and Navigator routing conflicts.
- Minimum Flutter SDK requirement is updated to `>=3.27.0` (Dart SDK `>=3.3.0 <4.0.0`).

### ✨ Flagship Superpowers & Features
- **`ChromaTheme.builder`**: Native builder constructor that manages and injects light and dark `ThemeData` along with `ThemeMode` directly into `MaterialApp`.
- **Complete 44 Material 3 Roles**: Full support for all 44 M3 color tokens across palettes and dynamic seeds, including `primaryFixed`, `secondaryFixed`, `tertiaryFixed`, `onFixedVariant`, `surfaceDim`, and `surfaceBright`.
- **Pure AMOLED with Accent Preservation**: AMOLED mode now transforms surfaces to true `#000000` while preserving the active palette's brand primary and secondary accent colors instead of washing them out.
- **22 High-Contrast Palettes Registered**: Wired all 22 high-contrast palettes into `PaletteRegistry` using the new `PaletteEntry` model.
- **Image-to-Theme Extractor (`setThemeFromImage`)**: Extract primary and accent seeds directly from album covers, logos, or photos via `controller.setThemeFromImage(imageProvider)`.
- **Drop-in UI Widgets**:
  - `ChromaThemeToggle`: Pre-built toggle button for switching between Light, Dark, and AMOLED modes.
  - `ChromaPaletteSelector`: Swatch circle selector for picking between all 22 palettes.
  - `showChromaThemeSheet(context)`: Ready-to-use modal bottom sheet with complete theme controls in one line of code.
- **Sun-Aware Theming (`ChromaSchedule`)**: Automatically switch between day and night theme modes based on wall-clock sunrise/sunset times.
- **Multi-Brand & White-Label (`ChromaBrandProfile`)**: Register and switch between different brand profiles with custom palettes and fonts at runtime.
- **WCAG 2.1 Accessibility Auto-Auditor (`ChromaAuditor`)**: W3C contrast ratio validator calculating AA and AAA compliance for all text/background pairs.
- **Standalone Theme Exporter (`ChromaThemeExporter`)**: Export any active theme directly into dependency-free, pure Flutter `ThemeData` and `ColorScheme` Dart source code.
- **Performance & Tone Caching**: Optimized `ChromaTones` using `Expando` caching per `ColorScheme` to eliminate 78-tone recalculation overhead during UI animations.
- **Expanded `ChromaOverrides`**: Added support for `bottomSheetTheme`, `navigationBarTheme`, `dialogTheme`, `tabBarTheme`, `switchTheme`, `checkboxTheme`, `radioTheme`, `filledButtonTheme`, `outlinedButtonTheme`, and `segmentedButtonTheme`.
- **New BuildContext Extensions**: Added `context.chromaPrimary`, `context.chromaSecondary`, `context.chromaSurface`, and `context.toggleTheme()`.

### 🧹 Cleanups & Quality
- Added `.pubignore` and removed promotional images from package publishing bundle, reducing package size from 1.9MB to <50KB.
- Cleaned example app: deleted dead duplicate screens and removed external `chroma_kit` dependency.
- Added 12 comprehensive unit and widget test suites covering controllers, builders, palettes, accessibility auditor, exporter, scheduler, and drop-in widgets.

---

## 1.1.0+3

- Fixed README documentation links for better pub.dev compatibility.
- Streamlined installation example in README.

## 1.1.0+2

- Updated image assets to absolute GitHub URLs for better documentation rendering on pub.dev.
- Professionalized README branding with improved logo/title alignment.

## 1.1.0

- Added 20+ curated predefined palettes including Neon Forest, Ocean Signal, Midnight Mint, Royal Berry, and more.
- Improved palette surface generation for cleaner (less muddy) neutral surfaces.
- Added full ColorScheme visualization upgrades in the example app (including neutralVariant tones and state-layer previews).
- Expanded settings UI to list and select all predefined palettes.
- Added `neutralVariant` in `ChromaTones` for fuller Material 3 tonal coverage.
- Improved controller/theme integration behavior.

## 0.0.1

- Initial release.
