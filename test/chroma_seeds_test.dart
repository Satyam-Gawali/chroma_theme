import 'package:chroma_theme/chroma_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ChromaSeeds Tests (Task 6.4)', () {
    test('creates from primary color properly', () {
      final seeds = ChromaSeeds.fromPrimary(Colors.teal);

      expect(seeds.primary, Colors.teal);
      expect(seeds.isEmpty, isFalse);
    });

    test('correctly identifies empty seeds', () {
      const emptySeeds = ChromaSeeds();
      expect(emptySeeds.isEmpty, isTrue);

      const nonEmpty = ChromaSeeds(secondary: Colors.red);
      expect(nonEmpty.isEmpty, isFalse);
    });

    test('resolves neutral surface seed by brightness priority', () {
      const seeds = ChromaSeeds(
        neutral: Color(0xFFE0E0E0),
        neutralLight: Color(0xFFFAFAFA),
        neutralDark: Color(0xFF121212),
      );

      // Mode-specific override must take precedence over generic neutral
      expect(seeds.resolveNeutral(Brightness.light), const Color(0xFFFAFAFA));
      expect(seeds.resolveNeutral(Brightness.dark), const Color(0xFF121212));

      // Fallback to generic neutral when mode-specific is not provided
      const genericSeeds = ChromaSeeds(neutral: Color(0xFFCCCCCC));
      expect(genericSeeds.resolveNeutral(Brightness.light), const Color(0xFFCCCCCC));
      expect(genericSeeds.resolveNeutral(Brightness.dark), const Color(0xFFCCCCCC));
    });

    test('value equality and copyWith behave predictably', () {
      const s1 = ChromaSeeds(primary: Colors.blue, error: Colors.red);
      const s2 = ChromaSeeds(primary: Colors.blue, error: Colors.red);
      const s3 = ChromaSeeds(primary: Colors.amber);

      expect(s1 == s2, isTrue);
      expect(s1.hashCode, s2.hashCode);
      expect(s1 == s3, isFalse);

      final updated = s1.copyWith(primary: Colors.green);
      expect(updated.primary, Colors.green);
      expect(updated.error, Colors.red);
    });
  });
}
