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
      return SignInScreen(
          //providers: const [],
          actions: [
            ForgotPasswordAction(((context, email) {
              final uri = Uri(
                path: '/sign-in/forgot-password',
                queryParameters: <String, String?>{'email': email},
              );
              context.push(uri.toString());
            })),
            AuthStateChangeAction(((context, state) {
              getAuthStateChangeCallback2(context, state);
            }))
            /* AuthStateChangeAction(((context, state) {
              final user = switch (state) {
                SignedIn state => state.user,
                UserCreated state => state.credential.user,
                _ => null,
              };

              if (user == null) {
                return;
              }

              if (state is UserCreated) {
                user.updateDisplayName(user.email!.split('@')[0]);
              }

              if (!user.emailVerified) {
                user.sendEmailVerification();
                const snackBar = SnackBar(
                  content: Text(
                      'Please check your email to verify your email address'),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
              context.pushReplacement('/');
            })) */
          ]);
    },
    routes: [forgotPasswordRoute]);

GoRoute homeRoute = GoRoute(
    name: 'home',
    path: '/',
    builder: (context, state) => const HomePage(),
    routes: [signInRoute, profileRoute]);

final appRouter = GoRouter(
  routes: [
    homeRoute,
  ],
);
