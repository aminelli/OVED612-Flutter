import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../app_state.dart';
import '../callback/firebase_actions.dart';
import '../screens/home_page_screen.dart';

GoRoute profileRoute = GoRoute(
  path: 'profile',
  builder: (context, state) {
    return Consumer<ApplicationState>(
        builder: (context, appState, _) => ProfileScreen(
              providers: const [],
              key: ValueKey(appState.emailVerified),
              actions: [
                SignedOutAction(((context) {
                  context.pushReplacement('/');
                }))
              ],
              children: [
                Visibility(
                  visible: !appState.emailVerified,
                  child: OutlinedButton(
                    onPressed: () {
                      appState.refreshLoggedInUser();
                    }, 
                    child: const Text("Refresh stato utente"),
                  ),
                )
              ],
            ));
  },
);

//forgot-password
GoRoute forgotPasswordRoute = GoRoute(
    path: 'forgot-password',
    builder: (context, state) {
      final arguments = state.uri.queryParameters;
      return ForgotPasswordScreen(
        email: arguments['email'],
        headerMaxExtent: 200,
      );
    });

GoRoute signInRoute = GoRoute(
    name: 'signIn',
    path: 'sign-in',
    builder: (context, state) {
      return SignInScreen(actions: [
        ForgotPasswordAction((getForgotPasswordCallback)),
        AuthStateChangeAction((getAuthStateChangeCallback))
      ]);
    },
    routes: [forgotPasswordRoute]);

GoRoute homeRoute = GoRoute(
    name: 'home',
    path: '/',
    builder: (context, state) => const HomePage(),
    routes: [
      signInRoute,
      profileRoute]);

final appRouter = GoRouter(
  routes: [
    homeRoute,
  ],
);
