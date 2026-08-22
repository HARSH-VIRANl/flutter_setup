import 'dart:async';
import 'package:flutter/material.dart';
import '../constants/app_routes.dart';

class NavigationGuard {
  static bool _isNavigating = false;
  static DateTime? _lastPopTime;

  static bool canNavigate() {
    final now = DateTime.now();

    // Prevent rapid multiple pops (debounce)
    if (_lastPopTime != null &&
        now.difference(_lastPopTime!) < const Duration(milliseconds: 400)) {
      return false;
    }

    if (_isNavigating) return false;

    _isNavigating = true;
    _lastPopTime = now;

    return true;
  }

  static void release() {
    Future.delayed(const Duration(milliseconds: 300), () {
      _isNavigating = false;
    });
  }
}

extension NavigatorExtension on BuildContext {
  NavigatorState get navigator => Navigator.of(this);

  void pushDialog(
      {required PageRoute pageRoute,
      FutureOr Function(Object? value)? onValue}) {
    navigator.push(pageRoute).then(
          onValue ?? (_) {},
        );
  }

  Future pushNamed(String routeName,
      {Object? arguments, FutureOr Function(Object?)? onValue}) async {
    await navigator.pushNamed(routeName, arguments: arguments).then(
          onValue ?? (_) {},
        );
  }

  void showCallScreen(Widget widget) {
    final context = this;
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.transparent,
      builder: (context) => widget,
    );
  }

  void pushNamedAndRemoveUntil(String routeName, bool Function(Route) predicate,
      {Object? arguments}) {
    navigator.pushNamedAndRemoveUntil(routeName, predicate,
        arguments: arguments);
  }

  void pushReplacementNamed(String routeName, {Object? arguments}) {
    navigator.pushReplacementNamed(routeName, arguments: arguments);
  }

  void pop({dynamic result}) {
    navigator.pop(result);
  }

  void popUntil(bool Function(Route) predicate) {
    navigator.popUntil(predicate);
  }

  void popAndPushNamed(String routeName, {Object? arguments}) {
    navigator.popAndPushNamed(routeName, arguments: arguments);
  }

  void safePop<T extends Object?>([T? result]) {
    if (!NavigationGuard.canNavigate()) return;

    try {
      if (navigator.canPop()) {
        navigator.pop(result); // ✅ call Navigator directly
      } else {
        // ✅ fallback WITHOUT go_router
        navigator.pushNamedAndRemoveUntil(
          AppRoutes.dashboard, // change to your root route
          (route) => false,
        );
      }
    } catch (e) {
      debugPrint('safePop error: $e');
    } finally {
      NavigationGuard.release();
    }
  }
}
