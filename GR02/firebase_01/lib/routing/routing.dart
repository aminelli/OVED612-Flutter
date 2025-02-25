import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:go_router/go_router.dart';
import '../screens/home_page_screen.dart';

GoRoute signInRoute = GoRoute(
  name: 'signIn',
  path: 'sign-in',
  builder: (context, state) {
    return SignInScreen(
      actions: [
        ForgotPasswordAction(callback)
      ]
    );
  },
);

GoRoute homeRoute = GoRoute(
    name: 'home',
    path: '/',
    builder: (context, state) => const HomePage(),
    routes: [

  ]
);

final appRouter = GoRouter(
  routes: [
    homeRoute,
  ],
);
