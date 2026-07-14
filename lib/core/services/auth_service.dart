import 'secure_storage_service.dart';

class AuthService {
  bool isAuthenticated = false;

  Future<bool> isLoggedIn() async {
    final storedToken = await SecureStorageService().getAuthToken();
    if (storedToken.isNotEmpty) {
      isAuthenticated = true;
      return isAuthenticated;
    } else {
      isAuthenticated = false;
      return isAuthenticated;
    }
  }
}
