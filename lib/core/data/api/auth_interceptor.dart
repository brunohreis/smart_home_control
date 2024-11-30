import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthInterceptor extends Interceptor {
  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
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
}
