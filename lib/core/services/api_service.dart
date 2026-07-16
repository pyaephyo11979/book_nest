import 'package:dio/dio.dart';
import 'package:book_nest/core/services/secure_storage_service.dart';

class APIService {
  final Dio dio = Dio();
  final String baseUrl = 'https://mxs008p0-3000.asse.devtunnels.ms/api';
  Map<String, dynamic> defaultHeader = {
    "Content-Type": "application/json",
    "Accept": "application/json",
  };

  void getToken() async {
    final token = await SecureStorageService().getAuthToken();
    if (token.isNotEmpty) {
      defaultHeader.addAll({"Authorization": "Bearer $token"});
    }
  }

  Future<Response> get({required String url, bool? isTokenNeed}) async {
    if (isTokenNeed == true) {
      getToken();
    }
    final Response fetchedData = await dio.get(
      "$baseUrl$url",
      options: Options(headers: defaultHeader),
    );
    return fetchedData;
  }

  Future<Response> post({
    required String url,
    required Map<String, dynamic> body,
    bool? isTokenNeed,
  }) async {
    if (isTokenNeed == true) {
      getToken();
    }
    final Response fetchedData = await dio.post(
      "$baseUrl$url",
      options: Options(headers: defaultHeader),
      data: body,
    );
    return fetchedData;
  }

  Future<Response> put({
    required String url,
    required Map<String, dynamic> body,
    bool? isTokenNeed,
  }) async {
    if (isTokenNeed == true) {
      getToken();
    }
    final Response fetchedData = await dio.put(
      "$baseUrl$url",
      options: Options(headers: defaultHeader),
      data: body,
    );
    return fetchedData;
  }

  Future<Response> patch({
    required String url,
    required Map<String, dynamic> body,
    bool? isTokenNeed,
  }) async {
    if (isTokenNeed == true) {
      getToken();
    }
    final Response fetchedData = await dio.patch(
      "$baseUrl$url",
      options: Options(headers: defaultHeader),
      data: body,
    );
    return fetchedData;
  }

  Future<Response> delete({
    required String url,
    Map<String, dynamic>? body,
    bool? isTokenNeed,
  }) async {
    if (isTokenNeed == true) {
      getToken();
    }
    final Response fetchedData = await dio.delete(
      "$baseUrl$url",
      options: Options(headers: defaultHeader),
      data: body,
    );
    return fetchedData;
  }
}
