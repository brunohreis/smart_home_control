// lib/core/widget/bottom_nav_bar.dart
import 'package:flutter/material.dart';
import 'package:smart_home_control/features/alerts/presentation/pages/alerts_page.dart';
import 'package:smart_home_control/features/configuration/presentation/pages/configuration_page.dart';
import 'package:smart_home_control/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:smart_home_control/features/devices/presentation/pages/devices_page.dart';
import 'package:smart_home_control/features/modes/presentation/pages/modes_page.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 2;

  final List<Widget> _pages = const [
    DevicesPage(),
    ModesPage(),
    DashboardPage(),
    AlertsPage(),
    ConfigurationPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.devices),
            label: 'Devices',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Modes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Alerts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Configuration',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: Colors.blueGrey[800], // Cor de fundo personalizada
        selectedItemColor: Colors.yellowAccent, // Cor do item selecionado
        unselectedItemColor: Colors.white70, // Cor do item não selecionado
        iconSize: 24.0, // Tamanho dos ícones
        showSelectedLabels: true,
        showUnselectedLabels: false,
        selectedFontSize: 14.0, // Tamanho da fonte do rótulo selecionado
        unselectedFontSize: 12.0, // Tamanho da fonte do rótulo não selecionado
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
