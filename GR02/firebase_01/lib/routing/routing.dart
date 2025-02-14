import 'package:go_router/go_router.dart';
import '../screens/home_page_screen.dart';

GoRoute homeRoute = GoRoute(
  name: 'home',
  path: '/',
  builder: (context, state) => const HomePage(),
);

final appRouter = GoRouter(
  routes: [
    homeRoute,
  ],
);
