import 'package:flutter/material.dart';

/// Represents the accessibility contrast evaluation between foreground and background colors.
class ChromaContrastResult {
  final String pairName;
  final Color foreground;
  final Color background;
  final double ratio;
  final bool passesAANormal;
  final bool passesAALarge;
  final bool passesAAA;

  const ChromaContrastResult({
    required this.pairName,
    required this.foreground,
    required this.background,
    required this.ratio,
    required this.passesAANormal,
    required this.passesAALarge,
    required this.passesAAA,
  });

  @override
  String toString() =>
      '$pairName: ${ratio.toStringAsFixed(2)}:1 (AA: ${passesAANormal ? "PASS" : "FAIL"}, AAA: ${passesAAA ? "PASS" : "FAIL"})';
}

/// Comprehensive audit report for a [ColorScheme].
class ChromaAuditReport {
  final List<ChromaContrastResult> results;

  const ChromaAuditReport(this.results);

  /// True if all evaluated pairs meet minimum WCAG AA normal text contrast (>= 4.5:1).
  bool get passesAA => results.every((r) => r.passesAANormal);

  /// List of pairs that failed WCAG AA normal text contrast.
  List<ChromaContrastResult> get failures =>
      results.where((r) => !r.passesAANormal).toList();

  @override
  String toString() {
    final buffer = StringBuffer('ChromaAuditReport (Total: ${results.length}, Failures: ${failures.length})\n');
    for (final res in results) {
      buffer.writeln('  - $res');
    }
    return buffer.toString();
  }
}

/// Audits [ColorScheme] pairs against W3C WCAG 2.1 accessibility guidelines.
class ChromaAuditor {
  ChromaAuditor._();

  /// Calculates the WCAG contrast ratio between [foreground] and [background].
  /// Returns a value between 1.0 (no contrast) and 21.0 (maximum contrast).
  static double calculateContrastRatio(Color foreground, Color background) {
    final l1 = foreground.computeLuminance();
    final l2 = background.computeLuminance();
    final lighter = l1 > l2 ? l1 : l2;
    final darker = l1 > l2 ? l2 : l1;
    return (lighter + 0.05) / (darker + 0.05);
  }

  /// Evaluates a single foreground and background color pair.
  static ChromaContrastResult evaluatePair({
    required String name,
    required Color foreground,
    required Color background,
  }) {
    final ratio = calculateContrastRatio(foreground, background);
    return ChromaContrastResult(
      pairName: name,
      foreground: foreground,
      background: background,
      ratio: ratio,
      passesAANormal: ratio >= 4.5,
      passesAALarge: ratio >= 3.0,
      passesAAA: ratio >= 7.0,
    );
  }

  /// Audits standard Material 3 color pairs in [scheme].
  static ChromaAuditReport audit(ColorScheme scheme) {
    final results = <ChromaContrastResult>[
      evaluatePair(
        name: 'onPrimary / primary',
        foreground: scheme.onPrimary,
        background: scheme.primary,
      ),
      evaluatePair(
        name: 'onSecondary / secondary',
        foreground: scheme.onSecondary,
        background: scheme.secondary,
      ),
      evaluatePair(
        name: 'onTertiary / tertiary',
        foreground: scheme.onTertiary,
        background: scheme.tertiary,
      ),
      evaluatePair(
        name: 'onSurface / surface',
        foreground: scheme.onSurface,
        background: scheme.surface,
      ),
      evaluatePair(
        name: 'onError / error',
        foreground: scheme.onError,
        background: scheme.error,
      ),
      evaluatePair(
        name: 'onPrimaryContainer / primaryContainer',
        foreground: scheme.onPrimaryContainer,
        background: scheme.primaryContainer,
      ),
      evaluatePair(
        name: 'onSecondaryContainer / secondaryContainer',
        foreground: scheme.onSecondaryContainer,
        background: scheme.secondaryContainer,
      ),
      evaluatePair(
        name: 'onSurfaceVariant / surface',
        foreground: scheme.onSurfaceVariant,
        background: scheme.surface,
      ),
    ];

    return ChromaAuditReport(results);
  }
}
