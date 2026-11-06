import 'package:chroma_theme/chroma_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ChromaAuditor Accessibility Contrast Deep Tests', () {
    test('calculates exact boundary contrast ratios', () {
      // Pure black on pure white = maximum contrast 21:1
      final maxRatio = ChromaAuditor.calculateContrastRatio(Colors.black, Colors.white);
      expect(maxRatio, closeTo(21.0, 0.01));

      // Same colors = minimum contrast 1:1
      final minRatio = ChromaAuditor.calculateContrastRatio(Colors.white, Colors.white);
      expect(minRatio, closeTo(1.0, 0.01));

      final minRatioBlack = ChromaAuditor.calculateContrastRatio(Colors.black, Colors.black);
      expect(minRatioBlack, closeTo(1.0, 0.01));

      // Symmetric calculation: foreground vs background order does not alter ratio
      final r1 = ChromaAuditor.calculateContrastRatio(Colors.blue, Colors.white);
      final r2 = ChromaAuditor.calculateContrastRatio(Colors.white, Colors.blue);
      expect(r1, equals(r2));
    });

    test('evaluates WCAG AA and AAA thresholds correctly', () {
      // Black on White: passes AA normal, AA large, AAA
      final passPair = ChromaAuditor.evaluatePair(
        name: 'black/white',
        foreground: Colors.black,
        background: Colors.white,
      );
      expect(passPair.passesAANormal, isTrue);
      expect(passPair.passesAALarge, isTrue);
      expect(passPair.passesAAA, isTrue);
      expect(passPair.ratio, greaterThan(7.0));

      // Light gray on white: fails AA normal (< 4.5:1)
      final failPair = ChromaAuditor.evaluatePair(
        name: 'lightGray/white',
        foreground: const Color(0xFFE0E0E0),
        background: Colors.white,
      );
      expect(failPair.passesAANormal, isFalse);
      expect(failPair.passesAAA, isFalse);
    });

    test('audits complete Material 3 ColorScheme and captures failures', () {
      // High contrast scheme should pass AA easily
      final hcScheme = ColorScheme.fromSeed(
        seedColor: Colors.blue,
        brightness: Brightness.light,
      );

      final report = ChromaAuditor.audit(hcScheme);
      expect(report.results, isNotEmpty);
      expect(report.toString(), contains('ChromaAuditReport'));

      // Intentionally low contrast scheme to test failure detection
      const badScheme = ColorScheme(
        brightness: Brightness.light,
        primary: Color(0xFFE0E0E0),
        onPrimary: Color(0xFFE5E5E5), // Inaudible contrast
        secondary: Colors.blue,
        onSecondary: Colors.white,
        error: Colors.red,
        onError: Colors.white,
        surface: Colors.white,
        onSurface: Color(0xFFF0F0F0), // Inaudible contrast
      );

      final badReport = ChromaAuditor.audit(badScheme);
      expect(badReport.passesAA, isFalse);
      expect(badReport.failures.length, greaterThanOrEqualTo(2));
    });
  });
}
