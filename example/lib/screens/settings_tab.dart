import 'package:flutter/material.dart';
import 'package:chroma_theme/chroma_theme.dart';
import 'color_picker.dart';

class SettingsTab extends StatefulWidget {
  const SettingsTab({super.key});

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  static const List<_PaletteOption> _paletteOptions = [
    _PaletteOption(ChromaPalette.blue, "Blue"),
    _PaletteOption(ChromaPalette.mono, "Mono"),
    _PaletteOption(ChromaPalette.emerald, "Emerald"),
    _PaletteOption(ChromaPalette.mintLatte, "Mint Latte"),
    _PaletteOption(ChromaPalette.berryBlush, "Berry Blush"),
    _PaletteOption(ChromaPalette.raisinCaramel, "Raisin Caramel"),
    _PaletteOption(ChromaPalette.khakiSlate, "Khaki Slate"),
    _PaletteOption(ChromaPalette.armyCoral, "Army Coral"),
    _PaletteOption(ChromaPalette.neonForest, "Neon Forest"),
    _PaletteOption(ChromaPalette.oceanSignal, "Ocean Signal"),
    _PaletteOption(ChromaPalette.midnightMint, "Midnight Mint"),
    _PaletteOption(ChromaPalette.softMauve, "Soft Mauve"),
    _PaletteOption(ChromaPalette.colonialNature, "Colonial Nature"),
    _PaletteOption(ChromaPalette.iceLatte, "Ice Latte"),
    _PaletteOption(ChromaPalette.emeraldRoad, "Emerald Road"),
    _PaletteOption(ChromaPalette.blackMetal, "Black Metal"),
    _PaletteOption(ChromaPalette.softOcean, "Soft Ocean"),
    _PaletteOption(ChromaPalette.royalBerry, "Royal Berry"),
    _PaletteOption(ChromaPalette.onyxSpring, "Onyx Spring"),
    _PaletteOption(ChromaPalette.midnightChrysocolla, "Midnight Chrysocolla"),
    _PaletteOption(ChromaPalette.uniformPalesun, "Uniform Palesun"),
    _PaletteOption(ChromaPalette.colonialWaterloo, "Colonial Waterloo"),
    _PaletteOption(ChromaPalette.noirMauve, "Noir Mauve"),
  ];

  final _primaryController = TextEditingController();
  final _secondaryController = TextEditingController();
  final _tertiaryController = TextEditingController();
  final _errorController = TextEditingController();
  final _surfaceController = TextEditingController();
  final _surfaceLightController = TextEditingController();
  final _surfaceDarkController = TextEditingController();

  Color? _primaryPreview;
  Color? _secondaryPreview;
  Color? _tertiaryPreview;
  Color? _errorPreview;
  Color? _surfacePreview;
  Color? _surfaceLightPreview;
  Color? _surfaceDarkPreview;

  bool _separateSurfaces = false;

  @override
  void dispose() {
    _primaryController.dispose();
    _secondaryController.dispose();
    _tertiaryController.dispose();
    _errorController.dispose();
    _surfaceController.dispose();
    _surfaceLightController.dispose();
    _surfaceDarkController.dispose();
    super.dispose();
  }

  void _applyCustomColors() {
    final primary = _primaryPreview ?? ChromaThemeUtils.fromHex(_primaryController.text);
    final secondary = _secondaryPreview ?? ChromaThemeUtils.fromHex(_secondaryController.text);
    final tertiary = _tertiaryPreview ?? ChromaThemeUtils.fromHex(_tertiaryController.text);
    final error = _errorPreview ?? ChromaThemeUtils.fromHex(_errorController.text);

    if (primary == null && _primaryController.text.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid Primary Hex Color')),
      );
      return;
    }

    ChromaSeeds seeds;

    if (_separateSurfaces) {
      final surfaceLight = _surfaceLightPreview ?? ChromaThemeUtils.fromHex(_surfaceLightController.text);
      final surfaceDark = _surfaceDarkPreview ?? ChromaThemeUtils.fromHex(_surfaceDarkController.text);

      seeds = ChromaSeeds(
        primary: primary,
        secondary: secondary,
        tertiary: tertiary,
        error: error,
        neutralLight: surfaceLight,
        neutralDark: surfaceDark,
      );
    } else {
      final surface = _surfacePreview ?? ChromaThemeUtils.fromHex(_surfaceController.text);

      seeds = ChromaSeeds(
        primary: primary,
        secondary: secondary,
        tertiary: tertiary,
        error: error,
        neutral: surface,
      );
    }

    context.chroma.setSeeds(seeds);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('🎨 Custom Colors Applied!')),
    );
  }

  void _resetCustomColors() {
    _primaryController.clear();
    _secondaryController.clear();
    _tertiaryController.clear();
    _errorController.clear();
    _surfaceController.clear();
    _surfaceLightController.clear();
    _surfaceDarkController.clear();
    setState(() {
      _primaryPreview = null;
      _secondaryPreview = null;
      _tertiaryPreview = null;
      _errorPreview = null;
      _surfacePreview = null;
      _surfaceLightPreview = null;
      _surfaceDarkPreview = null;
    });
    context.chroma.clearSeeds();
  }

  Future<void> _openPicker(String label, TextEditingController textController, Color? current, void Function(Color) onPicked) async {
    final color = await ChromaColorPicker.show(
      context,
      initialColor: current ?? Colors.blue,
      title: 'Pick $label',
    );
    if (color != null) {
      setState(() {
        onPicked(color);
        textController.text = ChromaThemeUtils.toHex(color);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = context.chromaText;
    final controller = context.chroma;
    final currentMode = controller.mode;
    final currentPalette = controller.palette;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Appearance Settings",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          
          // --- Theme Mode ---
          Text("Theme Mode", style: textTheme.titleMedium),
          const SizedBox(height: 8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SegmentedButton<ChromaThemeMode>(
              segments: const [
                ButtonSegment(value: ChromaThemeMode.system, label: Text("System"), icon: Icon(Icons.settings_brightness)),
                ButtonSegment(value: ChromaThemeMode.light, label: Text("Light"), icon: Icon(Icons.light_mode)),
                ButtonSegment(value: ChromaThemeMode.dark, label: Text("Dark"), icon: Icon(Icons.dark_mode)),
                ButtonSegment(value: ChromaThemeMode.highContrast, label: Text("Contrast"), icon: Icon(Icons.contrast)),
                ButtonSegment(value: ChromaThemeMode.amoled, label: Text("AMOLED"), icon: Icon(Icons.brightness_3)),
              ],
              selected: {currentMode},
              onSelectionChanged: (Set<ChromaThemeMode> newSelection) {
                controller.setTheme(newSelection.first);
              },
            ),
          ),
          
          const SizedBox(height: 32),

          // --- Pre-defined Palettes ---
          Text("Pre-defined Palettes", style: textTheme.titleMedium),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _paletteOptions.map((option) {
              return _PaletteChip(
                label: option.label,
                selected: currentPalette == option.palette &&
                    controller.seeds == null,
                onSelected: () {
                  controller.clearSeeds();
                  controller.setPalette(option.palette);
                },
              );
            }).toList(),
          ),

          const SizedBox(height: 32),
          const Divider(),
          const SizedBox(height: 16),

          // --- Custom Colors ---
          Text("Custom Colors (ChromaSeeds)", style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text("Pick colors or type hex codes. Only Primary is required.", style: textTheme.bodySmall),
          const SizedBox(height: 16),

          _buildColorInput(
            label: "Primary",
            hint: "e.g. #FF5733",
            controller: _primaryController,
            preview: _primaryPreview,
            onPickerTap: () => _openPicker("Primary", _primaryController, _primaryPreview, (c) => _primaryPreview = c),
            onClear: () => setState(() => _primaryPreview = null),
            onHexChanged: (text) {
              final c = ChromaThemeUtils.fromHex(text);
              if (c != null) setState(() => _primaryPreview = c);
            },
          ),
          const SizedBox(height: 12),

          _buildColorInput(
            label: "Secondary (Optional)",
            hint: "e.g. #4CAF50",
            controller: _secondaryController,
            preview: _secondaryPreview,
            onPickerTap: () => _openPicker("Secondary", _secondaryController, _secondaryPreview, (c) => _secondaryPreview = c),
            onClear: () => setState(() => _secondaryPreview = null),
            onHexChanged: (text) {
              final c = ChromaThemeUtils.fromHex(text);
              if (c != null) setState(() => _secondaryPreview = c);
            },
          ),
          const SizedBox(height: 12),

          _buildColorInput(
            label: "Tertiary (Optional)",
            hint: "e.g. #FF9800",
            controller: _tertiaryController,
            preview: _tertiaryPreview,
            onPickerTap: () => _openPicker("Tertiary", _tertiaryController, _tertiaryPreview, (c) => _tertiaryPreview = c),
            onClear: () => setState(() => _tertiaryPreview = null),
            onHexChanged: (text) {
              final c = ChromaThemeUtils.fromHex(text);
              if (c != null) setState(() => _tertiaryPreview = c);
            },
          ),
          const SizedBox(height: 12),

          _buildColorInput(
            label: "Error (Optional)",
            hint: "e.g. #F44336",
            controller: _errorController,
            preview: _errorPreview,
            onPickerTap: () => _openPicker("Error", _errorController, _errorPreview, (c) => _errorPreview = c),
            onClear: () => setState(() => _errorPreview = null),
            onHexChanged: (text) {
              final c = ChromaThemeUtils.fromHex(text);
              if (c != null) setState(() => _errorPreview = c);
            },
          ),
          
          const SizedBox(height: 20),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.layers, size: 20),
                      const SizedBox(width: 8),
                      Text("Surface / Background", style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 8),

                  SwitchListTile(
                    title: const Text("Separate Light & Dark surfaces"),
                    subtitle: Text(
                      _separateSurfaces
                          ? "Set different surface colors for each mode"
                          : "One seed auto-adapts to both modes",
                      style: textTheme.bodySmall,
                    ),
                    value: _separateSurfaces,
                    onChanged: (val) => setState(() => _separateSurfaces = val),
                    contentPadding: EdgeInsets.zero,
                  ),
                  
                  const SizedBox(height: 12),

                  if (!_separateSurfaces) ...[
                    _buildColorInput(
                      label: "Surface Seed (auto-adapts)",
                      hint: "e.g. #795548",
                      controller: _surfaceController,
                      preview: _surfacePreview,
                      onPickerTap: () => _openPicker("Surface", _surfaceController, _surfacePreview, (c) => _surfacePreview = c),
                      onClear: () => setState(() => _surfacePreview = null),
                      onHexChanged: (text) {
                        final c = ChromaThemeUtils.fromHex(text);
                        if (c != null) setState(() => _surfacePreview = c);
                      },
                    ),
                  ] else ...[
                    _buildColorInput(
                      label: "☀️ Light Surface",
                      hint: "e.g. #FFF8E1",
                      controller: _surfaceLightController,
                      preview: _surfaceLightPreview,
                      onPickerTap: () => _openPicker("Light Surface", _surfaceLightController, _surfaceLightPreview, (c) => _surfaceLightPreview = c),
                      onClear: () => setState(() => _surfaceLightPreview = null),
                      onHexChanged: (text) {
                        final c = ChromaThemeUtils.fromHex(text);
                        if (c != null) setState(() => _surfaceLightPreview = c);
                      },
                    ),
                    const SizedBox(height: 12),
                    _buildColorInput(
                      label: "🌙 Dark Surface",
                      hint: "e.g. #1A237E",
                      controller: _surfaceDarkController,
                      preview: _surfaceDarkPreview,
                      onPickerTap: () => _openPicker("Dark Surface", _surfaceDarkController, _surfaceDarkPreview, (c) => _surfaceDarkPreview = c),
                      onClear: () => setState(() => _surfaceDarkPreview = null),
                      onHexChanged: (text) {
                        final c = ChromaThemeUtils.fromHex(text);
                        if (c != null) setState(() => _surfaceDarkPreview = c);
                      },
                    ),
                  ],
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 24),
          
          Row(
            children: [
              Expanded(
                child: FilledButton.icon(
                  onPressed: _applyCustomColors,
                  icon: const Icon(Icons.color_lens),
                  label: const Text("Apply Custom Theme"),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _resetCustomColors,
                  icon: const Icon(Icons.refresh),
                  label: const Text("Reset to Default Palette"),
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildColorInput({
    required String label,
    required String hint,
    required TextEditingController controller,
    required Color? preview,
    required VoidCallback onPickerTap,
    required VoidCallback onClear,
    required ValueChanged<String> onHexChanged,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: onPickerTap,
          child: Container(
            width: 48,
            height: 48,
            margin: const EdgeInsets.only(top: 4),
            decoration: BoxDecoration(
              color: preview ?? Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Theme.of(context).colorScheme.outline,
                width: 1,
              ),
            ),
            child: preview == null
                ? Icon(Icons.colorize, size: 20, color: Theme.of(context).colorScheme.onSurfaceVariant)
                : null,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: TextField(
            controller: controller,
            onChanged: onHexChanged,
            decoration: InputDecoration(
              labelText: label,
              hintText: hint,
              border: const OutlineInputBorder(),
              prefixIcon: const Icon(Icons.tag),
              suffixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.palette),
                    tooltip: 'Open Color Picker',
                    onPressed: onPickerTap,
                  ),
                  IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      controller.clear();
                      onClear();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _PaletteChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onSelected;

  const _PaletteChip({required this.label, required this.selected, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) => onSelected(),
      showCheckmark: true,
    );
  }
}

class _PaletteOption {
  final ChromaPalette palette;
  final String label;

  const _PaletteOption(this.palette, this.label);
}
