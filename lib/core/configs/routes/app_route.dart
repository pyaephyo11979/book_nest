import 'package:book_nest/views/about_us.dart';
import 'package:book_nest/views/book_detail.dart';
import 'package:book_nest/views/epub_reader.dart';
import 'package:book_nest/views/home.dart';
import 'package:book_nest/views/login.dart';
import 'package:book_nest/views/search.dart';
import 'package:book_nest/views/sign_up.dart';
import 'package:go_router/go_router.dart';
import 'package:book_nest/core/services/auth_service.dart';

final GoRouter router = GoRouter(
  initialLocation: '/login',
  redirect: (context, state) async {
    final isLoggedIn = await AuthService().isLoggedIn();
    if (!isLoggedIn && state.path != '/login' && state.path != '/signup') {
      return '/login';
    }
    return null;
  },
  routes: [
    GoRoute(path: '/', builder: (context, state) => const Home()),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPage(),
      redirect: (context, state) async {
        final isLoggedIn = await AuthService().isLoggedIn();
        if (isLoggedIn) {
          return '/';
        }
        return null;
      },
    ),
    GoRoute(path: '/signup', builder: (context, state) => const SignUpPage()),
    GoRoute(
      path: '/book/:id',
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        return BookDetail(id: id);
      },
    ),
    GoRoute(
      path: '/search',
      builder: (context, state) {
        final query = state.uri.queryParameters['query'] ?? '';
        return Search(searchQuery: query);
      },
    ),
    GoRoute(path: '/about_us', builder: (context, state) => const AboutUs()),
    GoRoute(
      path: '/epub_reader/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return EpubReader(id: id);
      },
    ),
  ],
);
