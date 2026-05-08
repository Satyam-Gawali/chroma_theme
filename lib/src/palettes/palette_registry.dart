import 'package:flutter/material.dart';

import '../models/chroma_palette.dart';
import 'army_coral/army_coral_dark.dart';
import 'army_coral/army_coral_light.dart';
import 'berry_blush/berry_blush_dark.dart';
import 'berry_blush/berry_blush_light.dart';
import 'black_metal/black_metal_dark.dart';
import 'black_metal/black_metal_light.dart';
import 'blue/blue_dark.dart';
import 'blue/blue_light.dart';
import 'colonial_nature/colonial_nature_dark.dart';
import 'colonial_nature/colonial_nature_light.dart';
import 'colonial_waterloo/colonial_waterloo_dark.dart';
import 'colonial_waterloo/colonial_waterloo_light.dart';
import 'emerald/emerald_dark.dart';
import 'emerald/emerald_light.dart';
import 'emerald_road/emerald_road_dark.dart';
import 'emerald_road/emerald_road_light.dart';
import 'ice_latte/ice_latte_dark.dart';
import 'ice_latte/ice_latte_light.dart';
import 'khaki_slate/khaki_slate_dark.dart';
import 'khaki_slate/khaki_slate_light.dart';
import 'midnight_chrysocolla/midnight_chrysocolla_dark.dart';
import 'midnight_chrysocolla/midnight_chrysocolla_light.dart';
import 'midnight_mint/midnight_mint_dark.dart';
import 'midnight_mint/midnight_mint_light.dart';
import 'mint_latte/mint_latte_dark.dart';
import 'mint_latte/mint_latte_light.dart';
import 'mono/mono_dark.dart';
import 'mono/mono_light.dart';
import 'neon_forest/neon_forest_dark.dart';
import 'neon_forest/neon_forest_light.dart';
import 'noir_mauve/noir_mauve_dark.dart';
import 'noir_mauve/noir_mauve_light.dart';
import 'ocean_signal/ocean_signal_dark.dart';
import 'ocean_signal/ocean_signal_light.dart';
import 'onyx_spring/onyx_spring_dark.dart';
import 'onyx_spring/onyx_spring_light.dart';
import 'raisin_caramel/raisin_caramel_dark.dart';
import 'raisin_caramel/raisin_caramel_light.dart';
import 'royal_berry/royal_berry_dark.dart';
import 'royal_berry/royal_berry_light.dart';
import 'soft_mauve/soft_mauve_dark.dart';
import 'soft_mauve/soft_mauve_light.dart';
import 'soft_ocean/soft_ocean_dark.dart';
import 'soft_ocean/soft_ocean_light.dart';
import 'uniform_palesun/uniform_palesun_dark.dart';
import 'uniform_palesun/uniform_palesun_light.dart';

typedef PaletteBuilder = ColorScheme Function(Brightness brightness);

typedef FixedSchemeBuilder = ColorScheme Function();

ColorScheme _adaptiveScheme(
  Brightness brightness,
  FixedSchemeBuilder lightBuilder,
  FixedSchemeBuilder darkBuilder,
) {
  return brightness == Brightness.dark ? darkBuilder() : lightBuilder();
}

class PaletteRegistry {
  PaletteRegistry._();

  static final Map<ChromaPalette, PaletteBuilder> _registry = {};

  static void register(
    ChromaPalette palette,
    PaletteBuilder builder,
  ) {
    _registry[palette] = builder;
  }

  static PaletteBuilder? get(ChromaPalette palette) {
    return _registry[palette];
  }

  static Map<ChromaPalette, PaletteBuilder> get all => _registry;
}

void registerDefaultPalettes() {
  PaletteRegistry.register(
    ChromaPalette.blue,
    (brightness) => _adaptiveScheme(brightness, blueLightScheme, blueDarkScheme),
  );
  PaletteRegistry.register(
    ChromaPalette.mono,
    (brightness) => _adaptiveScheme(brightness, monoLightScheme, monoDarkScheme),
  );
  PaletteRegistry.register(
    ChromaPalette.emerald,
    (brightness) => _adaptiveScheme(brightness, emeraldLightScheme, emeraldDarkScheme),
  );
  PaletteRegistry.register(
    ChromaPalette.mintLatte,
    (brightness) => _adaptiveScheme(brightness, mintLatteLightScheme, mintLatteDarkScheme),
  );
  PaletteRegistry.register(
    ChromaPalette.berryBlush,
    (brightness) => _adaptiveScheme(brightness, berryBlushLightScheme, berryBlushDarkScheme),
  );
  PaletteRegistry.register(
    ChromaPalette.raisinCaramel,
    (brightness) => _adaptiveScheme(brightness, raisinCaramelLightScheme, raisinCaramelDarkScheme),
  );
  PaletteRegistry.register(
    ChromaPalette.khakiSlate,
    (brightness) => _adaptiveScheme(brightness, khakiSlateLightScheme, khakiSlateDarkScheme),
  );
  PaletteRegistry.register(
    ChromaPalette.armyCoral,
    (brightness) => _adaptiveScheme(brightness, armyCoralLightScheme, armyCoralDarkScheme),
  );
  PaletteRegistry.register(
    ChromaPalette.neonForest,
    (brightness) => _adaptiveScheme(brightness, neonForestLightScheme, neonForestDarkScheme),
  );
  PaletteRegistry.register(
    ChromaPalette.oceanSignal,
    (brightness) => _adaptiveScheme(brightness, oceanSignalLightScheme, oceanSignalDarkScheme),
  );
  PaletteRegistry.register(
    ChromaPalette.midnightMint,
    (brightness) => _adaptiveScheme(brightness, midnightMintLightScheme, midnightMintDarkScheme),
  );
  PaletteRegistry.register(
    ChromaPalette.softMauve,
    (brightness) => _adaptiveScheme(brightness, softMauveLightScheme, softMauveDarkScheme),
  );
  PaletteRegistry.register(
    ChromaPalette.colonialNature,
    (brightness) => _adaptiveScheme(brightness, colonialNatureLightScheme, colonialNatureDarkScheme),
  );
  PaletteRegistry.register(
    ChromaPalette.iceLatte,
    (brightness) => _adaptiveScheme(brightness, iceLatteLightScheme, iceLatteDarkScheme),
  );
  PaletteRegistry.register(
    ChromaPalette.emeraldRoad,
    (brightness) => _adaptiveScheme(brightness, emeraldRoadLightScheme, emeraldRoadDarkScheme),
  );
  PaletteRegistry.register(
    ChromaPalette.blackMetal,
    (brightness) => _adaptiveScheme(brightness, blackMetalLightScheme, blackMetalDarkScheme),
  );
  PaletteRegistry.register(
    ChromaPalette.softOcean,
    (brightness) => _adaptiveScheme(brightness, softOceanLightScheme, softOceanDarkScheme),
  );
  PaletteRegistry.register(
    ChromaPalette.royalBerry,
    (brightness) => _adaptiveScheme(brightness, royalBerryLightScheme, royalBerryDarkScheme),
  );
  PaletteRegistry.register(
    ChromaPalette.onyxSpring,
    (brightness) => _adaptiveScheme(brightness, onyxSpringLightScheme, onyxSpringDarkScheme),
  );
  PaletteRegistry.register(
    ChromaPalette.midnightChrysocolla,
    (brightness) => _adaptiveScheme(brightness, midnightChrysocollaLightScheme, midnightChrysocollaDarkScheme),
  );
  PaletteRegistry.register(
    ChromaPalette.uniformPalesun,
    (brightness) => _adaptiveScheme(brightness, uniformPalesunLightScheme, uniformPalesunDarkScheme),
  );
  PaletteRegistry.register(
    ChromaPalette.colonialWaterloo,
    (brightness) => _adaptiveScheme(brightness, colonialWaterlooLightScheme, colonialWaterlooDarkScheme),
  );
  PaletteRegistry.register(
    ChromaPalette.noirMauve,
    (brightness) => _adaptiveScheme(brightness, noirMauveLightScheme, noirMauveDarkScheme),
  );
}
