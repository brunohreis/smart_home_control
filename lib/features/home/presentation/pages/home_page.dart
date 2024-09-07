import 'package:flutter/material.dart';
import 'package:smart_home_control/core/routes/app_routes.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, AppRoutes.configuration);
          },
          child: Text('Go to Configuration'),
        ),
      ),
    );
  }
}
