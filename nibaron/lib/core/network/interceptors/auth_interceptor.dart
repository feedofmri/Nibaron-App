import 'package:dio/dio.dart';
import '../../../core/services/auth_service.dart';
import '../../../core/dependency_injection/service_locator.dart';

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    // Add authentication token to requests
    final authService = sl<AuthService>();
    final token = await authService.getUserToken();

    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // Handle token refresh on 401 errors
    if (err.response?.statusCode == 401) {
      final authService = sl<AuthService>();

      try {
        await authService.refreshToken();

        // Retry the original request with new token
        final token = await authService.getUserToken();
        if (token != null) {
          err.requestOptions.headers['Authorization'] = 'Bearer $token';

          final dio = Dio();
          final response = await dio.fetch(err.requestOptions);
          handler.resolve(response);
          return;
        }
      } catch (e) {
        // Token refresh failed, logout user
        await authService.logout();
      }
    }

    handler.next(err);
  }
}
