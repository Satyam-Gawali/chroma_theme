import 'package:flutter/material.dart';
import 'package:chroma_theme/chroma_theme.dart';

import 'screens/components_tab.dart';
import 'screens/color_palette_tab.dart';
import 'screens/settings_tab.dart';
import 'screens/showcase_screen.dart';

void main() {
  runApp(
    ChromaTheme(
      initialMode: ChromaThemeMode.light,
      initialPalette: ChromaPalette.blue,

      // 🔥 ChromaOverrides: Customize specific Material components globally
      overrides: ChromaOverrides(
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
        ),
        cardTheme: CardThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 2,
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
        snackBarTheme: SnackBarThemeData(
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
      child: const ScaffoldWithNav(),
    ),
  );
}

class ScaffoldWithNav extends StatefulWidget {
  const ScaffoldWithNav({super.key});

  @override
  State<ScaffoldWithNav> createState() => _ScaffoldWithNavState();
}

class _ScaffoldWithNavState extends State<ScaffoldWithNav> {
  int _currentIndex = 0;

  final List<Widget> _tabs = const [
    ComponentsTab(),
    ColorPaletteTab(),
    SettingsTab(),
  ];

  @override
  Widget build(BuildContext context) {
    // 🔥 Using context.chromaText extension instead of Theme.of(context).textTheme
    final textTheme = context.chromaText;

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('assets/logo.png'),
        ),
        title: Text(
          "Chroma Theme",
          style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              context.chroma.isDark ? Icons.light_mode : Icons.dark_mode,
            ),
            onPressed: () {
              context.chroma.setTheme(
                context.chroma.isDark ? ChromaThemeMode.light : ChromaThemeMode.dark,
              );
            },
          ),
        ],
      ),
      body: _tabs[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() => _currentIndex = index);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.widgets_outlined),
            selectedIcon: Icon(Icons.widgets),
            label: 'Components',
          ),
          NavigationDestination(
            icon: Icon(Icons.palette_outlined),
            selectedIcon: Icon(Icons.palette),
            label: 'Palette',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}