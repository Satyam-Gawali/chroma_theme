## 1.1.0+2

- Updated image assets to absolute GitHub URLs for better documentation rendering on pub.dev.
- Professionalized README branding with improved logo/title alignment.

## 1.1.0

- Added 20+ curated predefined palettes including Neon Forest, Ocean Signal, Midnight Mint, Royal Berry, and more.
- Improved palette surface generation for cleaner (less muddy) neutral surfaces.
- Added full ColorScheme visualization upgrades in the example app (including neutralVariant tones and state-layer previews).
- Expanded settings UI to list and select all predefined palettes.
- Added `neutralVariant` in `ChromaTones` for fuller Material 3 tonal coverage.
- Improved controller/theme integration behavior:
  - brightness-aware dark mode check via `isDarkEffective(...)`
  - improved `didUpdateWidget` synchronization for mode/palette/seeds/overrides
  - safer handling when child is already `MaterialApp` or `CupertinoApp`
- Refreshed documentation (`README`, `API`, `USAGE_GUIDE`) for clarity and latest features.

## 0.0.1

- Initial release.
