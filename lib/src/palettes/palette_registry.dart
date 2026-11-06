import 'package:flutter/material.dart';

import '../models/chroma_palette.dart';
import 'army_coral/army_coral_dark.dart';
import 'army_coral/army_coral_high_contrast.dart';
import 'army_coral/army_coral_light.dart';
import 'berry_blush/berry_blush_dark.dart';
import 'berry_blush/berry_blush_high_contrast.dart';
import 'berry_blush/berry_blush_light.dart';
import 'black_metal/black_metal_dark.dart';
import 'black_metal/black_metal_high_contrast.dart';
import 'black_metal/black_metal_light.dart';
import 'blue/blue_dark.dart';
import 'blue/blue_high_contrast.dart';
import 'blue/blue_light.dart';
import 'colonial_nature/colonial_nature_dark.dart';
import 'colonial_nature/colonial_nature_high_contrast.dart';
import 'colonial_nature/colonial_nature_light.dart';
import 'colonial_waterloo/colonial_waterloo_dark.dart';
import 'colonial_waterloo/colonial_waterloo_high_contrast.dart';
import 'colonial_waterloo/colonial_waterloo_light.dart';
import 'emerald/emerald_dark.dart';
import 'emerald/emerald_high_contrast.dart';
import 'emerald/emerald_light.dart';
import 'emerald_road/emerald_road_dark.dart';
import 'emerald_road/emerald_road_high_contrast.dart';
import 'emerald_road/emerald_road_light.dart';
import 'ice_latte/ice_latte_dark.dart';
import 'ice_latte/ice_latte_high_contrast.dart';
import 'ice_latte/ice_latte_light.dart';
import 'khaki_slate/khaki_slate_dark.dart';
import 'khaki_slate/khaki_slate_high_contrast.dart';
import 'khaki_slate/khaki_slate_light.dart';
import 'midnight_chrysocolla/midnight_chrysocolla_dark.dart';
import 'midnight_chrysocolla/midnight_chrysocolla_high_contrast.dart';
import 'midnight_chrysocolla/midnight_chrysocolla_light.dart';
import 'midnight_mint/midnight_mint_dark.dart';
import 'midnight_mint/midnight_mint_high_contrast.dart';
import 'midnight_mint/midnight_mint_light.dart';
import 'mint_latte/mint_latte_dark.dart';
import 'mint_latte/mint_latte_high_contrast.dart';
import 'mint_latte/mint_latte_light.dart';
import 'mono/mono_dark.dart';
import 'mono/mono_high_contrast.dart';
import 'mono/mono_light.dart';
import 'neon_forest/neon_forest_dark.dart';
import 'neon_forest/neon_forest_high_contrast.dart';
import 'neon_forest/neon_forest_light.dart';
import 'noir_mauve/noir_mauve_dark.dart';
import 'noir_mauve/noir_mauve_high_contrast.dart';
import 'noir_mauve/noir_mauve_light.dart';
import 'ocean_signal/ocean_signal_dark.dart';
import 'ocean_signal/ocean_signal_high_contrast.dart';
import 'ocean_signal/ocean_signal_light.dart';
import 'onyx_spring/onyx_spring_dark.dart';
import 'onyx_spring/onyx_spring_high_contrast.dart';
import 'onyx_spring/onyx_spring_light.dart';
import 'raisin_caramel/raisin_caramel_dark.dart';
import 'raisin_caramel/raisin_caramel_high_contrast.dart';
import 'raisin_caramel/raisin_caramel_light.dart';
import 'royal_berry/royal_berry_dark.dart';
import 'royal_berry/royal_berry_high_contrast.dart';
import 'royal_berry/royal_berry_light.dart';
import 'soft_mauve/soft_mauve_dark.dart';
import 'soft_mauve/soft_mauve_high_contrast.dart';
import 'soft_mauve/soft_mauve_light.dart';
import 'soft_ocean/soft_ocean_dark.dart';
import 'soft_ocean/soft_ocean_high_contrast.dart';
import 'soft_ocean/soft_ocean_light.dart';
import 'uniform_palesun/uniform_palesun_dark.dart';
import 'uniform_palesun/uniform_palesun_high_contrast.dart';
import 'uniform_palesun/uniform_palesun_light.dart';

typedef FixedSchemeBuilder = ColorScheme Function();

/// Holds light, dark, and high-contrast builder callbacks for a single palette.
class PaletteEntry {
  final FixedSchemeBuilder light;
  final FixedSchemeBuilder dark;
  final FixedSchemeBuilder highContrast;

  const PaletteEntry({
    required this.light,
    required this.dark,
    required this.highContrast,
  });

  /// Resolves the matching ColorScheme based on brightness and high-contrast mode.
  ColorScheme resolve({
    required Brightness brightness,
    bool isHighContrast = false,
  }) {
    if (isHighContrast) {
      return highContrast();
    }
    return brightness == Brightness.dark ? dark() : light();
  }
}

class PaletteRegistry {
  PaletteRegistry._();

  static final Map<ChromaPalette, PaletteEntry> _registry = {};

  /// Registers a [PaletteEntry] for the given [palette].
  static void register(
    ChromaPalette palette,
    PaletteEntry entry,
  ) {
    _registry[palette] = entry;
  }

  /// Registers a custom palette entry dynamically.
  static void registerCustom(PaletteEntry entry) {
    _registry[ChromaPalette.custom] = entry;
  }

  /// Retrieves the registered [PaletteEntry] for [palette], or null if not registered.
  static PaletteEntry? get(ChromaPalette palette) {
    return _registry[palette];
  }

  /// Read-only map of all registered palette entries.
  static Map<ChromaPalette, PaletteEntry> get all => Map.unmodifiable(_registry);

  /// Clears custom or all registries (primarily for testing).
  @visibleForTesting
  static void reset() {
    _registry.clear();
    registerDefaultPalettes();
  }
}

/// Registers all 22 built-in palettes with Light, Dark, and High-Contrast schemes.
void registerDefaultPalettes() {
  PaletteRegistry.register(
    ChromaPalette.blue,
    const PaletteEntry(
      light: blueLightScheme,
      dark: blueDarkScheme,
      highContrast: blueHighContrastScheme,
    ),
  );
  PaletteRegistry.register(
    ChromaPalette.mono,
    const PaletteEntry(
      light: monoLightScheme,
      dark: monoDarkScheme,
      highContrast: monoHighContrastScheme,
    ),
  );
  PaletteRegistry.register(
    ChromaPalette.emerald,
    const PaletteEntry(
      light: emeraldLightScheme,
      dark: emeraldDarkScheme,
      highContrast: emeraldHighContrastScheme,
    ),
  );
  PaletteRegistry.register(
    ChromaPalette.mintLatte,
    const PaletteEntry(
      light: mintLatteLightScheme,
      dark: mintLatteDarkScheme,
      highContrast: mintLatteHighContrastScheme,
    ),
  );
  PaletteRegistry.register(
    ChromaPalette.berryBlush,
    const PaletteEntry(
      light: berryBlushLightScheme,
      dark: berryBlushDarkScheme,
      highContrast: berryBlushHighContrastScheme,
    ),
  );
  PaletteRegistry.register(
    ChromaPalette.raisinCaramel,
    const PaletteEntry(
      light: raisinCaramelLightScheme,
      dark: raisinCaramelDarkScheme,
      highContrast: raisinCaramelHighContrastScheme,
    ),
  );
  PaletteRegistry.register(
    ChromaPalette.khakiSlate,
    const PaletteEntry(
      light: khakiSlateLightScheme,
      dark: khakiSlateDarkScheme,
      highContrast: khakiSlateHighContrastScheme,
    ),
  );
  PaletteRegistry.register(
    ChromaPalette.armyCoral,
    const PaletteEntry(
      light: armyCoralLightScheme,
      dark: armyCoralDarkScheme,
      highContrast: armyCoralHighContrastScheme,
    ),
  );
  PaletteRegistry.register(
    ChromaPalette.neonForest,
    const PaletteEntry(
      light: neonForestLightScheme,
      dark: neonForestDarkScheme,
      highContrast: neonForestHighContrastScheme,
    ),
  );
  PaletteRegistry.register(
    ChromaPalette.oceanSignal,
    const PaletteEntry(
      light: oceanSignalLightScheme,
      dark: oceanSignalDarkScheme,
      highContrast: oceanSignalHighContrastScheme,
    ),
  );
  PaletteRegistry.register(
    ChromaPalette.midnightMint,
    const PaletteEntry(
      light: midnightMintLightScheme,
      dark: midnightMintDarkScheme,
      highContrast: midnightMintHighContrastScheme,
    ),
  );
  PaletteRegistry.register(
    ChromaPalette.softMauve,
    const PaletteEntry(
      light: softMauveLightScheme,
      dark: softMauveDarkScheme,
      highContrast: softMauveHighContrastScheme,
    ),
  );
  PaletteRegistry.register(
    ChromaPalette.colonialNature,
    const PaletteEntry(
      light: colonialNatureLightScheme,
      dark: colonialNatureDarkScheme,
      highContrast: colonialNatureHighContrastScheme,
    ),
  );
  PaletteRegistry.register(
    ChromaPalette.iceLatte,
    const PaletteEntry(
      light: iceLatteLightScheme,
      dark: iceLatteDarkScheme,
      highContrast: iceLatteHighContrastScheme,
    ),
  );
  PaletteRegistry.register(
    ChromaPalette.emeraldRoad,
    const PaletteEntry(
      light: emeraldRoadLightScheme,
      dark: emeraldRoadDarkScheme,
      highContrast: emeraldRoadHighContrastScheme,
    ),
  );
  PaletteRegistry.register(
    ChromaPalette.blackMetal,
    const PaletteEntry(
      light: blackMetalLightScheme,
      dark: blackMetalDarkScheme,
      highContrast: blackMetalHighContrastScheme,
    ),
  );
  PaletteRegistry.register(
    ChromaPalette.softOcean,
    const PaletteEntry(
      light: softOceanLightScheme,
      dark: softOceanDarkScheme,
      highContrast: softOceanHighContrastScheme,
    ),
  );
  PaletteRegistry.register(
    ChromaPalette.royalBerry,
    const PaletteEntry(
      light: royalBerryLightScheme,
      dark: royalBerryDarkScheme,
      highContrast: royalBerryHighContrastScheme,
    ),
  );
  PaletteRegistry.register(
    ChromaPalette.onyxSpring,
    const PaletteEntry(
      light: onyxSpringLightScheme,
      dark: onyxSpringDarkScheme,
      highContrast: onyxSpringHighContrastScheme,
    ),
  );
  PaletteRegistry.register(
    ChromaPalette.midnightChrysocolla,
    const PaletteEntry(
      light: midnightChrysocollaLightScheme,
      dark: midnightChrysocollaDarkScheme,
      highContrast: midnightChrysocollaHighContrastScheme,
    ),
  );
  PaletteRegistry.register(
    ChromaPalette.uniformPalesun,
    const PaletteEntry(
      light: uniformPalesunLightScheme,
      dark: uniformPalesunDarkScheme,
      highContrast: uniformPalesunHighContrastScheme,
    ),
  );
  PaletteRegistry.register(
    ChromaPalette.colonialWaterloo,
    const PaletteEntry(
      light: colonialWaterlooLightScheme,
      dark: colonialWaterlooDarkScheme,
      highContrast: colonialWaterlooHighContrastScheme,
    ),
  );
  PaletteRegistry.register(
    ChromaPalette.noirMauve,
    const PaletteEntry(
      light: noirMauveLightScheme,
      dark: noirMauveDarkScheme,
      highContrast: noirMauveHighContrastScheme,
    ),
  );
}
