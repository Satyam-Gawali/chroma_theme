import 'package:chroma_theme/chroma_theme.dart';
import 'package:flutter/material.dart';

class ColorPaletteTab extends StatelessWidget {
  const ColorPaletteTab({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = context.chromaColors;
    final tones = context.chromaTones;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'All Theme Colors',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Complete Material 3 ColorScheme visualization for the active ChromaTheme.',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 20),

          _buildColorGroup('Primary', [
            _ColorToken('primary', scheme.primary, scheme.onPrimary),
            _ColorToken('onPrimary', scheme.onPrimary, scheme.primary),
            _ColorToken('primaryContainer', scheme.primaryContainer,
                scheme.onPrimaryContainer),
            _ColorToken('onPrimaryContainer', scheme.onPrimaryContainer,
                scheme.primaryContainer),
            _ColorToken('primaryFixed', scheme.primaryFixed,
                scheme.onPrimaryFixed),
            _ColorToken('primaryFixedDim', scheme.primaryFixedDim,
                scheme.onPrimaryFixedVariant),
            _ColorToken(
                'onPrimaryFixed', scheme.onPrimaryFixed, scheme.primaryFixed),
            _ColorToken('onPrimaryFixedVariant', scheme.onPrimaryFixedVariant,
                scheme.primaryFixedDim),
            _ColorToken('inversePrimary', scheme.inversePrimary,
                scheme.onSurface),
          ]),

          _buildColorGroup('Secondary', [
            _ColorToken('secondary', scheme.secondary, scheme.onSecondary),
            _ColorToken('onSecondary', scheme.onSecondary, scheme.secondary),
            _ColorToken('secondaryContainer', scheme.secondaryContainer,
                scheme.onSecondaryContainer),
            _ColorToken('onSecondaryContainer', scheme.onSecondaryContainer,
                scheme.secondaryContainer),
            _ColorToken('secondaryFixed', scheme.secondaryFixed,
                scheme.onSecondaryFixed),
            _ColorToken('secondaryFixedDim', scheme.secondaryFixedDim,
                scheme.onSecondaryFixedVariant),
            _ColorToken('onSecondaryFixed', scheme.onSecondaryFixed,
                scheme.secondaryFixed),
            _ColorToken('onSecondaryFixedVariant',
                scheme.onSecondaryFixedVariant, scheme.secondaryFixedDim),
          ]),

          _buildColorGroup('Tertiary', [
            _ColorToken('tertiary', scheme.tertiary, scheme.onTertiary),
            _ColorToken('onTertiary', scheme.onTertiary, scheme.tertiary),
            _ColorToken('tertiaryContainer', scheme.tertiaryContainer,
                scheme.onTertiaryContainer),
            _ColorToken('onTertiaryContainer', scheme.onTertiaryContainer,
                scheme.tertiaryContainer),
            _ColorToken('tertiaryFixed', scheme.tertiaryFixed,
                scheme.onTertiaryFixed),
            _ColorToken('tertiaryFixedDim', scheme.tertiaryFixedDim,
                scheme.onTertiaryFixedVariant),
            _ColorToken('onTertiaryFixed', scheme.onTertiaryFixed,
                scheme.tertiaryFixed),
            _ColorToken('onTertiaryFixedVariant',
                scheme.onTertiaryFixedVariant, scheme.tertiaryFixedDim),
          ]),

          _buildColorGroup('Error', [
            _ColorToken('error', scheme.error, scheme.onError),
            _ColorToken('onError', scheme.onError, scheme.error),
            _ColorToken(
                'errorContainer', scheme.errorContainer, scheme.onErrorContainer),
            _ColorToken('onErrorContainer', scheme.onErrorContainer,
                scheme.errorContainer),
          ]),

          _buildColorGroup('Surface & Background', [
            _ColorToken('surface', scheme.surface, scheme.onSurface),
            _ColorToken('onSurface', scheme.onSurface, scheme.surface),
            _ColorToken('surfaceDim', scheme.surfaceDim, scheme.onSurface),
            _ColorToken('surfaceBright', scheme.surfaceBright, scheme.onSurface),
            _ColorToken(
                'surfaceContainerLowest', scheme.surfaceContainerLowest, scheme.onSurface),
            _ColorToken('surfaceContainerLow', scheme.surfaceContainerLow,
                scheme.onSurface),
            _ColorToken('surfaceContainer', scheme.surfaceContainer,
                scheme.onSurface),
            _ColorToken('surfaceContainerHigh', scheme.surfaceContainerHigh,
                scheme.onSurface),
            _ColorToken('surfaceContainerHighest',
                scheme.surfaceContainerHighest, scheme.onSurface),
            _ColorToken('onSurfaceVariant', scheme.onSurfaceVariant,
                scheme.surfaceContainerHighest),
            _ColorToken('inverseSurface', scheme.inverseSurface,
                scheme.onInverseSurface),
            _ColorToken('onInverseSurface', scheme.onInverseSurface,
                scheme.inverseSurface),
            _ColorToken('surfaceTint', scheme.surfaceTint, scheme.onSurface),
          ]),

          _buildColorGroup('Legacy / Compatibility', [
            _ColorToken('surfaceVariant (compat)', scheme.surfaceContainerHighest,
                scheme.onSurfaceVariant),
            _ColorToken(
                'background (compat)', scheme.surface, scheme.onSurface),
            _ColorToken(
                'onBackground (compat)', scheme.onSurface, scheme.surface),
          ]),

          _buildColorGroup('Outline & Utility', [
            _ColorToken('outline', scheme.outline, scheme.surface),
            _ColorToken('outlineVariant', scheme.outlineVariant, scheme.surface),
            _ColorToken('shadow', scheme.shadow, Colors.white),
            _ColorToken('scrim', scheme.scrim, Colors.white),
          ]),

          _buildStateLayerPreview(context),

          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 16),
          const Text(
            'Tonal Palettes (0-100)',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text('From context.chromaTones'),
          const SizedBox(height: 16),
          _buildTonalRow('Primary', tones.primary),
          _buildTonalRow('Secondary', tones.secondary),
          _buildTonalRow('Tertiary', tones.tertiary),
          _buildTonalRow('Neutral', tones.neutral),
          _buildTonalRow('Neutral Variant', tones.neutralVariant),
          _buildTonalRow('Error', tones.error),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildStateLayerPreview(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'State Layers (Advanced)',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _StateLayerCard(
                label: 'Hover (8%)',
                base: scheme.surface,
                overlay: scheme.primary.withValues(alpha: 0.08),
              ),
              _StateLayerCard(
                label: 'Focus (10%)',
                base: scheme.surface,
                overlay: scheme.primary.withValues(alpha: 0.10),
              ),
              _StateLayerCard(
                label: 'Pressed (12%)',
                base: scheme.surface,
                overlay: scheme.primary.withValues(alpha: 0.12),
              ),
              _StateLayerCard(
                label: 'Dragged (16%)',
                base: scheme.surface,
                overlay: scheme.primary.withValues(alpha: 0.16),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildColorGroup(String title, List<_ColorToken> tokens) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: tokens
                .map((token) => _ColorCard(
                      name: token.name,
                      color: token.color,
                      onColor: token.onColor,
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTonalRow(String label, ChromaTonalPalette palette) {
    final shades = [0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 95, 99, 100];

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: shades.map((t) {
                final color = palette[t];
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Column(
                    children: [
                      Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          color: color,
                          border: Border.all(
                              color: Colors.grey.withValues(alpha: 0.25)),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(t.toString(),
                          style: const TextStyle(fontSize: 10)),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _ColorToken {
  final String name;
  final Color color;
  final Color onColor;

  const _ColorToken(this.name, this.color, this.onColor);
}

class _ColorCard extends StatelessWidget {
  final String name;
  final Color color;
  final Color onColor;

  const _ColorCard({
    required this.name,
    required this.color,
    required this.onColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 176,
      height: 96,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).colorScheme.outlineVariant,
          width: 0.6,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: TextStyle(
              color: onColor,
              fontWeight: FontWeight.w700,
              fontSize: 11,
            ),
          ),
          const Spacer(),
          Text(
            _hex(color),
            style: TextStyle(
              color: onColor.withValues(alpha: 0.8),
              fontSize: 11,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }

  static String _hex(Color color) {
    final hex = color.toARGB32().toRadixString(16).padLeft(8, '0').toUpperCase();
    return '#$hex';
  }
}

class _StateLayerCard extends StatelessWidget {
  final String label;
  final Color base;
  final Color overlay;

  const _StateLayerCard({
    required this.label,
    required this.base,
    required this.overlay,
  });

  @override
  Widget build(BuildContext context) {
    final blended = Color.alphaBlend(overlay, base);
    return Container(
      width: 176,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: base,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: Theme.of(context).textTheme.labelMedium),
          const SizedBox(height: 8),
          Row(
            children: [
              _swatch('Base', base),
              const SizedBox(width: 8),
              _swatch('Result', blended),
            ],
          ),
        ],
      ),
    );
  }

  Widget _swatch(String text, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 64,
          height: 32,
          decoration: BoxDecoration(
            color: color,
            border: Border.all(color: Colors.grey.withValues(alpha: 0.35)),
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        const SizedBox(height: 4),
        Text(text, style: const TextStyle(fontSize: 10)),
      ],
    );
  }
}
