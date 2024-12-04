// lib/core/routes/app_routes.dart
import 'package:flutter/material.dart';
import 'package:smart_home_control/features/configuration/presentation/pages/configuration_page.dart';
import 'package:smart_home_control/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:smart_home_control/features/alerts/presentation/pages/alerts_page.dart';
import 'package:smart_home_control/features/devices/presentation/pages/devices_page.dart';
import 'package:smart_home_control/features/login/presentation/pages/login_page.dart';
import 'package:smart_home_control/features/modes/presentation/pages/modes_page.dart';
import 'package:smart_home_control/core/widget/bottom_nav_bar.dart';

class AppRoutes {
  static const String home = '/';
  static const String login = '/login';
  static const String configuration = '/configuration';
  static const String dashboard = '/dashboard';
  static const String modes = '/modes';
  static const String alerts = '/alerts';
  static const String devices = '/devices';
  static const String addNewDevice = 'devices/add_new_device';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const BottomNavBar());
      case login:
      return MaterialPageRoute(builder: (_) => const LoginPage());
      case configuration:
        return MaterialPageRoute(builder: (_) => const ConfigurationPage());
      case dashboard:
        return MaterialPageRoute(builder: (_) => const DashboardPage());
      case modes:
        return MaterialPageRoute(builder: (_) => const ModesPage());
      case alerts:
        return MaterialPageRoute(builder: (_) => const AlertsPage());
      case devices:
        return MaterialPageRoute(builder: (_) => const DevicesPage());
      default:
        return MaterialPageRoute(builder: (_) => const BottomNavBar());
    }
  }
}
