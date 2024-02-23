import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:manch/core/routes/routes_name.dart';
import 'package:manch/screen/dashboard/dashboard.dart';
import 'package:manch/screen/onboarding/login_sign_up_screen.dart';
import 'package:manch/screen/onboarding/splash_screen.dart';

final GoRouter goRouter = GoRouter(
  debugLogDiagnostics: true,
  initialLocation: RoutesName.splash.path,
  routes: [
    GoRoute(
      path: RoutesName.splash.path,
      name: RoutesName.splash.name,
      builder: (BuildContext context, GoRouterState state) {
        return SplashScreen();
      },
    ),
    GoRoute(
      path: RoutesName.loginSignup.path,
      name: RoutesName.loginSignup.name,
      builder: (BuildContext context, GoRouterState state) {
        return LoginSignUpScreen();
      },
    ),
    GoRoute(
      path: RoutesName.dashboard.path,
      name: RoutesName.dashboard.name,
      builder: (BuildContext context, GoRouterState state) {
        return Dashboard();
      },
    )
  ],
  errorBuilder: (BuildContext context, GoRouterState state) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('Under Development'),
      ),
    );
  },
);
