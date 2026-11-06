# Document 4: Step-by-Step Implementation Plan

## Overview
This document outlines the actionable, phased engineering tasks required to execute the Chroma Theme 2.0 redesign safely without regression.

---

## Phase 1: Package Metadata & Bloat Cleanup
* **Goal:** Eliminate package bloat, fix SDK versions, and ensure clean publishing.

- [ ] **1.1. Fix `pubspec.yaml` environment constraints:**
  - Update `sdk: ">=3.3.0 <4.0.0"`
  - Update `flutter: ">=3.27.0"`
- [ ] **1.2. Remove asset bloat:**
  - Remove `assets/banner.png` and `assets/logo.png` from package `pubspec.yaml`'s `flutter: assets:` section.
  - Keep files in git for README rendering via GitHub raw links.
- [ ] **1.3. Create `.pubignore` file:**
  - Exclude `assets/`, `screenshots/`, `doc/`, `example/build/`, `.idea/`, `.vscode/` from pub.dev packaging to keep download size tiny (<50 KB).

---

## Phase 2: Palette Registry & Dead Code Activation
* **Goal:** Connect all 22 high-contrast palettes and preserve palette accents in AMOLED mode.

- [ ] **2.1. Update `PaletteRegistry`:**
  - Refactor registration to take `PaletteEntry` with `light`, `dark`, and `highContrast` schemes.
  - Register all 22 palettes with their respective `...LightScheme()`, `...DarkScheme()`, and `...HighContrastScheme()`.
- [ ] **2.2. Overhaul `ChromaColorSchemeBuilder`:**
  - In `highContrast` mode, look up the selected palette's `entry.highContrast()`. Fall back to high-contrast seeds if seeds are active.
  - In `amoled` mode, take the active palette's dark scheme and apply pitch black `#000000` surface overrides while preserving primary/secondary/tertiary colors.

---

## Phase 3: Core Architecture Redesign (Builder Pattern)
* **Goal:** Eliminate nested `MaterialApp` bugs and provide a seamless developer experience.

- [ ] **3.1. Update `ChromaThemeController`:**
  - Add optional `ThemePersistence` parameter.
  - Add methods for `setCustomPalette(...)`, `setThemeMode(...)`, `setPalette(...)`, `setSeeds(...)`.
  - Add theme caching to prevent rebuilding `ThemeData` when unnecessary.
- [ ] **3.2. Redesign `ChromaTheme` Widget:**
  - Support `ChromaTheme.builder(...)` as the primary constructor.
  - Support `ChromaTheme(...)` with `child:` for subtrees or existing apps with `AnimatedTheme`.
  - Remove hardcoded `MaterialApp` injection.
- [ ] **3.3. Upgrade `ChromaOverrides`:**
  - Add modern Material 3 properties (`navigationBarTheme`, `outlinedButtonTheme`, `filledButtonTheme`, `searchBarTheme`).

---

## Phase 4: Performance & Utilities Refinement
* **Goal:** Optimize tonal calculations and utility functions.

- [ ] **4.1. Refactor `ChromaTones`:**
  - Cache generated tones inside the active controller.
  - Use proper perceptual luminance formulas or `material_color_utilities` to calculate tones accurately.
- [ ] **4.2. Update `ChromaThemeUtils`:**
  - Verify Hex parsing and conversion safety across platforms.

---

## Phase 5: Example App & Clean Repository
* **Goal:** Clean up dead files and create an interactive showcase.

- [ ] **5.1. Delete unreferenced files in `example/lib/screens/`:**
  - Clean up dead duplicate files.
  - Remove unused `chroma_kit` dependency from `example/pubspec.yaml`.
- [ ] **5.2. Structure `example/` cleanly:**
  - Separate tabs into dedicated, clean files.
  - Ensure interactive palette switching, mode toggling, and seed picker work smoothly.

---

## Phase 6: Comprehensive Testing & Verification
* **Goal:** Ensure high test coverage and zero analysis issues.

- [ ] **6.1. Unit Tests:**
  - Test `ChromaThemeController` state changes and stream broadcasts.
  - Test `ChromaColorSchemeBuilder` across all 5 modes for each palette.
  - Test `ChromaSeeds` priority over palettes.
  - Test `ChromaOverrides` merging and component output.
- [ ] **6.2. Widget Tests:**
  - Test `ChromaTheme.builder` widget mounting and theme mode switching.
- [ ] **6.3. Static Analysis:**
  - Verify `flutter analyze` passes with zero errors or warnings.
