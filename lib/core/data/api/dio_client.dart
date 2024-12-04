import 'package:dio/dio.dart';
import 'package:smart_home_control/core/data/api/auth_interceptor.dart';

class DioClient {
  static Dio? _dio;

  static Dio getInstance() {
    _dio ??= Dio(
      BaseOptions(
        baseUrl: 'http://localhost:5084/api', // Substitua pela URL da sua API
        // validateStatus: (status) {
        //   // Permite tratar respostas com status até 499 como válidas
        //   return status != null && status < 500;
        // },
      ),
    )..interceptors.add(AuthInterceptor()); // Adiciona o interceptor

    return _dio!;
  }
}
