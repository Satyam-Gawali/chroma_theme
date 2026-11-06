import 'chroma_overrides.dart';
import 'chroma_palette.dart';
import 'chroma_seeds.dart';

/// Represents a distinct brand styling profile for white-label or multi-tenant apps.
class ChromaBrandProfile {
  /// Unique name / key of the brand (e.g. "AcmeCorp", "ClientA").
  final String name;

  /// Identifier alias for [name].
  String get id => name;

  /// Optional display title or label.
  final String? label;

  /// Base palette for this brand profile.
  final ChromaPalette? palette;

  /// Custom brand seeds. Takes priority over [palette] if non-null and not empty.
  final ChromaSeeds? seeds;

  /// Component-level styling overrides specific to this brand.
  final ChromaOverrides? overrides;

  /// Custom typography font family for this brand (e.g. 'Poppins', 'Inter').
  final String? fontFamily;

  const ChromaBrandProfile({
    String? id,
    String? name,
    this.label,
    this.palette,
    this.seeds,
    this.overrides,
    this.fontFamily,
  }) : name = name ?? id ?? 'default_brand';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ChromaBrandProfile &&
        other.name == name &&
        other.label == label &&
        other.palette == palette &&
        other.seeds == seeds &&
        other.overrides == overrides &&
        other.fontFamily == fontFamily;
  }

  @override
  int get hashCode => Object.hash(name, label, palette, seeds, overrides, fontFamily);

  @override
  String toString() => 'ChromaBrandProfile(name: $name, palette: $palette, seeds: $seeds)';
}
