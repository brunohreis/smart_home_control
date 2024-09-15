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
    return const MaterialApp(
      title: 'Smart Home Control',
      onGenerateRoute: AppRoutes.generateRoute,
      initialRoute: AppRoutes.home,
      home: BottomNavBar(),
      debugShowCheckedModeBanner: false
    );
  }
}
