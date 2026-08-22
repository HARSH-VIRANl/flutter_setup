import 'package:core/core_exports.dart';
import 'package:flutter/material.dart';

extension TextStyleExtension on BuildContext {
  TextStyle? titleLargeTextStyle({
    Color? color,
    double? fontSize,
    FontStyle? fontStyle,
    FontWeight? fontWeight,
    TextDecoration? textDecoration,
    double? textHeight,
    double? letterSpacing,
  }) {
    return Theme.of(this).textTheme.titleLarge?.copyWith(
          color: color,
          fontSize: fontSize,
          fontStyle: fontStyle,
          decoration: textDecoration,
          fontWeight: fontWeight,
          height: textHeight,
          letterSpacing: letterSpacing,
        );
  }

  TextStyle? titleMediumTextStyle({
    Color? color,
    double? fontSize,
    FontStyle? fontStyle,
    FontWeight? fontWeight,
    TextDecoration? textDecoration,
    double? textHeight,
    double? letterSpacing,
  }) {
    return Theme.of(this).textTheme.titleMedium?.copyWith(
          color: color,
          fontSize: fontSize ?? 16.sp,
          fontStyle: fontStyle,
          decoration: textDecoration,
          fontWeight: fontWeight ?? FontWeight.w500,
          height: textHeight,
          letterSpacing: letterSpacing,
          decorationColor: color,
        );
  }

  TextStyle? titleSmallTextStyle({
    Color? color,
    double? fontSize,
    FontStyle? fontStyle,
    FontWeight? fontWeight,
    TextDecoration? textDecoration,
    double? textHeight,
    double? letterSpacing,
  }) {
    return Theme.of(this).textTheme.titleSmall?.copyWith(
          color: color,
          fontSize: fontSize,
          fontStyle: fontStyle,
          fontWeight: fontWeight,
          decoration: textDecoration,
          height: textHeight,
          letterSpacing: letterSpacing,
        );
  }

  TextStyle? appBarTitleTextStyle({
    Color? color,
    double? fontSize,
    FontStyle? fontStyle,
    FontWeight? fontWeight,
    TextDecoration? textDecoration,
    double? textHeight,
  }) {
    return Theme.of(this).appBarTheme.titleTextStyle?.copyWith(
          color: color,
          fontSize: fontSize,
          fontStyle: fontStyle,
          decoration: textDecoration,
          fontWeight: fontWeight,
          height: textHeight,
        );
  }
}
