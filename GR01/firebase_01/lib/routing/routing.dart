import 'package:firebase_01/callbacks/firebase_actions.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../app_state.dart';
import '../screens/home_page.dart';

GoRoute profileRoute = GoRoute(
    path: 'profile',
    builder: (context, state) {
      return Consumer<ApplicationState>(
        builder: (context, appState, _) => ProfileScreen(
          key: ValueKey(appState.emailVerified),
          providers: const [],
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
                  child: const Text("Refresh Stato Utente"),
                ))
          ],
        ),
      );
    });

// forgot-password
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
    path: 'sign-in',
    builder: (context, state) {
      return SignInScreen(
        actions: [
          ForgotPasswordAction((getForgotPasswordCallback)),
          AuthStateChangeAction((getAuthStateChangeCallback))
        ],
      );
    },
    routes: [forgotPasswordRoute]);

GoRoute homeRoute = GoRoute(
    path: '/',
    builder: (context, state) => const HomePage(),
    routes: [signInRoute, profileRoute]);

final appRouter = GoRouter(routes: [homeRoute]);
