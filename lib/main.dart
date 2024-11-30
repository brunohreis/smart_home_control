// lib/main.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:smart_home_control/core/routes/app_routes.dart';
import 'package:smart_home_control/core/widget/bottom_nav_bar.dart';
import 'package:smart_home_control/features/login/presentation/pages/login_page.dart';
import 'package:smart_home_control/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); // Tela de loading
        }
        if (snapshot.hasData) {
          return const BottomNavBar(); // Usuário autenticado
        } else {
          return const LoginPage(); // Redireciona para a tela de login
        }
      },
    );
  }
}
