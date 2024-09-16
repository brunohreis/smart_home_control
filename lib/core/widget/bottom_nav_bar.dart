// lib/core/widget/bottom_nav_bar.dart
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
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
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: Colors.green,
        color: Colors.green,
        animationDuration: const Duration(milliseconds: 300),
        items: const <Widget>[
          Icon(
            Icons.devices,
            size: 26,
            color: Colors.white,
          ),
          Icon(
            Icons.list,
            size: 26,
            color: Colors.white,
          ),
          Icon(
            Icons.dashboard,
            size: 26,
            color: Colors.white,
          ),
          Icon(
            Icons.notifications,
            size: 26,
            color: Colors.white,
          ),
          Icon(
            Icons.settings,
            size: 26,
            color: Colors.white,
          ),
        ],
        onTap: _onItemTapped,
      ),
    );
  }
}
