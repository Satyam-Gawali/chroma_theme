import 'package:chroma_theme/chroma_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ChromaThemeController', () {
    test('updates mode and exposes effective darkness', () {
      final controller = ChromaThemeController(
        initialMode: ChromaThemeMode.system,
      );

      expect(controller.isDarkEffective(Brightness.light), isFalse);
      expect(controller.isDarkEffective(Brightness.dark), isTrue);

      controller.setTheme(ChromaThemeMode.amoled);
      expect(controller.mode, ChromaThemeMode.amoled);
      expect(controller.isDarkEffective(Brightness.light), isTrue);
    });

    test('tracks seed presence correctly', () {
      final controller = ChromaThemeController();

      expect(controller.hasSeeds, isFalse);

      controller.setSeeds(const ChromaSeeds(primary: Colors.blue));
      expect(controller.hasSeeds, isTrue);

      controller.clearSeeds();
      expect(controller.hasSeeds, isFalse);
    });
  });
}
