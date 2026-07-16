import 'package:book_nest/core/services/api_service.dart';
import 'package:book_nest/core/services/secure_storage_service.dart';
import 'package:dio/dio.dart';

class Authinterceptor extends QueuedInterceptor {
  final Dio dio = Dio();
  final secureStorageService = SecureStorageService();

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (options.headers['Authorization'] == null) {
      String? token = await secureStorageService.getAuthToken();
      if (token != null) {
        options.headers['Authorization'] = 'Bearer $token';
      }
    }
    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      await secureStorageService.deleteAuthToken();
      try {
        String newToken = await _refreshToken();
        await secureStorageService.saveAuthToken(newToken);
        final options = err.requestOptions;
        options.headers['Authorization'] = 'Bearer $newToken';
        final response = await dio.fetch(options);
        return handler.resolve(response);
      } catch (e) {
        return handler.reject(err);
      }
    }
    return handler.next(err);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    return handler.next(response);
  }

  Future<String> _refreshToken() async {
    try {
      final response = await APIService().get(url: '/auth/refresh');
      if (response.statusCode == 200) {
        String newToken = response.data['data']['token'];
        return newToken;
      } else {
        throw Exception('Failed to refresh token');
      }
    } catch (e) {
      throw Exception('Failed to refresh token: $e');
    }
  }
}
