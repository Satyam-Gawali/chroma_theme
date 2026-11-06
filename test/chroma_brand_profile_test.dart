import 'package:chroma_theme/chroma_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ChromaBrandProfile White-Label Multi-Brand Tests', () {
    test('initializes and compares brand profiles by value', () {
      const b1 = ChromaBrandProfile(
        name: 'Alpha',
        palette: ChromaPalette.blue,
        fontFamily: 'Inter',
      );

      const b2 = ChromaBrandProfile(
        name: 'Alpha',
        palette: ChromaPalette.blue,
        fontFamily: 'Inter',
      );

      const b3 = ChromaBrandProfile(
        name: 'Beta',
        palette: ChromaPalette.neonForest,
      );

      expect(b1 == b2, isTrue);
      expect(b1.hashCode, b2.hashCode);
      expect(b1 == b3, isFalse);
      expect(b1.toString(), contains('ChromaBrandProfile'));
    });

    test('switches dynamically between multiple brands in controller', () {
      final controller = ChromaThemeController(
        brandProfiles: const [
          ChromaBrandProfile(
            name: 'ClientOne',
            palette: ChromaPalette.berryBlush,
            fontFamily: 'Roboto',
          ),
          ChromaBrandProfile(
            name: 'ClientTwo',
            palette: ChromaPalette.midnightMint,
            fontFamily: 'Poppins',
            seeds: ChromaSeeds(primary: Colors.amber),
          ),
        ],
      );

      expect(controller.brands.length, 2);

      // Activate ClientOne
      controller.setBrand('ClientOne');
      expect(controller.activeBrand, 'ClientOne');
      expect(controller.palette, ChromaPalette.berryBlush);
      expect(controller.fontFamily, 'Roboto');
      expect(controller.hasSeeds, isFalse);

      // Activate ClientTwo with custom seeds
      controller.setBrand('ClientTwo');
      expect(controller.activeBrand, 'ClientTwo');
      expect(controller.palette, ChromaPalette.midnightMint);
      expect(controller.fontFamily, 'Poppins');
      expect(controller.hasSeeds, isTrue);
      expect(controller.seeds?.primary, Colors.amber);

      // Activating non-existent brand safely does nothing
      controller.setBrand('NonExistent');
      expect(controller.activeBrand, 'ClientTwo');
    });
  });
}
