import 'package:flutter/material.dart';

import '../core/chroma_theme_controller.dart';
import '../core/chroma_theme_widget.dart';
import '../extensions/chroma_theme_extension.dart';
import '../models/chroma_palette.dart';
import '../models/chroma_theme_mode.dart';
import '../palettes/palette_registry.dart';

/// A drop-in segmented or icon button to switch between Light, Dark, and AMOLED modes.
class ChromaThemeToggle extends StatelessWidget {
  /// Whether to include the dedicated pure-black AMOLED option.
  final bool showAmoled;

  /// Optional custom padding.
  final EdgeInsetsGeometry padding;

  const ChromaThemeToggle({
    super.key,
    this.showAmoled = true,
    this.padding = const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
  });

  @override
  Widget build(BuildContext context) {
    final chroma = context.chroma;
    final currentMode = chroma.mode;

    final segments = <ButtonSegment<ChromaThemeMode>>[
      const ButtonSegment(
        value: ChromaThemeMode.light,
        icon: Icon(Icons.wb_sunny_rounded),
        label: Text('Light'),
      ),
      const ButtonSegment(
        value: ChromaThemeMode.dark,
        icon: Icon(Icons.nightlight_round),
        label: Text('Dark'),
      ),
      if (showAmoled)
        const ButtonSegment(
          value: ChromaThemeMode.amoled,
          icon: Icon(Icons.battery_saver_rounded),
          label: Text('AMOLED'),
        ),
    ];

    // Selected segment fallback
    final selectedMode = (currentMode == ChromaThemeMode.system)
        ? (context.isDarkMode ? ChromaThemeMode.dark : ChromaThemeMode.light)
        : currentMode;

    return Padding(
      padding: padding,
      child: SegmentedButton<ChromaThemeMode>(
        segments: segments,
        selected: {selectedMode},
        onSelectionChanged: (newSelection) {
          if (newSelection.isNotEmpty) {
            chroma.setTheme(newSelection.first);
          }
        },
      ),
    );
  }
}

/// A horizontal scrollable or wrapped list of palette swatches.
class ChromaPaletteSelector extends StatelessWidget {
  /// Whether to display in a horizontal scrolling row (true) or a wrap grid (false).
  final bool horizontal;

  /// Diameter of each palette color circle.
  final double swatchSize;

  const ChromaPaletteSelector({
    super.key,
    this.horizontal = true,
    double? size,
    double? swatchSize,
  }) : swatchSize = size ?? swatchSize ?? 44.0;

  @override
  Widget build(BuildContext context) {
    final chroma = context.chroma;
    final currentPalette = chroma.palette;
    final palettes = ChromaPalette.values
        .where((p) => p != ChromaPalette.custom)
        .toList();

    Widget buildSwatch(ChromaPalette palette) {
      final entry = PaletteRegistry.get(palette);
      final primaryColor = entry?.light().primary ?? Colors.blue;
      final isSelected = currentPalette == palette && !chroma.hasSeeds;

      return GestureDetector(
        onTap: () {
          chroma.clearSeeds();
          chroma.setPalette(palette);
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
          width: swatchSize,
          height: swatchSize,
          decoration: BoxDecoration(
            color: primaryColor,
            shape: BoxShape.circle,
            border: Border.all(
              color: isSelected ? context.chromaPrimary : Colors.transparent,
              width: 3.0,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.15),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: isSelected
              ? Icon(
                  Icons.check,
                  size: swatchSize * 0.5,
                  color: primaryColor.computeLuminance() > 0.5
                      ? Colors.black
                      : Colors.white,
                )
              : null,
        ),
      );
    }

    if (horizontal) {
      return SizedBox(
        height: swatchSize + 16,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: palettes.length,
          itemBuilder: (context, index) => buildSwatch(palettes[index]),
        ),
      );
    }

    return Wrap(
      spacing: 4,
      runSpacing: 4,
      children: palettes.map(buildSwatch).toList(),
    );
  }
}

/// Displays a ready-to-use theme settings modal bottom sheet.
Future<void> showChromaThemeSheet(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    showDragHandle: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.palette_rounded, color: context.chromaPrimary),
                const SizedBox(width: 12),
                Text(
                  'Theme & Appearance',
                  style: context.chromaText.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Center(child: ChromaThemeToggle()),
            const SizedBox(height: 24),
            Text(
              'Color Palettes',
              style: context.chromaText.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            const ChromaPaletteSelector(horizontal: true),
          ],
        ),
      );
    },
  );
}
