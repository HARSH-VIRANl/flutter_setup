import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final String? errorText;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onSubmitted;
  final FormFieldValidator<String>? validator;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool enabled;
  final bool readOnly;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? focusNode;
  final bool autofocus;
  final EdgeInsetsGeometry? contentPadding;

  const CommonTextField({
    super.key,
    this.controller,
    this.label,
    this.hint,
    this.errorText,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
    this.enabled = true,
    this.readOnly = false,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.inputFormatters,
    this.focusNode,
    this.autofocus = false,
    this.contentPadding,
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
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          onChanged: onChanged,
          onEditingComplete: onEditingComplete,
          onFieldSubmitted: onSubmitted,
          validator: validator,
          enabled: enabled,
          readOnly: readOnly,
          maxLines: maxLines,
          minLines: minLines,
          maxLength: maxLength,
          inputFormatters: inputFormatters,
          focusNode: focusNode,
          autofocus: autofocus,
          decoration: InputDecoration(
            hintText: hint,
            errorText: errorText,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            contentPadding:
                contentPadding ??
                EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
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
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.error,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
