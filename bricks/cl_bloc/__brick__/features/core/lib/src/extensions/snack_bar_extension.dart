import 'package:core/core_exports.dart';
import 'package:flutter/material.dart';

extension SnackBarExtension on BuildContext {
  void showSuccessSnackBarOnState({
    required String message,
  }) {
    ScaffoldMessenger.of(this).showSnackBar(
      AppSnackBar.successSnackBar(message),
    );
  }

  void showErrorSnackBarOnState({
    required String message,
  }) {
    ScaffoldMessenger.of(this).showSnackBar(
      AppSnackBar.errorSnackBar(message),
    );
  }

  void showNoInternetSnackBarOnState() {
    ScaffoldMessenger.of(this).showSnackBar(
      AppSnackBar.snackBarNoInternetConnection(),
    );
  }
}
