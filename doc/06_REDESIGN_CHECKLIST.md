# 📋 Chroma Theme 2.0 - Master Redesign Checklist

This master checklist tracks every concrete task, file affected, status, and verification step for the complete redesign of **Chroma Theme 2.0**.

---

## 📊 Overall Progress Summary
- **Total Tasks:** 32
- **Completed:** 13
- **In Progress:** 0
- **Pending:** 19

---

## 📦 Phase 1: Package Metadata, Configuration & Bloat Cleanup
*Target: Fix versioning, eliminate 1.9MB asset bloat, configure pub publishing rules.*

- [x] **Task 1.1:** Fix `pubspec.yaml` environment SDK versions  
  - **File:** `pubspec.yaml`  
  - **Change:** Set `sdk: ">=3.3.0 <4.0.0"` and `flutter: ">=3.27.0"`.  
  - **Verification:** Run `dart pub get` with zero errors.

- [x] **Task 1.2:** Remove promotional asset entries from package configuration  
  - **File:** `pubspec.yaml`  
  - **Change:** Remove `flutter: assets: - assets/banner.png - assets/logo.png`.  
  - **Verification:** Ensure images remain in `assets/` on disk for GitHub README, but are omitted from package bundling.

- [x] **Task 1.3:** Create `.pubignore` file  
  - **File:** `.pubignore`  
  - **Change:** Add rules ignoring `assets/`, `screenshots/`, `doc/`, `.idea/`, `example/build/`.  
  - **Verification:** Run `dart pub publish --dry-run` to verify published package size is <50 KB.

- [x] **Task 1.4:** Update `analysis_options.yaml`  
  - **File:** `analysis_options.yaml`  
  - **Change:** Ensure strict lint rules (`prefer_const_constructors`, `avoid_print`, etc.).  
  - **Verification:** Zero static analyzer errors.

---

## 🎨 Phase 2: Palette Registry & Dead Code Activation
*Target: Connect all 22 High-Contrast palettes, fix AMOLED color wipe.*

- [x] **Task 2.1:** Create `PaletteEntry` data model  
  - **File:** `lib/src/palettes/palette_registry.dart`  
  - **Change:** Define `PaletteEntry` with `ColorScheme Function() light`, `dark`, and `highContrast`.

- [x] **Task 2.2:** Register all 22 Palettes in `PaletteRegistry`  
  - **File:** `lib/src/palettes/palette_registry.dart`  
  - **Change:** Connect `...LightScheme()`, `...DarkScheme()`, and `...HighContrastScheme()` for all 22 palettes.  
  - **Verification:** Zero unused `_high_contrast.dart` files across the codebase.

- [x] **Task 2.3:** Overhaul `ChromaColorSchemeBuilder` for High-Contrast  
  - **File:** `lib/src/builder/chroma_color_scheme_builder.dart`  
  - **Change:** Route `ChromaThemeMode.highContrast` to the active palette's `entry.highContrast()`. Fall back to high-contrast seed adjustment only when seeds are active.

- [x] **Task 2.4:** Overhaul `ChromaColorSchemeBuilder` for AMOLED  
  - **File:** `lib/src/builder/chroma_color_scheme_builder.dart`  
  - **Change:** Preserve the active palette's primary/secondary/tertiary colors and turn surfaces into pure black (`#000000`).  
  - **Verification:** Switching to AMOLED keeps brand accents intact without falling back to generic dark scheme.

- [x] **Task 2.5:** Add runtime Custom Palette Registration  
  - **File:** `lib/src/palettes/palette_registry.dart`  
  - **Change:** Expose `PaletteRegistry.registerCustom(...)` to allow developers to supply custom palette entries dynamically.

---

## 🏗️ Phase 3: Core Architecture Redesign (Builder Pattern)
*Target: Eliminate nested MaterialApp bug, build solid state management.*

- [x] **Task 3.1:** Redesign `ChromaTheme.builder` primary constructor  
  - **File:** `lib/src/core/chroma_theme_widget.dart`  
  - **Change:** Provide `ChromaTheme.builder(builder: (context, theme, darkTheme, themeMode) => ...)` and clean `child:` alternative.  
  - **Verification:** Remove all `widget.child is MaterialApp` conditionals.

- [x] **Task 3.2:** Upgrade `ChromaThemeController`  
  - **File:** `lib/src/core/chroma_theme_controller.dart`  
  - **Change:** Add persistence hook, cached `ThemeData` generation, and safe stream lifecycle handling.

- [x] **Task 3.3:** Upgrade `ChromaOverrides` for Modern Material 3  
  - **File:** `lib/src/models/chroma_overrides.dart` & `lib/src/builder/chroma_theme_builder.dart`  
  - **Change:** Add `navigationBarTheme`, `outlinedButtonTheme`, `filledButtonTheme`, `searchBarTheme`.  
  - **Verification:** Pass overrides to `ThemeData` in `ChromaThemeBuilder`.

- [x] **Task 3.4:** Implement `ThemePersistence` integration  
  - **File:** `lib/src/core/chroma_theme_controller.dart` & `lib/src/services/theme_persistence.dart`  
  - **Change:** Accept optional `persistence` parameter in controller and widget, auto-loading saved settings on initialization and auto-saving on state change.

---

## ⚡ Phase 4: Performance & Utilities Refinement
*Target: Cache tonal palettes and eliminate re-calculation jank.*

- [ ] **Task 4.1:** Refactor `ChromaTones`  
  - **File:** `lib/src/models/chroma_tones.dart`  
  - **Change:** Cache tonal palettes per `ColorScheme`. Improve lightness/contrast mapping.

- [ ] **Task 4.2:** Optimize `context.chromaTones` extension  
  - **File:** `lib/src/extensions/chroma_theme_extension.dart`  
  - **Change:** Read cached tones from the controller instead of regenerating 78 colors on every build call.

- [ ] **Task 4.3:** Verify and harden `ChromaThemeUtils`  
  - **File:** `lib/src/utils/chroma_theme_utils.dart`  
  - **Change:** Ensure Hex string parser handles `#RGB`, `#RRGGBB`, and `#AARRGGBB` safely without crashing.

---

## 🧹 Phase 5: Example App & Cleanup
*Target: Remove orphan files, remove unused dependencies, modernize playground.*

- [ ] **Task 5.1:** Clean `example/lib/screens/` dead files  
  - **Directory:** `example/lib/screens/`  
  - **Change:** Remove unused, duplicate screen files.

- [ ] **Task 5.2:** Remove `chroma_kit` dependency from example  
  - **File:** `example/pubspec.yaml`  
  - **Change:** Remove `chroma_kit: ^1.1.0`.

- [ ] **Task 5.3:** Refactor `example/lib/main.dart` with `ChromaTheme.builder`  
  - **File:** `example/lib/main.dart`  
  - **Change:** Update demo app to demonstrate `ChromaTheme.builder`, all 5 modes, and all 22 palettes interactively.

---

## 🧪 Phase 6: Unit & Widget Testing
*Target: Achieve robust test coverage (>85%).*

- [ ] **Task 6.1:** Unit tests for `ChromaThemeController`  
  - **File:** `test/chroma_theme_controller_test.dart`  
  - Mode switching, palette switching, seed clear/set, streams.

- [ ] **Task 6.2:** Unit tests for `ChromaColorSchemeBuilder`  
  - **File:** `test/chroma_color_scheme_builder_test.dart`  
  - Test all 5 modes, AMOLED pure black check, High-Contrast token check.

- [ ] **Task 6.3:** Unit tests for `PaletteRegistry`  
  - **File:** `test/palette_registry_test.dart`  
  - Verify all 22 palettes exist with non-null light, dark, and high-contrast schemes.

- [ ] **Task 6.4:** Unit tests for `ChromaSeeds` priority  
  - **File:** `test/chroma_seeds_test.dart`  
  - Verify custom seeds override palettes correctly.

- [ ] **Task 6.5:** Widget tests for `ChromaTheme.builder`  
  - **File:** `test/chroma_theme_widget_test.dart`  
  - Verify widget tree building, theme application, and rebuilds on controller change.

---

## 📖 Phase 7: Documentation & Release Polish
*Target: Perfect documentation for pub.dev score.*

- [ ] **Task 7.1:** Update `README.md` with Chroma Theme 2.0 Builder API  
- [ ] **Task 7.2:** Update `CHANGELOG.md` for v2.0.0 breaking change notes  
- [ ] **Task 7.3:** Update `API.md` and `USAGE_GUIDE.md`  
- [ ] **Task 7.4:** Run `dart pub publish --dry-run` and verify 140/140 pub points readiness  
