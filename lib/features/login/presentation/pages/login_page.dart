import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_home_control/core/routes/app_routes.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  Future<String?> _authUser(LoginData data) async {
    try {
      // Tentar fazer login com email e senha
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: data.name,
        password: data.password,
      );

      // Obter o token do Firebase
      String? token = await userCredential.user?.getIdToken();
      String? uid = userCredential.user?.uid;

      if (token != null && uid != null) {
        // Salvar o token e o UID no SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('bearer_token', token);
        await prefs.setString('user_uid', uid);

        // Retorna null, indicando que o login foi bem-sucedido
        return null;
      } else {
        return "Erro ao obter token de autenticação.";
      }
    } catch (e) {
      return "Erro: ${e.toString()}";
    }
  }

  Future<String?> _registerUser(SignupData data) async {
    try {
      if (data.name != null && data.password != null) {
        // Tentar registrar o usuário
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: data.name!,
          password: data.password!,
        );
        // Registro bem-sucedido
        return null;
      } else {
        return "Erro ao cadastrar usuário";
      }
    } catch (e) {
      // Se ocorrer um erro no registro, retorna a mensagem de erro
      return "Erro ao cadastrar usuário: ${e.toString()}";
    }
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'Smart Home Control',
      onLogin: _authUser,
      onSignup: _registerUser,
      onRecoverPassword: (_) async =>
          null, // Você pode adicionar funcionalidade de recuperação de senha se necessário
      onSubmitAnimationCompleted: () {
        Navigator.pushReplacementNamed(context, AppRoutes.home);
      },
      theme: LoginTheme(
        primaryColor: Colors.green,
        accentColor: Colors.white,
        titleStyle: const TextStyle(color: Colors.black),
      ),
    );
  }
}
