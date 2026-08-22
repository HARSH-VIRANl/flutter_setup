import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum ButtonType { primary, secondary, outline, text }

class CommonButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final ButtonType type;
  final bool isLoading;
  final bool isExpanded;
  final Widget? icon;
  final double? width;
  final double height;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final TextStyle? textStyle;
  final Color? backgroundColor;
  final Color? foregroundColor;

  const CommonButton({
    super.key,
    required this.text,
    this.onPressed,
    this.type = ButtonType.primary,
    this.isLoading = false,
    this.isExpanded = true,
    this.icon,
    this.width,
    this.height = 48,
    this.borderRadius = 8,
    this.padding,
    this.textStyle,
    this.backgroundColor,
    this.foregroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget buttonChild =
        isLoading
            ? SizedBox(
              height: 20.h,
              width: 20.w,
              child: CircularProgressIndicator(
                strokeWidth: 2.w,
                valueColor: AlwaysStoppedAnimation<Color>(
                  _getForegroundColor(theme),
                ),
              ),
            )
            : Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null) ...[icon!, SizedBox(width: 8.w)],
                Text(
                  text,
                  style:
                      textStyle ??
                      TextStyle(
                        fontWeight: FontWeight.w600,
                        color: _getForegroundColor(theme),
                      ),
                ),
              ],
            );

    Widget button = switch (type) {
      ButtonType.primary => ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? theme.primaryColor,
          foregroundColor: foregroundColor ?? Colors.white,
          minimumSize: Size(width ?? 0, height.h),
          padding: padding ?? EdgeInsets.symmetric(horizontal: 24.w),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius.r),
          ),
        ),
        child: buttonChild,
      ),
      ButtonType.secondary => ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? theme.colorScheme.secondary,
          foregroundColor: foregroundColor ?? Colors.white,
          minimumSize: Size(width ?? 0, height.h),
          padding: padding ?? EdgeInsets.symmetric(horizontal: 24.w),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius.r),
          ),
        ),
        child: buttonChild,
      ),
      ButtonType.outline => OutlinedButton(
        onPressed: isLoading ? null : onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: foregroundColor ?? theme.primaryColor,
          minimumSize: Size(width ?? 0, height.h),
          padding: padding ?? EdgeInsets.symmetric(horizontal: 24.w),
          side: BorderSide(color: backgroundColor ?? theme.primaryColor),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius.r),
          ),
        ),
        child: buttonChild,
      ),
      ButtonType.text => TextButton(
        onPressed: isLoading ? null : onPressed,
        style: TextButton.styleFrom(
          foregroundColor: foregroundColor ?? theme.primaryColor,
          minimumSize: Size(width ?? 0, height.h),
          padding: padding ?? EdgeInsets.symmetric(horizontal: 24.w),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius.r),
          ),
        ),
        child: buttonChild,
      ),
    };

    if (isExpanded) {
      return SizedBox(width: double.infinity, child: button);
    }

    return button;
  }

  Color _getForegroundColor(ThemeData theme) {
    if (foregroundColor != null) return foregroundColor!;

    return switch (type) {
      ButtonType.primary => Colors.white,
      ButtonType.secondary => Colors.white,
      ButtonType.outline => theme.primaryColor,
      ButtonType.text => theme.primaryColor,
    };
  }
}

typedef AppMaterialButton = CommonButton;
