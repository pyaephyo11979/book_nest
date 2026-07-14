import 'package:dio/dio.dart';
import 'package:book_nest/core/services/secure_storage_service.dart';

class APIService {
  final Dio dio = Dio();
  final String baseUrl = 'https://mxs008p0-3000.asse.devtunnels.ms/api';

  Future<Map<String, String>> _getHeaders(
    Map<String, String>? customHeader,
  ) async {
    final Map<String, String> headers = {
      'Accept': '*/*',
      'Content-Type': 'application/json; charset=utf-8',
    };
    if (customHeader != null) {
      headers.addAll(customHeader);
    }
    final token = await SecureStorageService().getAuthToken();
    if (token.isNotEmpty) {
      headers['Authorization'] = 'Bearer $token';
    }
    return headers;
  }

  Future<Response> get({
    required String url,
    Map<String, String>? header,
  }) async {
    final headers = await _getHeaders(header);
    final Response fetchedData = await dio.get(
      "$baseUrl$url",
      options: Options(headers: headers),
    );
    return fetchedData;
  }

  Future<Response> post({
    required String url,
    required Map<String, dynamic> body,
    Map<String, String>? header,
  }) async {
    final headers = await _getHeaders(header);
    final Response fetchedData = await dio.post(
      "$baseUrl$url",
      options: Options(headers: headers),
      data: body,
    );
    return fetchedData;
  }

  Future<Response> put({
    required String url,
    required Map<String, dynamic> body,
    Map<String, String>? header,
  }) async {
    final headers = await _getHeaders(header);
    final Response fetchedData = await dio.put(
      "$baseUrl$url",
      options: Options(headers: headers),
      data: body,
    );
    return fetchedData;
  }

  Future<Response> patch({
    required String url,
    required Map<String, dynamic> body,
    Map<String, String>? header,
  }) async {
    final headers = await _getHeaders(header);
    final Response fetchedData = await dio.patch(
      "$baseUrl$url",
      options: Options(headers: headers),
      data: body,
    );
    return fetchedData;
  }

  Future<Response> delete({
    required String url,
    Map<String, dynamic>? body,
    Map<String, String>? header,
  }) async {
    final headers = await _getHeaders(header);
    final Response fetchedData = await dio.delete(
      "$baseUrl$url",
      options: Options(headers: headers),
      data: body,
    );
    return fetchedData;
  }
}
