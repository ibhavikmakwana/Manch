enum RoutesName {
  splash,
  loginSignup,
  dashboard,
}

extension RoutesNameHelper on RoutesName {
  String get name {
    switch (this) {
      case RoutesName.splash:
        return 'splash';
      case RoutesName.loginSignup:
        return 'loginSignup';
      case RoutesName.dashboard:
        return 'dashboard';
    }
  }

  String get path {
    switch (this) {
      case RoutesName.splash:
        return '/splash';
      case RoutesName.loginSignup:
        return '/loginSignup';
      case RoutesName.dashboard:
        return '/dashboard';
    }
  }
}
