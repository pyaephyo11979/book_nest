import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:book_nest/core/services/auth_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLoggedIn = false;

  void checkLoginStatus() async {
    isLoggedIn = await AuthService().isLoggedIn();
  }

  @override
  void initState() {
    super.initState();
    if (mounted) {
      checkLoginStatus();
      Future.delayed(const Duration(seconds: 2), () {
        if (isLoggedIn) {
          context.go('/home');
        } else {
          context.go('/login');
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Image.asset('assets/images/main_logo.png')),
    );
  }
}
