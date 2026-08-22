import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonBottomSheet {
  static Future<T?> show<T>({
    required BuildContext context,
    required Widget child,
    String? title,
    bool isDismissible = true,
    bool enableDrag = true,
    bool showDragHandle = true,
    bool isScrollControlled = true,
    double? height,
    EdgeInsetsGeometry? padding,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      isScrollControlled: isScrollControlled,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      builder:
          (context) => SafeArea(
            child: Container(
              height: height,
              padding: padding ?? EdgeInsets.all(16.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (showDragHandle)
                    Center(
                      child: Container(
                        width: 40.w,
                        height: 4.h,
                        margin: EdgeInsets.only(bottom: 16.h),
                        decoration: BoxDecoration(
                          color: Theme.of(context).dividerColor,
                          borderRadius: BorderRadius.circular(2.r),
                        ),
                      ),
                    ),
                  if (title != null) ...[
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16.h),
                  ],
                  child,
                ],
              ),
            ),
          ),
    );
  }

  static Future<T?> showOptionsList<T>({
    required BuildContext context,
    required List<BottomSheetOption<T>> options,
    String? title,
  }) {
    return show<T>(
      context: context,
      title: title,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children:
            options.map((option) {
              return ListTile(
                leading: option.icon != null ? Icon(option.icon) : null,
                title: Text(option.label),
                subtitle:
                    option.subtitle != null ? Text(option.subtitle!) : null,
                onTap: () => Navigator.pop(context, option.value),
                contentPadding: EdgeInsets.zero,
              );
            }).toList(),
      ),
    );
  }

  static Future<int?> showActionSheet({
    required BuildContext context,
    required List<String> actions,
    String? title,
    String? cancelText,
  }) {
    return show<int>(
      context: context,
      title: title,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ...actions.asMap().entries.map((entry) {
            return ListTile(
              title: Text(entry.value),
              onTap: () => Navigator.pop(context, entry.key),
              contentPadding: EdgeInsets.zero,
            );
          }),
          if (cancelText != null) ...[
            const Divider(),
            ListTile(
              title: Text(
                cancelText,
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
              onTap: () => Navigator.pop(context),
              contentPadding: EdgeInsets.zero,
            ),
          ],
        ],
      ),
    );
  }
}

class BottomSheetOption<T> {
  final T value;
  final String label;
  final String? subtitle;
  final IconData? icon;

  const BottomSheetOption({
    required this.value,
    required this.label,
    this.subtitle,
    this.icon,
  });
}
