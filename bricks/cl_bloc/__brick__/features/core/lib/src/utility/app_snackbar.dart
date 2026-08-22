import 'package:core/core_exports.dart';
import 'package:flutter/material.dart';

enum SnackBarType { normal, error, success }

class AppSnackBar {
  AppSnackBar._();

  static void showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(errorSnackBar(message));
  }

  static void showSuccessSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(successSnackBar(message));
  }

  static void showNormalSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(normalSnackBar(message));
  }

  static SnackBar snackBarNoInternetConnection() =>
      _snackBar(S.current.noInternetConnection);

  static SnackBar normalSnackBar(String message) => _snackBar(message);

  static SnackBar errorSnackBar(String message) =>
      _snackBar(message, snackBarType: SnackBarType.error);

  static SnackBar successSnackBar(String message) =>
      _snackBar(message, snackBarType: SnackBarType.success);

  static SnackBar _snackBar(
    String message, {
    SnackBarType snackBarType = SnackBarType.normal,
  }) {
    return SnackBar(
      content: Text(message),
      dismissDirection: DismissDirection.none,
      behavior: SnackBarBehavior.fixed,
      backgroundColor: snackBarType == SnackBarType.success
          ? Colors.green
          : snackBarType == SnackBarType.error
              ? Colors.red
              : null,
      duration: const Duration(seconds: 2),
    );
  }
}
