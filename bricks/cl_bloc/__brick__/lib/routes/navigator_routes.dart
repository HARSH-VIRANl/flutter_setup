import 'package:auth/auth.dart';
import 'package:core/core_exports.dart';
import 'package:dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:{{{fullPath}}}/screens/splash.dart';

class NavigatorRoutes {
  static var generateRoute = (RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.root:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const SplashPage(),
        );
      case AppRoutes.login:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const LoginPage(),
        );
      case AppRoutes.register:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const RegisterPage(),
        );
      case AppRoutes.forgotPassword:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const ForgotPasswordPage(),
        );
      case AppRoutes.home:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const HomePage(),
        );
      case AppRoutes.settings:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const SettingsPage(),
        );
      case AppRoutes.demo:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const DemoPage(),
        );
      default:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const HomePage(),
        );
    }
  };

  NavigatorRoutes._();
}
