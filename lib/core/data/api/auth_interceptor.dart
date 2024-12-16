import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_home_control/core/routes/app_routes.dart';
import 'package:smart_home_control/main.dart';

class AuthInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    try {
      // Acessa os SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      final bearer = prefs.getString('bearer_token');
      final uid = prefs.getString('user_uid');

      if (bearer != null && uid != null) {
        options.headers['Authorization'] = bearer;
        options.headers['user_uid'] = uid;
      }

      // Passa a requisição para o próximo interceptor
      return super.onRequest(options, handler);
    } catch (e) {
      return super.onRequest(options, handler);
    }
  }

  @override
  Future<void> onError(
      DioException err, ErrorInterceptorHandler handler) async {

    if (err.response?.statusCode == 401) {
      // Se a resposta for 401 (Unauthorized), apaga os dados de autenticação e direciona pra tela de login
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('bearer_token');
      await prefs.remove('user_uid');

      navigatorKey.currentState
          ?.pushNamedAndRemoveUntil(AppRoutes.login, (route) => false);
    }

    // Passa o erro para o próximo interceptor
    return super.onError(err, handler);
  }
}
