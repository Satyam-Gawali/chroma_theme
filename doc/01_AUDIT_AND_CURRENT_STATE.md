# Document 1: Audit & Current State Analysis

## 1. Executive Summary
`chroma_theme` is a Flutter package intended to simplify Material 3 dynamic theming. It offers 22 pre-curated color palettes, 5 theme modes (light, dark, system, high contrast, amoled), custom seed-color generation (`ChromaSeeds`), tonal palette extraction (`ChromaTones`), and global component overrides (`ChromaOverrides`).

While the core concept is strong, a deep architectural and code audit reveals several critical bugs, dead code, SDK mismatch errors, and asset bloat that make the package problematic in real Flutter apps.

---

## 2. Codebase Structure
```text
chroma_theme/
├── lib/
│   ├── chroma_theme.dart                 # Package barrel exports
│   └── src/
│       ├── builder/
│       │   ├── chroma_color_scheme_builder.dart  # Generates ColorScheme from seeds/palettes
│       │   └── chroma_theme_builder.dart         # Generates ThemeData from ColorScheme
│       ├── core/
│       │   ├── chroma_theme_controller.dart      # ChangeNotifier controlling mode/palette/seeds
│       │   ├── chroma_theme_inherited.dart       # InheritedWidget for fast lookups
│       │   └── chroma_theme_widget.dart          # Root widget managing state & animations
│       ├── extensions/
│       │   └── chroma_theme_extension.dart       # BuildContext extensions (context.chroma, etc.)
│       ├── models/
│       │   ├── chroma_overrides.dart             # Component theme override data class
│       │   ├── chroma_palette.dart               # Palette enum (22 palettes + custom)
│       │   ├── chroma_seeds.dart                 # Custom seed color configuration
│       │   ├── chroma_theme_mode.dart            # Theme mode enum (system, light, dark, hc, amoled)
│       │   └── chroma_tones.dart                 # Tonal palette generation (0-100)
│       ├── palettes/                             # 22 folders for each palette
│       │   ├── [palette_name]/
│       │   │   ├── [name]_light.dart
│       │   │   ├── [name]_dark.dart
│       │   │   └── [name]_high_contrast.dart     # (Currently DEAD CODE)
│       │   ├── palette_registry.dart             # Static registry mapping enum to builders
│       │   └── palette_scheme_helpers.dart       # Internal helper functions
│       ├── services/
│       │   └── theme_persistence.dart            # Unconnected abstract interface
│       └── utils/
│           └── chroma_theme_utils.dart           # Hex conversion helpers
├── assets/                                       # 1.9 MB of promotional images
│   ├── banner.png (1.6 MB)
│   └── logo.png (320 KB)
├── example/                                      # Example app
│   ├── lib/
│   │   ├── main.dart                             # Monolithic demo app
│   │   └── screens/                              # Orphaned / duplicate dead files
│   └── pubspec.yaml                              # Has external dependency on chroma_kit
└── test/
    └── chroma_theme_test.dart                    # Only 2 basic unit tests
```

---

## 3. Detailed Audit Findings & Issues

### Issue 1: `MaterialApp` Nesting & Theme Shadowing Bug (Critical)
* **Location:** `lib/src/core/chroma_theme_widget.dart` (lines 105–123)
* **Problem:** 
  The widget checks `widget.child is MaterialApp`.
  - When a developer wraps `ChromaTheme(child: MyApp())`, `MyApp` is a `StatelessWidget`, so `widget.child is MaterialApp` evaluates to `false`.
  - ChromaTheme wraps `MyApp` inside its own `MaterialApp`.
  - Inside `MyApp`, the developer defines another `MaterialApp`. This creates **nested MaterialApps**, corrupting routing, Navigator, Dialogs, and MediaQuery.
  - Furthermore, in Flutter, an ancestor `Theme`/`AnimatedTheme` placed *above* a `MaterialApp` does not penetrate inside it, because `MaterialApp` creates its own fallback theme internally.
* **Impact:** Broken theming and navigation for any standard Flutter application.

---

### Issue 2: All 22 High-Contrast Palettes are Dead Code (Critical)
* **Location:** `lib/src/palettes/palette_registry.dart` & `lib/src/builder/chroma_color_scheme_builder.dart`
* **Problem:**
  - 22 `_high_contrast.dart` files exist with accessible color schemes.
  - However, `PaletteRegistry` only registers `(Brightness brightness)`, ignoring High Contrast.
  - In `ChromaColorSchemeBuilder.build()`, if `mode == ChromaThemeMode.highContrast`, it immediately returns a generic hardcoded black-and-white scheme (`_highContrastScheme()`).
* **Impact:** The 22 high-contrast palettes are never imported or executed anywhere.

---

### Issue 3: AMOLED Mode Discards Selected Palette
* **Location:** `lib/src/builder/chroma_color_scheme_builder.dart` (lines 44–46)
* **Problem:**
  When `mode == ChromaThemeMode.amoled`, the builder returns `_amoledScheme()`. This replaces the user's selected palette with a generic fallback scheme, rather than preserving the palette's primary/secondary accents and making surfaces pure black (`#000000`).
* **Impact:** Choosing AMOLED mode breaks the active palette color identity.

---

### Issue 4: Invalid Dart & Flutter SDK Constraints
* **Location:** `pubspec.yaml` (lines 13–15)
* **Problem:**
  - `sdk: ^3.11.1` – Dart 3.11 does not exist on stable releases. Users running standard Flutter/Dart fail pub dependency resolution.
  - `flutter: ">=1.17.0"` – Flutter 1.17 is incompatible with Material 3 APIs used in the code (`Color.r`, `Color.withValues()`, `Color.toARGB32()`, `surfaceContainerLowest`).
* **Impact:** Package cannot be installed or compiled on older Flutter versions, while modern versions complain about nonexistent Dart 3.11.

---

### Issue 5: Asset Bloat in Published Package
* **Location:** `pubspec.yaml` (lines 26–29)
* **Problem:**
  `assets/banner.png` (1.6 MB) and `assets/logo.png` (320 KB) are included in the package's `flutter: assets:` section.
* **Impact:** Every Flutter app importing `chroma_theme` gets an extra ~1.9 MB of promotional images forced into their production APK/IPA.

---

### Issue 6: Disconnected `ThemePersistence`
* **Location:** `lib/src/services/theme_persistence.dart`
* **Problem:**
  `ThemePersistence` is defined as an abstract interface, but neither `ChromaTheme` nor `ChromaThemeController` takes or calls any persistence instance.
* **Impact:** The README promises persistent theme settings, but developers must write all wiring themselves.

---

### Issue 7: Inaccurate M3 Tonal Generation (`ChromaTones`)
* **Location:** `lib/src/models/chroma_tones.dart`
* **Problem:**
  Uses naive `HSLColor` manipulation (`withLightness(tone / 100.0)`) instead of Material 3's perceptual **HCT** (Hue, Chroma, Tone) space via `material_color_utilities`. Also, `context.chromaTones` recalculates 78 color tones on every invocation without caching.
* **Impact:** Color distortion on yellow/cyan/red tones and frame rate drops during widget rebuilds.

---

### Issue 8: Unused Dead Code in `example/`
* **Location:** `example/lib/screens/`
* **Problem:**
  The `example/lib/screens/` directory contains 5 files that are never imported by `example/lib/main.dart`. One of them imports `chroma_kit`, adding an unnecessary third-party dependency in `example/pubspec.yaml`.
* **Impact:** Confusion and code bloat in the example repository.

---

### Issue 9: Minimal Unit Test Coverage
* **Location:** `test/chroma_theme_test.dart`
* **Problem:**
  Only 2 trivial unit tests exist. Zero tests for builder logic, palette registry, overrides, or widget tree integration.
