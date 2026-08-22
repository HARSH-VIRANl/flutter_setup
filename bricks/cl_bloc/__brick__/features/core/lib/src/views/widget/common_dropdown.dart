import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonDropdown<T> extends StatelessWidget {
  final T? value;
  final List<T> items;
  final String? hint;
  final String? label;
  final String Function(T) itemLabel;
  final ValueChanged<T?>? onChanged;
  final String? errorText;
  final bool isExpanded;
  final EdgeInsetsGeometry? contentPadding;
  final Widget? prefixIcon;
  final bool enabled;

  const CommonDropdown({
    super.key,
    required this.value,
    required this.items,
    required this.itemLabel,
    this.hint,
    this.label,
    this.onChanged,
    this.errorText,
    this.isExpanded = true,
    this.contentPadding,
    this.prefixIcon,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 8.h),
        ],
        DropdownButtonFormField<T>(
          initialValue: value,
          isExpanded: isExpanded,
          hint: hint != null ? Text(hint!) : null,
          decoration: InputDecoration(
            contentPadding:
                contentPadding ??
                EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            prefixIcon: prefixIcon,
            errorText: errorText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: Theme.of(context).dividerColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(
                color: Theme.of(context).primaryColor,
                width: 2.w,
              ),
            ),
          ),
          items:
              items.map((item) {
                return DropdownMenuItem<T>(
                  value: item,
                  child: Text(itemLabel(item)),
                );
              }).toList(),
          onChanged: enabled ? onChanged : null,
        ),
      ],
    );
  }
}
