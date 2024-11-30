// lib/main.dart
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_home_control/core/data/models/devices_list_model.dart';
import 'package:smart_home_control/core/routes/app_routes.dart';
import 'package:smart_home_control/features/login/components/auth.dart';
import 'package:smart_home_control/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  // Verifique se há um token salvo nos SharedPreferences
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('bearer_token');

  
  runApp(
    ChangeNotifierProvider(
      create: (context) => DevicesListModel(),
      child: MyApp(userToken: token),
    ),
  );
}

class MyApp extends StatelessWidget {
  final String? userToken;
  const MyApp({super.key, this.userToken});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: userToken != null ? AppRoutes.home : AppRoutes.login,
      onGenerateRoute: AppRoutes.generateRoute,
      home: AuthCheck(),
    );
  }
}
