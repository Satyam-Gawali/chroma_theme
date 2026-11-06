import 'package:flutter/material.dart';
import 'package:chroma_theme/chroma_theme.dart';

void main() {
  runApp(
    ChromaTheme.builder(
      initialMode: ChromaThemeMode.system,
      initialPalette: ChromaPalette.emerald,
      brandProfiles: const [
        ChromaBrandProfile(
          name: 'Eco Emerald',
          palette: ChromaPalette.emerald,
        ),
        ChromaBrandProfile(
          name: 'Ocean Fintech',
          palette: ChromaPalette.oceanSignal,
        ),
        ChromaBrandProfile(
          name: 'Royal Berry',
          palette: ChromaPalette.royalBerry,
        ),
        ChromaBrandProfile(
          name: 'Neon Cyber',
          palette: ChromaPalette.neonForest,
        ),
      ],
      overrides: ChromaOverrides(
        appBarTheme: const AppBarTheme(centerTitle: true, elevation: 0),
        cardTheme: CardThemeData(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          elevation: 1,
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
      ),
      builder: (context, theme, darkTheme, themeMode) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Chroma Theme 2.0 Playground',
          theme: theme,
          darkTheme: darkTheme,
          themeMode: themeMode,
          home: const ChromaExampleApp(),
        );
      },
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
    _UiKitTab(),
    _WallpaperThemeTab(),
    _ColorMatrixTab(),
    _SuperpowersTab(),
    _EngineSettingsTab(),
  ];

  @override
  Widget build(BuildContext context) {
    final colors = context.chromaColors;
    final isDark = context.isDarkMode;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: colors.primaryContainer,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(Icons.palette_rounded, size: 20, color: colors.onPrimaryContainer),
            ),
            const SizedBox(width: 10),
            const Text(
              "Chroma Theme 2.0",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.style_rounded),
            tooltip: 'Theme BottomSheet',
            onPressed: () => showChromaThemeSheet(context),
          ),
          IconButton(
            icon: Icon(isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded),
            tooltip: 'Quick Toggle (Light/Dark/AMOLED)',
            onPressed: () => context.toggleTheme(supportAmoled: true),
          ),
          IconButton(
            icon: const Icon(Icons.shuffle_rounded),
            tooltip: 'Random Palette',
            onPressed: () => context.chroma.randomPalette(),
          ),
          IconButton(
            icon: const Icon(Icons.code_rounded),
            tooltip: 'Export Pure Flutter Theme',
            onPressed: () => _showExportDialog(context),
          ),
        ],
      ),
      body: _tabs[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (i) => setState(() => _currentIndex = i),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.widgets_outlined),
            selectedIcon: Icon(Icons.widgets_rounded),
            label: 'UI Kit',
          ),
          NavigationDestination(
            icon: Icon(Icons.wallpaper_outlined),
            selectedIcon: Icon(Icons.wallpaper_rounded),
            label: 'Wallpapers',
          ),
          NavigationDestination(
            icon: Icon(Icons.color_lens_outlined),
            selectedIcon: Icon(Icons.color_lens_rounded),
            label: '44 Colors',
          ),
          NavigationDestination(
            icon: Icon(Icons.bolt_outlined),
            selectedIcon: Icon(Icons.bolt_rounded),
            label: 'Superpowers',
          ),
          NavigationDestination(
            icon: Icon(Icons.tune_outlined),
            selectedIcon: Icon(Icons.tune_rounded),
            label: 'Engine',
          ),
        ],
      ),
    );
  }

  void _showExportDialog(BuildContext context) {
    final code = ChromaThemeExporter.exportToDart(
      scheme: context.chromaColors,
      themeName: 'ChromaExportedTheme',
      isDark: context.isDarkMode,
    );

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.code_rounded),
            SizedBox(width: 8),
            Text('Pure Flutter Theme Code'),
          ],
        ),
        content: SizedBox(
          width: double.maxFinite,
          height: 380,
          child: SingleChildScrollView(
            child: SelectableText(
              code,
              style: const TextStyle(fontFamily: 'monospace', fontSize: 11),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// TAB 1: UI KIT & DROP-IN WIDGETS
// =============================================================================
class _UiKitTab extends StatefulWidget {
  const _UiKitTab();

  @override
  State<_UiKitTab> createState() => _UiKitTabState();
}

class _UiKitTabState extends State<_UiKitTab> {
  bool _switchVal = true;
  bool _checkVal = true;
  int _chipSelection = 1;
  double _sliderVal = 0.65;
  int _segmentedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final colors = context.chromaColors;
    final text = context.chromaText;

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        // Drop-in Controls Card
        Card(
          color: colors.surfaceContainerLow,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.touch_app_rounded, color: colors.primary),
                    const SizedBox(width: 8),
                    Text(
                      'Ready-Made Drop-in Widgets',
                      style: text.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const Center(child: ChromaThemeToggle()),
                const SizedBox(height: 16),
                const Text('Quick Palette Swatches:', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                const ChromaPaletteSelector(size: 38),
              ],
            ),
          ),
        ),

        const SizedBox(height: 20),

        // Interactive Card Demo
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
                    const SizedBox(width: 10),
                    Text(
                      'Material 3 Dynamic Surfaces',
                      style: text.titleMedium?.copyWith(
                        color: colors.onPrimaryContainer,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Surfaces, outlines, and tonal containers adapt fluidly across Light, Dark, AMOLED, and High-Contrast modes.',
                  style: text.bodyMedium?.copyWith(
                    color: colors.onPrimaryContainer.withValues(alpha: 0.85),
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 24),
        _sectionTitle(context, 'Interactive Buttons'),
        const SizedBox(height: 12),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            FilledButton.icon(
              icon: const Icon(Icons.check, size: 18),
              onPressed: () {},
              label: const Text('Filled'),
            ),
            FilledButton.tonalIcon(
              icon: const Icon(Icons.star, size: 18),
              onPressed: () {},
              label: const Text('Tonal'),
            ),
            OutlinedButton.icon(
              icon: const Icon(Icons.refresh, size: 18),
              onPressed: () {},
              label: const Text('Outlined'),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Elevated'),
            ),
            TextButton(
              onPressed: () {},
              child: const Text('Text Button'),
            ),
          ],
        ),

        const SizedBox(height: 24),
        _sectionTitle(context, 'Segmented & Toggle Controls'),
        const SizedBox(height: 12),
        SegmentedButton<int>(
          segments: const [
            ButtonSegment(value: 0, label: Text('Day'), icon: Icon(Icons.wb_sunny_outlined)),
            ButtonSegment(value: 1, label: Text('Auto'), icon: Icon(Icons.brightness_auto)),
            ButtonSegment(value: 2, label: Text('Night'), icon: Icon(Icons.nightlight_outlined)),
          ],
          selected: {_segmentedIndex},
          onSelectionChanged: (val) => setState(() => _segmentedIndex = val.first),
        ),

        const SizedBox(height: 24),
        _sectionTitle(context, 'Selection Controls & Sliders'),
        const SizedBox(height: 12),
        Row(
          children: [
            Checkbox(value: _checkVal, onChanged: (v) => setState(() => _checkVal = v ?? true)),
            const Text('Enabled'),
            const Spacer(),
            Switch(value: _switchVal, onChanged: (v) => setState(() => _switchVal = v)),
            const Text('Active'),
          ],
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: [
            ChoiceChip(
              label: const Text('Standard Mode'),
              selected: _chipSelection == 1,
              onSelected: (_) => setState(() => _chipSelection = 1),
            ),
            ChoiceChip(
              label: const Text('Turbo Mode'),
              selected: _chipSelection == 2,
              onSelected: (_) => setState(() => _chipSelection = 2),
            ),
          ],
        ),
        Slider(
          value: _sliderVal,
          onChanged: (v) => setState(() => _sliderVal = v),
        ),

        const SizedBox(height: 20),
        _sectionTitle(context, 'Text Fields & Feedback'),
        const SizedBox(height: 12),
        const TextField(
          decoration: InputDecoration(
            labelText: 'Search or Input Field',
            hintText: 'Type to test colors...',
            prefixIcon: Icon(Icons.search_rounded),
            suffixIcon: Icon(Icons.clear_rounded),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            ElevatedButton.icon(
              icon: const Icon(Icons.notifications_active_outlined),
              label: const Text('Show SnackBar'),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Dynamic Theme SnackBar with proper M3 contrast!'),
                    action: SnackBarAction(label: 'UNDO', onPressed: () {}),
                  ),
                );
              },
            ),
            const SizedBox(width: 12),
            OutlinedButton.icon(
              icon: const Icon(Icons.message_outlined),
              label: const Text('Show Dialog'),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Dynamic M3 Dialog'),
                    content: const Text('This dialog uses your active ColorScheme container and surface tokens.'),
                    actions: [
                      TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
                      FilledButton(onPressed: () => Navigator.pop(ctx), child: const Text('Confirm')),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _sectionTitle(BuildContext context, String title) {
    return Text(
      title.toUpperCase(),
      style: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w900,
        letterSpacing: 1.2,
        color: context.chromaColors.onSurfaceVariant,
      ),
    );
  }
}

// =============================================================================
// TAB 2: WALLPAPERS & MOBILE DYNAMIC THEME EXTRACTOR
// =============================================================================
class _WallpaperItem {
  final String title;
  final String subtitle;
  final ImageProvider<Object> provider;
  final Color fallbackColor;

  const _WallpaperItem({
    required this.title,
    required this.subtitle,
    required this.provider,
    required this.fallbackColor,
  });
}

class _WallpaperThemeTab extends StatefulWidget {
  const _WallpaperThemeTab();

  @override
  State<_WallpaperThemeTab> createState() => _WallpaperThemeTabState();
}

class _WallpaperThemeTabState extends State<_WallpaperThemeTab> {
  bool _isLoading = false;
  String _selectedWallpaper = 'Deep Forest';
  final TextEditingController _urlController = TextEditingController();

  final List<_WallpaperItem> _wallpapers = const [
    _WallpaperItem(
      title: 'Deep Forest',
      subtitle: 'Emerald greens & earth moss',
      provider: NetworkImage('https://images.unsplash.com/photo-1448375240586-882707db888b?w=800&q=80'),
      fallbackColor: Color(0xFF2E7D32),
    ),
    _WallpaperItem(
      title: 'Sunset Horizon',
      subtitle: 'Warm amber, violet & dusk',
      provider: NetworkImage('https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800&q=80'),
      fallbackColor: Color(0xFFE65100),
    ),
    _WallpaperItem(
      title: 'Cyberpunk Neon',
      subtitle: 'Electric magenta & cyan glow',
      provider: NetworkImage('https://images.unsplash.com/photo-1518709268805-4e9042af9f23?w=800&q=80'),
      fallbackColor: Color(0xFF8E24AA),
    ),
    _WallpaperItem(
      title: 'Ocean Depths',
      subtitle: 'Deep sapphire & arctic foam',
      provider: NetworkImage('https://images.unsplash.com/photo-1505118380757-91f5f5632de0?w=800&q=80'),
      fallbackColor: Color(0xFF0277BD),
    ),
    _WallpaperItem(
      title: 'Desert Dunes',
      subtitle: 'Golden terracotta & sunlit sand',
      provider: NetworkImage('https://images.unsplash.com/photo-1509316975850-ff9c5deb0cd9?w=800&q=80'),
      fallbackColor: Color(0xFFD84315),
    ),
    _WallpaperItem(
      title: 'Chroma Brand Banner',
      subtitle: 'Bundled local asset banner',
      provider: AssetImage('assets/banner.png'),
      fallbackColor: Color(0xFF00796B),
    ),
  ];

  Future<void> _extractFromWallpaper(_WallpaperItem wallpaper) async {
    setState(() {
      _isLoading = true;
      _selectedWallpaper = wallpaper.title;
    });

    try {
      await context.chroma.setThemeFromImage(wallpaper.provider);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Theme extracted dynamically from "${wallpaper.title}"!'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        context.chroma.setDynamicSeed(wallpaper.fallbackColor);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Network image failed, applied fallback seed color.'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _extractFromCustomUrl() async {
    final url = _urlController.text.trim();
    if (url.isEmpty) return;

    setState(() => _isLoading = true);
    try {
      await context.chroma.setThemeFromImage(NetworkImage(url));
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Theme extracted from custom image URL!')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not load image: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.chromaColors;
    final chroma = context.chroma;

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Wallpaper Theme Extractor 🖼️',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Extract dynamic M3 themes from mobile wallpapers:',
                  style: TextStyle(fontSize: 13, color: colors.onSurfaceVariant),
                ),
              ],
            ),
            if (_isLoading)
              const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(strokeWidth: 2.5)),
          ],
        ),

        const SizedBox(height: 16),

        // Device System Wallpaper (Material You Monet)
        Card(
          color: colors.surfaceContainerLow,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.phone_android_rounded, color: colors.primary),
                    const SizedBox(width: 8),
                    const Text(
                      'Mobile Wallpaper (Android 12+ Material You)',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  'On Android devices, system wallpaper dynamic colors sync directly into Chroma Theme via setDynamicSeed(). Tap a system wallpaper seed below to test:',
                  style: TextStyle(fontSize: 12, color: colors.onSurfaceVariant),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    ActionChip(
                      avatar: const CircleAvatar(backgroundColor: Color(0xFF1B72E8), radius: 6),
                      label: const Text('Pixel Blue Wallpaper'),
                      onPressed: () {
                        chroma.setDynamicSeed(const Color(0xFF1B72E8));
                        setState(() => _selectedWallpaper = 'Pixel Blue Wallpaper');
                      },
                    ),
                    ActionChip(
                      avatar: const CircleAvatar(backgroundColor: Color(0xFF137333), radius: 6),
                      label: const Text('Forest Wallpaper'),
                      onPressed: () {
                        chroma.setDynamicSeed(const Color(0xFF137333));
                        setState(() => _selectedWallpaper = 'Forest Wallpaper');
                      },
                    ),
                    ActionChip(
                      avatar: const CircleAvatar(backgroundColor: Color(0xFFE8710A), radius: 6),
                      label: const Text('Sunset Wallpaper'),
                      onPressed: () {
                        chroma.setDynamicSeed(const Color(0xFFE8710A));
                        setState(() => _selectedWallpaper = 'Sunset Wallpaper');
                      },
                    ),
                    ActionChip(
                      avatar: const CircleAvatar(backgroundColor: Color(0xFF9C27B0), radius: 6),
                      label: const Text('Lavender Wallpaper'),
                      onPressed: () {
                        chroma.setDynamicSeed(const Color(0xFF9C27B0));
                        setState(() => _selectedWallpaper = 'Lavender Wallpaper');
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 16),

        // Active Extracted Palette Summary
        Card(
          color: colors.surfaceContainerLow,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.auto_awesome_rounded, color: colors.primary),
                    const SizedBox(width: 8),
                    Text(
                      'Active Source: $_selectedWallpaper',
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    const Spacer(),
                    if (chroma.seeds != null)
                      TextButton(
                        onPressed: () {
                          chroma.clearSeeds();
                          chroma.setPalette(ChromaPalette.emerald);
                          setState(() => _selectedWallpaper = 'Emerald Palette');
                        },
                        child: const Text('Reset Seeds'),
                      ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    _colorChip('Primary', colors.primary, colors.onPrimary),
                    const SizedBox(width: 8),
                    _colorChip('Secondary', colors.secondary, colors.onSecondary),
                    const SizedBox(width: 8),
                    _colorChip('Tertiary', colors.tertiary, colors.onTertiary),
                    const SizedBox(width: 8),
                    _colorChip('Surface', colors.surface, colors.onSurface),
                  ],
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 20),

        // Wallpaper Grid
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _wallpapers.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.15,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemBuilder: (ctx, index) {
            final w = _wallpapers[index];
            final isSelected = _selectedWallpaper == w.title;

            return InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: _isLoading ? null : () => _extractFromWallpaper(w),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isSelected ? colors.primary : Colors.black12,
                    width: isSelected ? 3 : 1,
                  ),
                  image: DecorationImage(
                    image: w.provider,
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(13),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.8),
                      ],
                    ),
                  ),
                  padding: const EdgeInsets.all(12),
                  alignment: Alignment.bottomLeft,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        w.title,
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                      ),
                      Text(
                        w.subtitle,
                        style: const TextStyle(color: Colors.white70, fontSize: 10),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),

        const SizedBox(height: 24),

        // Custom URL input
        const Text('Custom Wallpaper Image URL:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _urlController,
                decoration: const InputDecoration(
                  hintText: 'https://example.com/wallpaper.jpg',
                  isDense: true,
                ),
              ),
            ),
            const SizedBox(width: 10),
            FilledButton.icon(
              icon: const Icon(Icons.download_rounded, size: 18),
              label: const Text('Extract'),
              onPressed: _isLoading ? null : _extractFromCustomUrl,
            ),
          ],
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _colorChip(String label, Color color, Color onColor) {
    return Expanded(
      child: Container(
        height: 38,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.black12),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(color: onColor, fontSize: 10, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

// =============================================================================
// TAB 3: 44 COLOR TOKENS & TONAL MATRIX
// =============================================================================
class _ColorMatrixTab extends StatelessWidget {
  const _ColorMatrixTab();

  @override
  Widget build(BuildContext context) {
    final colors = context.chromaColors;
    final tones = context.chromaTones;

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text(
          'Dynamic Tonal Ranges',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        const Text('Cached 78 Material 3 tonal steps (0-100) per seed:'),
        const SizedBox(height: 20),

        _tonalBar(context, 'Primary', tones.primary),
        _tonalBar(context, 'Secondary', tones.secondary),
        _tonalBar(context, 'Tertiary', tones.tertiary),
        _tonalBar(context, 'Neutral (Surfaces)', tones.neutral),
        _tonalBar(context, 'Neutral Variant (Borders)', tones.neutralVariant),

        const SizedBox(height: 28),
        const Text(
          '44 Material 3 Color Roles',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        const Text('All 44 roles wired and verified across light/dark/AMOLED/contrast:'),
        const SizedBox(height: 16),

        _categoryHeader('Primary & Fixed Roles'),
        _colorGrid([
          _ColorBox('primary', colors.primary, colors.onPrimary),
          _ColorBox('primaryContainer', colors.primaryContainer, colors.onPrimaryContainer),
          _ColorBox('primaryFixed', colors.primaryFixed, colors.onPrimaryFixed),
          _ColorBox('primaryFixedDim', colors.primaryFixedDim, colors.onPrimaryFixed),
        ]),

        const SizedBox(height: 16),
        _categoryHeader('Secondary & Fixed Roles'),
        _colorGrid([
          _ColorBox('secondary', colors.secondary, colors.onSecondary),
          _ColorBox('secondaryContainer', colors.secondaryContainer, colors.onSecondaryContainer),
          _ColorBox('secondaryFixed', colors.secondaryFixed, colors.onSecondaryFixed),
          _ColorBox('secondaryFixedDim', colors.secondaryFixedDim, colors.onSecondaryFixed),
        ]),

        const SizedBox(height: 16),
        _categoryHeader('Tertiary & Fixed Roles'),
        _colorGrid([
          _ColorBox('tertiary', colors.tertiary, colors.onTertiary),
          _ColorBox('tertiaryContainer', colors.tertiaryContainer, colors.onTertiaryContainer),
          _ColorBox('tertiaryFixed', colors.tertiaryFixed, colors.onTertiaryFixed),
          _ColorBox('tertiaryFixedDim', colors.tertiaryFixedDim, colors.onTertiaryFixed),
        ]),

        const SizedBox(height: 16),
        _categoryHeader('Surfaces & Elevation Steps'),
        _colorGrid([
          _ColorBox('surface', colors.surface, colors.onSurface),
          _ColorBox('surfaceDim', colors.surfaceDim, colors.onSurface),
          _ColorBox('surfaceBright', colors.surfaceBright, colors.onSurface),
          _ColorBox('containerLowest', colors.surfaceContainerLowest, colors.onSurface),
          _ColorBox('containerLow', colors.surfaceContainerLow, colors.onSurface),
          _ColorBox('container', colors.surfaceContainer, colors.onSurface),
          _ColorBox('containerHigh', colors.surfaceContainerHigh, colors.onSurface),
          _ColorBox('containerHighest', colors.surfaceContainerHighest, colors.onSurface),
        ]),

        const SizedBox(height: 16),
        _categoryHeader('Outlines & Inverses'),
        _colorGrid([
          _ColorBox('outline', colors.outline, colors.surface),
          _ColorBox('outlineVariant', colors.outlineVariant, colors.onSurface),
          _ColorBox('inverseSurface', colors.inverseSurface, colors.onInverseSurface),
          _ColorBox('inversePrimary', colors.inversePrimary, colors.onSurface),
        ]),

        const SizedBox(height: 24),
        _categoryHeader('Chroma Theme Color Utilities'),
        Card(
          color: colors.surfaceContainerLow,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Harmonization & Toning (ChromaThemeUtils)',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    _utilityBox('Original Red', Colors.red, Colors.white),
                    const Icon(Icons.arrow_forward_rounded, size: 16),
                    _utilityBox(
                      'Harmonized',
                      ChromaThemeUtils.harmonize(Colors.red, colors.primary),
                      Colors.white,
                    ),
                    const SizedBox(width: 8),
                    _utilityBox(
                      'Lighten +20%',
                      ChromaThemeUtils.lighten(colors.primary, 0.2),
                      Colors.black,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _utilityBox(String label, Color color, Color textColor) {
    return Expanded(
      child: Container(
        height: 48,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
        alignment: Alignment.center,
        child: Text(label, style: TextStyle(color: textColor, fontSize: 9, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
      ),
    );
  }

  Widget _categoryHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800, letterSpacing: 0.5),
      ),
    );
  }

  Widget _colorGrid(List<_ColorBox> boxes) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 2.8,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      children: boxes,
    );
  }

  Widget _tonalBar(BuildContext context, String label, ChromaTonalPalette palette) {
    final shades = [0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 95, 99, 100];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: SizedBox(
            height: 26,
            child: Row(
              children: shades.map((s) => Expanded(child: Container(color: palette[s]))).toList(),
            ),
          ),
        ),
        const SizedBox(height: 14),
      ],
    );
  }
}

class _ColorBox extends StatelessWidget {
  final String name;
  final Color color;
  final Color onColor;

  const _ColorBox(this.name, this.color, this.onColor);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black.withValues(alpha: 0.08)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            name,
            style: TextStyle(color: onColor, fontWeight: FontWeight.bold, fontSize: 11),
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            '#${color.toARGB32().toRadixString(16).substring(2).toUpperCase()}',
            style: TextStyle(color: onColor.withValues(alpha: 0.75), fontSize: 9),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// TAB 4: SUPERPOWERS HUB
// =============================================================================
class _SuperpowersTab extends StatelessWidget {
  const _SuperpowersTab();

  @override
  Widget build(BuildContext context) {
    final chroma = context.chroma;
    final colors = context.chromaColors;
    final audit = ChromaAuditor.audit(colors);

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text(
          'Flagship Superpowers',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        const Text('Explore advanced built-in services:'),
        const SizedBox(height: 20),

        // 1. Accessibility Auditor Card
        Card(
          color: colors.surfaceContainerLow,
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      audit.isAccessible ? Icons.verified_rounded : Icons.warning_amber_rounded,
                      color: audit.isAccessible ? Colors.green : Colors.orange,
                    ),
                    const SizedBox(width: 10),
                    const Expanded(
                      child: Text(
                        'WCAG 2.1 Contrast Auditor',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Chip(
                      label: Text(
                        '${(audit.aaNormalPassRate * 100).toInt()}% Pass',
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
                      ),
                      backgroundColor: audit.isAccessible
                          ? Colors.green.withValues(alpha: 0.15)
                          : Colors.orange.withValues(alpha: 0.15),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  'Checks your active ColorScheme against W3C contrast standards for text readability.',
                  style: TextStyle(fontSize: 13, color: colors.onSurfaceVariant),
                ),
                const SizedBox(height: 12),
                OutlinedButton.icon(
                  icon: const Icon(Icons.rule_rounded, size: 18),
                  label: const Text('View Full Contrast Audit Report'),
                  onPressed: () => _showAuditDetails(context, audit),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 16),

        // 2. Multi-Brand Hot Swap
        Card(
          color: colors.surfaceContainerLow,
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.business_rounded),
                    SizedBox(width: 10),
                    Text(
                      'Multi-Brand Hot-Swap',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Instantly switch themes for white-label or client apps:',
                  style: TextStyle(fontSize: 13, color: colors.onSurfaceVariant),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    ActionChip(
                      avatar: const CircleAvatar(backgroundColor: Color(0xFF00796B), radius: 6),
                      label: const Text('Emerald Nature'),
                      onPressed: () => chroma.setPalette(ChromaPalette.emerald),
                    ),
                    ActionChip(
                      avatar: const CircleAvatar(backgroundColor: Color(0xFF1976D2), radius: 6),
                      label: const Text('Ocean Fintech'),
                      onPressed: () => chroma.setPalette(ChromaPalette.oceanSignal),
                    ),
                    ActionChip(
                      avatar: const CircleAvatar(backgroundColor: Color(0xFFC2185B), radius: 6),
                      label: const Text('Royal Luxury'),
                      onPressed: () => chroma.setPalette(ChromaPalette.royalBerry),
                    ),
                    ActionChip(
                      avatar: const CircleAvatar(backgroundColor: Color(0xFF212121), radius: 6),
                      label: const Text('Black Metal'),
                      onPressed: () => chroma.setPalette(ChromaPalette.blackMetal),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 16),

        // 3. Sun-Aware Daylight Scheduler
        Card(
          color: colors.surfaceContainerLow,
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.wb_twilight_rounded),
                    SizedBox(width: 10),
                    Text(
                      'Sun-Aware Daylight Scheduler',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Automate theme switching by wall clock sunrise & sunset times.',
                  style: TextStyle(fontSize: 13, color: colors.onSurfaceVariant),
                ),
                const SizedBox(height: 12),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Active Sunrise/Sunset Rule'),
                  subtitle: const Text('Light at 06:30 • AMOLED at 19:00'),
                  value: chroma.schedule != null,
                  onChanged: (active) {
                    if (active) {
                      chroma.setSchedule(
                        const ChromaSchedule(
                          lightTime: TimeOfDay(hour: 6, minute: 30),
                          darkTime: TimeOfDay(hour: 19, minute: 0),
                          darkTargetMode: ChromaThemeMode.amoled,
                        ),
                      );
                    } else {
                      chroma.setSchedule(null);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showAuditDetails(BuildContext context, ChromaAuditResult audit) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.65,
        maxChildSize: 0.9,
        builder: (_, scrollCtrl) => Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(
            controller: scrollCtrl,
            children: [
              const Text(
                'WCAG 2.1 Color Contrast Pairs',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'Normal text requires >= 4.5:1 (AA) or >= 7.0:1 (AAA).',
                style: TextStyle(color: Theme.of(ctx).colorScheme.onSurfaceVariant),
              ),
              const SizedBox(height: 16),
              ...audit.pairs.map((pair) {
                final passes = pair.passesAANormal;
                return ListTile(
                  dense: true,
                  leading: Icon(
                    passes ? Icons.check_circle_rounded : Icons.cancel_rounded,
                    color: passes ? Colors.green : Colors.red,
                  ),
                  title: Text('${pair.foregroundRole} on ${pair.backgroundRole}'),
                  subtitle: Text('Ratio: ${pair.ratio.toStringAsFixed(2)}:1 • AAA: ${pair.passesAAA ? "Yes" : "No"}'),
                  trailing: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: pair.backgroundColor,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: Colors.black26),
                    ),
                    alignment: Alignment.center,
                    child: Text('Aa', style: TextStyle(color: pair.foregroundColor, fontWeight: FontWeight.bold)),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

// =============================================================================
// TAB 5: ENGINE SETTINGS & PALETTE EXPLORER
// =============================================================================
class _EngineSettingsTab extends StatelessWidget {
  const _EngineSettingsTab();

  @override
  Widget build(BuildContext context) {
    final chroma = context.chroma;

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text('Engine Configuration', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        const SizedBox(height: 20),

        const Text('Theme Modes (5 Modes)', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
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

        const SizedBox(height: 28),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('All 22 Palettes', style: TextStyle(fontWeight: FontWeight.bold)),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios_rounded, size: 16),
                  tooltip: 'Previous Palette',
                  onPressed: () => chroma.previousPalette(),
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
                  tooltip: 'Next Palette',
                  onPressed: () => chroma.nextPalette(),
                ),
                IconButton(
                  icon: const Icon(Icons.shuffle, size: 18),
                  tooltip: 'Random',
                  onPressed: () => chroma.randomPalette(),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: ChromaPalette.values.where((p) => p != ChromaPalette.custom).map((p) {
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

        const SizedBox(height: 28),
        const Text('Dynamic 1-Tap Seed Generator', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        const Text('Generates full 44-color M3 scheme from a single seed color:'),
        const SizedBox(height: 12),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            Colors.deepPurple,
            Colors.indigo,
            Colors.blue,
            Colors.teal,
            Colors.green,
            Colors.amber,
            Colors.deepOrange,
            Colors.pink,
            Colors.blueGrey,
          ].map((c) {
            return GestureDetector(
              onTap: () => chroma.setDynamicSeed(c),
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: c,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                  boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
                ),
              ),
            );
          }).toList(),
        ),

        const SizedBox(height: 28),
        const Text('Multi-Seed Designer', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        const Text('Combine custom Primary, Secondary, and Neutral seeds:'),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ActionChip(
              avatar: const Icon(Icons.palette_rounded, size: 16),
              label: const Text('Mint & Lavender Seeds'),
              onPressed: () {
                chroma.setSeeds(
                  const ChromaSeeds(
                    primary: Color(0xFF00A896),
                    secondary: Color(0xFF8E7DBE),
                    neutralLight: Color(0xFFF7FBF9),
                    neutralDark: Color(0xFF101815),
                  ),
                );
              },
            ),
            ActionChip(
              avatar: const Icon(Icons.palette_rounded, size: 16),
              label: const Text('Gold & Indigo Seeds'),
              onPressed: () {
                chroma.setSeeds(
                  const ChromaSeeds(
                    primary: Color(0xFFFFB703),
                    secondary: Color(0xFF023047),
                    neutralLight: Color(0xFFFFFDF5),
                    neutralDark: Color(0xFF131518),
                  ),
                );
              },
            ),
          ],
        ),
        const SizedBox(height: 32),
      ],
    );
  }
}
