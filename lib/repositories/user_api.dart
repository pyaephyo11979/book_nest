import 'package:book_nest/models/user_model.dart';
import 'package:book_nest/core/services/api_service.dart';
import 'package:book_nest/models/auth_model.dart';
import 'package:book_nest/core/services/secure_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dio/dio.dart';

class UserApi {
  Future<UserModel> getUserData(int id) async {
    try {
      final response = await APIService().get(url: '/users/profile');
      if (response.statusCode == 200) {
        return UserModel.fromJson(
          response.data['data'] as Map<String, dynamic>,
        );
      } else {
        throw Exception('Failed to get user data');
      }
    } on DioException catch (e) {
      final message = e.response?.data['message'] ?? 'Failed to get user data';
      throw Exception(message);
    }
  }

  Future<void> login(
    String email,
    String password,
    BuildContext context,
  ) async {
    try {
      final response = await APIService().post(
        url: '/auth/login',
        body: {'email': email, 'password': password},
      );
      if (response.statusCode == 200) {
        final authModel = AuthModel.fromJson(
          response.data['data'] as Map<String, dynamic>,
        );
        await SecureStorageService().saveAuthToken(authModel.token);
        if (context.mounted) {
          context.go('/');
        }
      } else {
        throw Exception('Failed to login');
      }
    } on DioException catch (e) {
      final message = e.response?.data['message'] ?? 'Failed to login';
      throw Exception(message);
    }
  }

  Future<void> signUp(
    String name,
    String email,
    String password,
    BuildContext context,
  ) async {
    try {
      final response = await APIService().post(
        url: '/auth/register',
        body: {'name': name, 'email': email, 'password': password},
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final authModel = AuthModel.fromJson(
          response.data['data'] as Map<String, dynamic>,
        );
        await SecureStorageService().saveAuthToken(authModel.token);
        if (context.mounted) {
          context.go('/');
        }
      } else {
        throw Exception('Failed to sign up');
      }
    } on DioException catch (e) {
      final message = e.response?.data['message'] ?? 'Failed to sign up';
      throw Exception(message);
    }
  }

  Future<void> logout(BuildContext context) async {
    try {
      String token = await SecureStorageService().getAuthToken();
      final response = await APIService().get(
        url: '/auth/logout',
        header: {'Authorization': 'Bearer $token'},
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to logout');
      }
    } on DioException catch (e) {
      final message = e.response?.data['message'] ?? 'Failed to logout';
      throw Exception(message);
    } finally {
      await SecureStorageService().deleteAuthToken();
      if (context.mounted) {
        context.go('/login');
      }
    }
  }
}
