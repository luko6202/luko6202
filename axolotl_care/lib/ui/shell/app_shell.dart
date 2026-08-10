import 'package:flutter/material.dart';

import '../aquariums/aquariums_screen.dart';
import '../care/care_screen.dart';
import '../home/home_screen.dart';
import '../knowledge/knowledge_screen.dart';
import '../water/water_screen.dart';
import '../widgets/atmosphere_background.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _index = 0;

  static const _pages = [
    HomeScreen(),
    KnowledgeScreen(),
    WaterScreen(),
    CareScreen(),
    AquariumsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return AtmosphereBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 280),
            switchInCurve: Curves.easeOutCubic,
            switchOutCurve: Curves.easeInCubic,
            child: KeyedSubtree(
              key: ValueKey(_index),
              child: _pages[_index],
            ),
          ),
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: _index,
          onDestinationSelected: (value) => setState(() => _index = value),
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.menu_book_outlined),
              selectedIcon: Icon(Icons.menu_book),
              label: 'Wissen',
            ),
            NavigationDestination(
              icon: Icon(Icons.water_drop_outlined),
              selectedIcon: Icon(Icons.water_drop),
              label: 'Werte',
            ),
            NavigationDestination(
              icon: Icon(Icons.checklist_outlined),
              selectedIcon: Icon(Icons.checklist),
              label: 'Pflege',
            ),
            NavigationDestination(
              icon: Icon(Icons.waves_outlined),
              selectedIcon: Icon(Icons.waves),
              label: 'Becken',
            ),
          ],
        ),
      ),
    );
  }
}
