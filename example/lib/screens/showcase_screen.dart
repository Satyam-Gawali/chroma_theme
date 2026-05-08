import 'dart:ui';
import 'package:chroma_theme/chroma_theme.dart';
import 'package:flutter/material.dart';

class ChromaShowcaseScreen extends StatelessWidget {
  const ChromaShowcaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final chroma = context.chroma;
    final colors = context.chromaColors;
    final textTheme = context.chromaText;

    return Scaffold(
      backgroundColor: colors.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // 1. Branding Header
              Row(
                children: [
                  Image.asset('assets/logo.png', height: 32),
                  const SizedBox(width: 12),
                  Text(
                    'Chroma Theme Visualizer',
                    style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w900, letterSpacing: 0.5),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close_fullscreen_rounded),
                    tooltip: 'Exit Showcase',
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // 2. Main Visualizer Dashboard
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // LEFT COLUMN: Colors & Tones
                    Expanded(
                      flex: 3,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            _buildSectionBox(
                              context,
                              'Color Scheme Swatches',
                              _buildColorSchemeGrid(context),
                            ),
                            const SizedBox(height: 12),
                            _buildSectionBox(
                              context,
                              'Dynamic Tonal Ranges',
                              _buildTonalGrid(context),
                            ),
                            const SizedBox(height: 12),
                            _buildSectionBox(
                              context,
                              'Typography Visualization',
                              _buildTypographyPreview(context),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    // RIGHT COLUMN: Controls & Components
                    Expanded(
                      flex: 2,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            _buildSectionBox(
                              context,
                              'Active Mode',
                              _buildCompactModes(context),
                            ),
                            const SizedBox(height: 12),
                            _buildSectionBox(
                              context,
                              'Quick Presets',
                              _buildCompactPalettes(context),
                            ),
                            const SizedBox(height: 12),
                            _buildSectionBox(
                              context,
                              'Interactive UI Elements',
                              _buildCompactComponents(context),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // 3. Status Bar
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                decoration: BoxDecoration(
                  color: colors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: colors.primary.withOpacity(0.2)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Mode: ${chroma.mode.name.toUpperCase()}',
                      style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: colors.primary),
                    ),
                    Text(
                      'Palette: ${chroma.palette.name.toUpperCase()}',
                      style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: colors.primary),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionBox(BuildContext context, String title, Widget child) {
    final colors = context.chromaColors;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colors.surfaceVariant.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colors.outlineVariant.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Container(width: 8, height: 2, color: colors.primary),
              const SizedBox(width: 6),
              Text(
                title.toUpperCase(),
                style: TextStyle(fontSize: 9, fontWeight: FontWeight.w900, letterSpacing: 1, color: colors.onSurfaceVariant),
              ),
            ],
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }

  Widget _buildColorSchemeGrid(BuildContext context) {
    final colors = context.chromaColors;
    final swatchList = [
      ('Primary', colors.primary, colors.onPrimary),
      ('Secondary', colors.secondary, colors.onSecondary),
      ('Tertiary', colors.tertiary, colors.onTertiary),
      ('Error', colors.error, colors.onError),
      ('Surface', colors.surface, colors.onSurface),
      ('Outline', colors.outline, colors.surface),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1.2,
        mainAxisSpacing: 6,
        crossAxisSpacing: 6,
      ),
      itemCount: swatchList.length,
      itemBuilder: (context, i) {
        final item = swatchList[i];
        return Container(
          decoration: BoxDecoration(
            color: item.$2,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: colors.outline.withOpacity(0.1)),
          ),
          child: Center(
            child: Text(
              item.$1,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold, color: item.$3),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTonalGrid(BuildContext context) {
    final tones = context.chromaTones;
    return Column(
      children: [
        _tonalBar(context, 'Primary', tones.primary),
        _tonalBar(context, 'Secondary', tones.secondary),
        _tonalBar(context, 'Neutral', tones.neutral),
      ],
    );
  }

  Widget _tonalBar(BuildContext context, String label, ChromaTonalPalette palette) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 8, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: SizedBox(
            height: 14,
            child: Row(
              children: [0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100].map((t) {
                return Expanded(child: Container(color: palette[t]));
              }).toList(),
            ),
          ),
        ),
        const SizedBox(height: 6),
      ],
    );
  }

  Widget _buildTypographyPreview(BuildContext context) {
    final textTheme = context.chromaText;
    final colors = context.chromaColors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Headline Large', style: textTheme.headlineLarge?.copyWith(fontSize: 18)),
        const SizedBox(height: 4),
        Text('Body Medium Text Sample', style: textTheme.bodyMedium),
        const SizedBox(height: 4),
        Text('Label Small Metadata', style: textTheme.labelSmall?.copyWith(color: colors.primary)),
      ],
    );
  }

  Widget _buildCompactComponents(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: FilledButton(onPressed: () {}, child: const Text('Action', style: TextStyle(fontSize: 10)))),
            const SizedBox(width: 6),
            Expanded(child: OutlinedButton(onPressed: () {}, child: const Text('Cancel', style: TextStyle(fontSize: 10)))),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Switch(value: true, onChanged: (_) {}),
            Checkbox(value: true, onChanged: (_) {}),
            const Icon(Icons.star, color: Colors.orange),
          ],
        ),
        const SizedBox(height: 8),
        const LinearProgressIndicator(value: 0.6),
      ],
    );
  }

  Widget _buildCompactModes(BuildContext context) {
    final chroma = context.chroma;
    final modes = [
      (Icons.light_mode, ChromaThemeMode.light),
      (Icons.dark_mode, ChromaThemeMode.dark),
      (Icons.brightness_3, ChromaThemeMode.amoled),
      (Icons.contrast, ChromaThemeMode.highContrast),
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: modes.map((m) {
        final active = chroma.mode == m.$2;
        final colors = context.chromaColors;
        return GestureDetector(
          onTap: () => chroma.setTheme(m.$2),
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: active ? colors.primary : colors.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(m.$1, size: 16, color: active ? colors.onPrimary : colors.onSurfaceVariant),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildCompactPalettes(BuildContext context) {
    final palettes = [
      ChromaPalette.neonForest,
      ChromaPalette.oceanSignal,
      ChromaPalette.berryBlush,
      ChromaPalette.iceLatte,
      ChromaPalette.noirMauve,
      ChromaPalette.blackMetal,
    ];

    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: palettes.map((p) {
        final active = context.chroma.palette == p;
        final colors = context.chromaColors;
        return GestureDetector(
          onTap: () => context.chroma.setPalette(p),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: active ? colors.primaryContainer : colors.surfaceContainerHighest.withOpacity(0.5),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: active ? colors.primary : Colors.transparent),
            ),
            child: Text(
              p.name,
              style: TextStyle(fontSize: 9, fontWeight: active ? FontWeight.bold : FontWeight.normal),
            ),
          ),
        );
      }).toList(),
    );
  }
}
