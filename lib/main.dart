// lib/main.dart
import 'package:flutter/material.dart';
import 'package:smart_home_control/core/routes/app_routes.dart';
import 'package:smart_home_control/core/widget/bottom_nav_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Home Control',
      onGenerateRoute: AppRoutes.generateRoute,
      initialRoute: AppRoutes.home,
      theme: ThemeData(
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.blue, // Defina a cor de fundo aqui
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
        ),
      ),
      home: const BottomNavBar(), // Defina o widget principal aqui
    );
  }
}
