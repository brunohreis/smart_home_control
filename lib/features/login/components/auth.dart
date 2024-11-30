import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_home_control/core/widget/bottom_nav_bar.dart';
import 'package:smart_home_control/features/login/presentation/pages/login_page.dart';

class AuthCheck extends StatelessWidget {
  const AuthCheck({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator()); // Tela de loading
        }
        if (snapshot.hasData) {
          // Quando o usuário estiver autenticado
          _saveUserToken(snapshot.data!);
          return const BottomNavBar(); // Usuário autenticado
        } else {
          return const LoginPage(); // Usuário não autenticado, redireciona para login
        }
      },
    );
  }

  // Função para salvar o token de autenticação nos SharedPreferences
  Future<void> _saveUserToken(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = await user.getIdToken() ?? "";
    await prefs.setString('auth_token', token);
  }
}
