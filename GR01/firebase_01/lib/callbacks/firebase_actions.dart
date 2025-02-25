import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';



typedef ForgotPasswordCallback = void Function(BuildContext context, String? email);

typedef AuthStateChangeCallback<T> = void Function(BuildContext context, T state);

ForgotPasswordCallback getForgotPasswordCallback(
    BuildContext context, String? email) {
  return (context, email) {
    final uri = Uri(
      path: '/sign-in/forgot-password',
      queryParameters: <String, String?>{'email': email},
    );
    context.push(uri.toString());
  };
}

AuthStateChangeCallback<T> getAuthStateChangeCallback<T>(
    BuildContext context, T state) {
 
  return (context, state) {
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
          content: Text('Please check your email to verify your email address'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    context.pushReplacement('/');
  };
}

