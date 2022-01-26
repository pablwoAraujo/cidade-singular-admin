import 'package:cidade_singular_admin/app/config.dart';
import 'package:dio/dio.dart';

class DioService {
  Dio _dio = Dio(BaseOptions(baseUrl: Config.apiURL));

  Dio get dio => _dio;

  Dio addToken(String token) {
    return dio
      ..interceptors.add(
          InterceptorsWrapper(onRequest: (RequestOptions options, handler) {
        return handler.next(_requestInterceptor(options, token));
      }));
  }

  RequestOptions _requestInterceptor(RequestOptions options, String token) {
    options.headers.addAll({"Authorization": "Bearer $token"});

    return options;
  }

  removeToken() {
    dio.interceptors.clear();
  }
}
