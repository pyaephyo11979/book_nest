import 'package:book_nest/models/user_model.dart';
import 'package:book_nest/repositories/user_api.dart';
import 'package:flutter/material.dart';

class UserController {
  final UserApi userApi = UserApi();

  Future<UserModel> getUserData(int id) async {
    return await userApi.getUserData(id);
  }

  Future<void> login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    await userApi.login(email, password, context);
  }

  Future<void> signUp(
    String name,
    String email,
    String password,
    BuildContext context,
  ) async {
    await userApi.signUp(name, email, password, context);
  }

  Future<void> logout(BuildContext context) async {
    await userApi.logout(context);
  }
}
