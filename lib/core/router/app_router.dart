import 'package:go_router/go_router.dart';
import '../../features/landing/presentation/pages/index.dart';
import '../../features/posts/presentation/pages/home_page.dart';

class AppRouter {
  static GoRouter get router => _router;

  static final GoRouter _router = GoRouter(
    initialLocation: '/',
    redirect: (context, state) => null,
    routes: [
      GoRoute(
        path: '/',
        redirect: (context, state) => '/onboarding',
      ),
      GoRoute(
        path: '/onboarding',
        name: 'onboarding',
        builder: (context, state) => const LandingPage(),
      ),
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (context, state) => const HomePage(),
      ),
    ],
  );
}