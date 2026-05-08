import 'package:flutter/material.dart';
import 'package:chroma_theme/chroma_theme.dart';

void main() {
  runApp(
    ChromaTheme(
      initialMode: ChromaThemeMode.system,
      initialPalette: ChromaPalette.blue,
      overrides: ChromaOverrides(
        appBarTheme: const AppBarTheme(centerTitle: true, elevation: 0),
        cardTheme: CardThemeData(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          elevation: 2,
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
      ),
      child: const ChromaExampleApp(),
    ),
  );
}

class ChromaExampleApp extends StatefulWidget {
  const ChromaExampleApp({super.key});

  @override
  State<ChromaExampleApp> createState() => _ChromaExampleAppState();
}

class _ChromaExampleAppState extends State<ChromaExampleApp> {
  int _currentIndex = 0;

  final List<Widget> _tabs = const [
    _ComponentsTab(),
    _PaletteTab(),
    _SettingsTab(),
  ];

  @override
  Widget build(BuildContext context) {
    final colors = context.chromaColors;
    
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/logo.png', height: 28),
            const SizedBox(width: 12),
            const Text("Chroma Theme", style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.auto_awesome_motion_rounded),
            tooltip: 'Visualizer',
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const _ShowcaseScreen()),
            ),
          ),
        ],
      ),
      body: _tabs[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (i) => setState(() => _currentIndex = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.widgets_outlined), selectedIcon: Icon(Icons.widgets), label: 'UI Kit'),
          NavigationDestination(icon: Icon(Icons.palette_outlined), selectedIcon: Icon(Icons.palette), label: 'Colors'),
          NavigationDestination(icon: Icon(Icons.tune_rounded), selectedIcon: Icon(Icons.settings), label: 'Engine'),
        ],
      ),
    );
  }
}

// =============================================================================
// TAB 1: UI COMPONENTS
// =============================================================================
class _ComponentsTab extends StatelessWidget {
  const _ComponentsTab();

  @override
  Widget build(BuildContext context) {
    final colors = context.chromaColors;
    final text = context.chromaText;

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text('Material 3 Elements', style: text.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 20),
        
        Card(
          color: colors.primaryContainer,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.auto_awesome, color: colors.onPrimaryContainer),
                    const SizedBox(width: 12),
                    Text('Dynamic Surfaces', style: text.titleMedium?.copyWith(color: colors.onPrimaryContainer, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'These colors are generated dynamically from your seed color or selected palette.',
                  style: text.bodyMedium?.copyWith(color: colors.onPrimaryContainer.withOpacity(0.8)),
                ),
              ],
            ),
          ),
        ),
        
        const SizedBox(height: 24),
        _sectionTitle(context, 'Interactive Widgets'),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            FilledButton(onPressed: () {}, child: const Text('Filled')),
            FilledButton.tonal(onPressed: () {}, child: const Text('Tonal')),
            OutlinedButton(onPressed: () {}, child: const Text('Outlined')),
            ElevatedButton(onPressed: () {}, child: const Text('Elevated')),
          ],
        ),
        
        const SizedBox(height: 24),
        Row(
          children: [
            Checkbox(value: true, onChanged: (_) {}),
            const Text('Enabled'),
            const SizedBox(width: 20),
            Switch(value: true, onChanged: (_) {}),
            const Text('Active'),
          ],
        ),
        
        const SizedBox(height: 24),
        _sectionTitle(context, 'Input Fields'),
        const SizedBox(height: 12),
        const TextField(decoration: InputDecoration(labelText: 'Standard Input', hintText: 'Type something...')),
        const SizedBox(height: 16),
        const TextField(decoration: InputDecoration(labelText: 'Prefix Icon', prefixIcon: Icon(Icons.search))),
      ],
    );
  }

  Widget _sectionTitle(BuildContext context, String title) {
    return Text(title.toUpperCase(), style: TextStyle(fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 1.2, color: context.chromaColors.onSurfaceVariant));
  }
}

// =============================================================================
// TAB 2: COLOR PALETTE
// =============================================================================
class _PaletteTab extends StatelessWidget {
  const _PaletteTab();

  @override
  Widget build(BuildContext context) {
    final colors = context.chromaColors;
    final tones = context.chromaTones;

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text('Dynamic Tonal Palettes', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        const Text('Direct access to Material 3 tonal ranges (0-100).'),
        const SizedBox(height: 24),
        
        _tonalBar(context, 'Primary', tones.primary),
        _tonalBar(context, 'Secondary', tones.secondary),
        _tonalBar(context, 'Tertiary', tones.tertiary),
        _tonalBar(context, 'Neutral', tones.neutral),
        _tonalBar(context, 'Neutral Variant', tones.neutralVariant),
        
        const SizedBox(height: 32),
        const Text('ColorScheme Swatches', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          childAspectRatio: 2.5,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          children: [
            _colorBox('Primary', colors.primary, colors.onPrimary),
            _colorBox('Primary Container', colors.primaryContainer, colors.onPrimaryContainer),
            _colorBox('Secondary', colors.secondary, colors.onSecondary),
            _colorBox('Secondary Container', colors.secondaryContainer, colors.onSecondaryContainer),
            _colorBox('Tertiary', colors.tertiary, colors.onTertiary),
            _colorBox('Surface', colors.surface, colors.onSurface),
            _colorBox('Surface Container', colors.surfaceContainer, colors.onSurface),
            _colorBox('Outline', colors.outline, colors.surface),
          ],
        ),
      ],
    );
  }

  Widget _tonalBar(BuildContext context, String label, ChromaTonalPalette palette) {
    final shades = [0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: SizedBox(
            height: 32,
            child: Row(
              children: shades.map((s) => Expanded(child: Container(color: palette[s]))).toList(),
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _colorBox(String name, Color color, Color onColor) {
    return Container(
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.black.withOpacity(0.05))),
      padding: const EdgeInsets.all(12),
      alignment: Alignment.centerLeft,
      child: Text(name, style: TextStyle(color: onColor, fontWeight: FontWeight.bold, fontSize: 11)),
    );
  }
}

// =============================================================================
// TAB 3: ENGINE SETTINGS
// =============================================================================
class _SettingsTab extends StatelessWidget {
  const _SettingsTab();

  @override
  Widget build(BuildContext context) {
    final chroma = context.chroma;
    
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text('Theme Configuration', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        const SizedBox(height: 24),
        
        const Text('Theme Mode', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: ChromaThemeMode.values.map((mode) {
            final active = chroma.mode == mode;
            return ChoiceChip(
              label: Text(mode.name.toUpperCase()),
              selected: active,
              onSelected: (_) => chroma.setTheme(mode),
            );
          }).toList(),
        ),
        
        const SizedBox(height: 32),
        const Text('Premium Palettes', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ChromaPalette.blue,
            ChromaPalette.neonForest,
            ChromaPalette.oceanSignal,
            ChromaPalette.berryBlush,
            ChromaPalette.iceLatte,
            ChromaPalette.blackMetal,
            ChromaPalette.onyxSpring,
          ].map((p) {
            final active = chroma.palette == p && chroma.seeds == null;
            return ChoiceChip(
              label: Text(p.name),
              selected: active,
              onSelected: (_) {
                chroma.clearSeeds();
                chroma.setPalette(p);
              },
            );
          }).toList(),
        ),
        
        const SizedBox(height: 32),
        const Text('Custom Seed Generation', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        _ColorSeedPicker(
          label: 'Primary Seed',
          color: chroma.seeds?.primary ?? context.chromaColors.primary,
          onChanged: (c) => chroma.setSeeds(ChromaSeeds(primary: c)),
        ),
      ],
    );
  }
}

class _ColorSeedPicker extends StatelessWidget {
  final String label;
  final Color color;
  final ValueChanged<Color> onChanged;

  const _ColorSeedPicker({required this.label, required this.color, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final List<Color> quickColors = [Colors.red, Colors.pink, Colors.purple, Colors.deepPurple, Colors.indigo, Colors.blue, Colors.teal, Colors.green, Colors.orange, Colors.brown];
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(width: 40, height: 40, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.black12))),
            const SizedBox(width: 12),
            Text(label),
          ],
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: quickColors.map((c) => GestureDetector(
            onTap: () => onChanged(c),
            child: Container(width: 32, height: 32, decoration: BoxDecoration(color: c, shape: BoxShape.circle, border: Border.all(color: color == c ? Colors.white : Colors.transparent, width: 2))),
          )).toList(),
        ),
      ],
    );
  }
}

// =============================================================================
// SHOWCASE SCREEN
// =============================================================================
class _ShowcaseScreen extends StatelessWidget {
  const _ShowcaseScreen();

  @override
  Widget build(BuildContext context) {
    final colors = context.chromaColors;
    return Scaffold(
      backgroundColor: colors.surface,
      appBar: AppBar(title: const Text('Theme Visualizer'), leading: IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context))),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.palette_rounded, size: 80, color: colors.primary),
            const SizedBox(height: 24),
            Text('CHROMA ENGINE', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, letterSpacing: 4, color: colors.primary)),
            const SizedBox(height: 8),
            const Text('Production Grade Theming'),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: LinearProgressIndicator(value: 0.7, borderRadius: BorderRadius.circular(10)),
            ),
          ],
        ),
      ),
    );
  }
}
