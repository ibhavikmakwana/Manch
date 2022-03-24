import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supabase_playground/values/routes.dart';

class AuthState<T extends StatefulWidget> extends SupabaseAuthState<T> {
  @override
  void onUnauthenticated() {
    Navigator.pushNamedAndRemoveUntil(context, Routes.login, (route) => false);
  }

  @override
  void onAuthenticated(Session session) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      Routes.dashboard,
      (route) => false,
    );
  }

  @override
  void onPasswordRecovery(Session session) {
    // TODO Implement password recovery flow.
  }

  @override
  void onErrorAuthenticating(String message) {
    log('onErrorAuthenticating: $message');
  }
}
