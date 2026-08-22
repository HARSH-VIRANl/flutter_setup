import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonDialog {
  static Future<bool?> showConfirmDialog({
    required BuildContext context,
    required String title,
    required String message,
    String confirmText = 'Confirm',
    String cancelText = 'Cancel',
    Color? confirmColor,
    bool barrierDismissible = true,
  }) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder:
          (context) => AlertDialog(
            title: Text(title),
            content: Text(message),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text(cancelText),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                style: TextButton.styleFrom(
                  foregroundColor:
                      confirmColor ?? Theme.of(context).primaryColor,
                ),
                child: Text(confirmText),
              ),
            ],
          ),
    );
  }

  static Future<void> showAlertDialog({
    required BuildContext context,
    required String title,
    required String message,
    String buttonText = 'OK',
    bool barrierDismissible = true,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder:
          (context) => AlertDialog(
            title: Text(title),
            content: Text(message),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(buttonText),
              ),
            ],
          ),
    );
  }

  static Future<T?> showCustomDialog<T>({
    required BuildContext context,
    required Widget child,
    bool barrierDismissible = true,
    EdgeInsetsGeometry? padding,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder:
          (context) => Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Padding(
              padding: padding ?? EdgeInsets.all(24.w),
              child: child,
            ),
          ),
    );
  }

  static Future<void> showLoadingDialog({
    required BuildContext context,
    String? message,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => PopScope(
            canPop: false,
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircularProgressIndicator(),
                  if (message != null) ...[
                    SizedBox(height: 16.h),
                    Text(message),
                  ],
                ],
              ),
            ),
          ),
    );
  }

  static void hideLoadingDialog(BuildContext context) {
    Navigator.pop(context);
  }
}
