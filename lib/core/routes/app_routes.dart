import 'package:flutter/material.dart';
import 'package:smart_home_control/features/configuration/presentation/pages/configuration_page.dart';
import 'package:smart_home_control/features/home/presentation/pages/home_page.dart';

class AppRoutes {
  static const String home = '/';
  static const String configuration = '/configuration';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => HomePage());
      case configuration:
        return MaterialPageRoute(builder: (_) => ConfigurationPage());
      default:
        return MaterialPageRoute(builder: (_) => HomePage());
    }
  }
}
