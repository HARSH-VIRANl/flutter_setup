import 'package:core/core_exports.dart';
import 'package:flutter/material.dart';

/// A mixin that provides validation functions using localized strings.
/// Use [ValidationMixin] for widgets that have access to BuildContext.
mixin ValidationMixin on BuildContext {
  // Mobile validation
  String? validateMobile(String? value) {
    if (value == null || value.trim().isEmpty) {
      return '${S.of(this).phoneNumber} ${S.of(this).mustNotBeEmpty}';
    }
    final mobile = value.replaceAll(RegExp(r'[^0-9]'), '');
    if (mobile.length != AppConstants.mobileMaxLength) {
      return '${S.of(this).phoneNumber} ${S.of(this).mustBe} ${AppConstants.mobileMaxLength} ${S.of(this).digits}.';
    }
    if (!RegExp(r'^[6-9]\d{9}$').hasMatch(mobile)) {
      return S.of(this).validMobile;
    }
    return null;
  }

  // Email validation
  String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return '${S.of(this).email} ${S.of(this).mustNotBeEmpty}';
    }
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    if (!emailRegex.hasMatch(value.trim())) {
      return S.of(this).validEmail;
    }
    return null;
  }

  // Passcode validation (numeric PIN)
  String? validatePasscode(String? value, {int length = 4}) {
    if (value == null || value.trim().isEmpty) {
      return '${S.of(this).pinCode} ${S.of(this).mustNotBeEmpty}';
    }
    if (value.length != length) {
      return '${S.of(this).pinCode} ${S.of(this).mustBe} $length ${S.of(this).digits}.';
    }
    if (!RegExp(r'^\d+$').hasMatch(value)) {
      return S.of(this).validPinCode;
    }
    return null;
  }

  // OTP validation
  String? validateOtp(String? value, {int length = 6}) {
    if (value == null || value.trim().isEmpty) {
      return '${S.of(this).otp} ${S.of(this).mustNotBeEmpty}';
    }
    if (value.length != length) {
      return '${S.of(this).otp} ${S.of(this).mustBe} $length ${S.of(this).digits}.';
    }
    if (!RegExp(r'^\d+$').hasMatch(value)) {
      return S.of(this).digits;
    }
    return null;
  }

  // Password validation
  String? validatePassword(String? value, {int minLength = 6}) {
    if (value == null || value.trim().isEmpty) {
      return '${S.of(this).password} ${S.of(this).mustNotBeEmpty}';
    }
    if (value.length < minLength) {
      return '${S.of(this).password} ${S.of(this).validPasswordLength} $minLength.';
    }
    return null;
  }

  // Confirm password validation
  String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.trim().isEmpty) {
      return '${S.of(this).confirmPassword} ${S.of(this).mustNotBeEmpty}';
    }
    if (value != password) {
      return S.of(this).passwordNotMatched;
    }
    return null;
  }

  // Name validation
  String? validateName(String? value, {int minLength = 2, int maxLength = 50}) {
    if (value == null || value.trim().isEmpty) {
      return '${S.of(this).firstName} ${S.of(this).mustNotBeEmpty}';
    }
    final trimmed = value.trim();
    if (trimmed.length < minLength) {
      return '${S.of(this).firstName} ${S.of(this).validPasswordLength} $minLength.';
    }
    if (!RegExp(r"^[a-zA-Z\s'-]+$").hasMatch(trimmed)) {
      return '${S.of(this).firstName} ${S.of(this).containsCharacters}';
    }
    return null;
  }

  // Generic required field validation
  String? validateRequired(String? value, {String fieldName = 'This field'}) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName ${S.of(this).mustNotBeEmpty}';
    }
    return null;
  }
}
