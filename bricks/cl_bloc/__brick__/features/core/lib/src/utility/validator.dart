import 'package:core/core_exports.dart';

/// Validation utility mixin class for Flutter form fields.
/// Supports both static call usage (`Validator.validateEmail(val)`)
/// and class mixin usage (`class MyState with Validator`).
mixin class Validator {
  static final RegExp _nameRegExp = RegExp(r'^[a-zA-Z\s]*$');
  static final RegExp _mobileRegExp = RegExp(r'^[0-9]*$');
  static final RegExp _postCodeRegExp = RegExp(r'^[0-9]*$');
  static final RegExp _emailRegExp = RegExp(
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
  );

  static String? emptyValidate(String? value, String key) {
    if (value == null || value.trim().isEmpty) {
      return '$key ${S.current.mustNotBeEmpty}';
    }
    return null;
  }

  static String? validateName(String? value, String key) {
    if (value == null || value.isEmptyWithTrim()) {
      return '$key ${S.current.mustNotBeEmpty}';
    } else if (!_nameRegExp.hasMatch(value.trim())) {
      return '$key ${S.current.containsCharacters}';
    }
    return null;
  }

  static String? validateMobile(String? value) {
    if (value == null || value.isEmptyWithTrim()) {
      return '${S.current.phoneNumber} ${S.current.mustNotBeEmpty}';
    } else if (value.trim().length != AppConstants.mobileMaxLength) {
      return '${S.current.phoneNumber} ${S.current.mustBe} ${AppConstants.mobileMaxLength} ${S.current.digits}.';
    } else if (!_mobileRegExp.hasMatch(value.trim())) {
      return S.current.validMobile;
    }
    return null;
  }

  static String? validatePostCode(String? value) {
    if (value == null || value.isEmptyWithTrim()) {
      return '${S.current.pinCode} ${S.current.mustNotBeEmpty}';
    } else if (value.trim().length != AppConstants.postCodeMaxLength) {
      return '${S.current.pinCode} ${S.current.mustBe} ${AppConstants.postCodeMaxLength} ${S.current.digits}.';
    } else if (!_postCodeRegExp.hasMatch(value.trim())) {
      return S.current.validPinCode;
    }
    return null;
  }

  static String? validateOTP(String? value) {
    if (value == null || value.isEmptyWithTrim()) {
      return '${S.current.otp} ${S.current.mustNotBeEmpty}';
    } else if (value.trim().length != AppConstants.otpMaxLength) {
      return '${S.current.otp} ${S.current.mustBe} ${AppConstants.otpMaxLength} ${S.current.digits}.';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmptyWithTrim()) {
      return '${S.current.email} ${S.current.mustNotBeEmpty}';
    } else if (!_emailRegExp.hasMatch(value.trim())) {
      return S.current.validEmail;
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmptyWithTrim()) {
      return '${S.current.password} ${S.current.mustNotBeEmpty}';
    } else if (value.length < AppConstants.passwordMaxLength) {
      return '${S.current.password} ${S.current.validPasswordLength} ${AppConstants.passwordMaxLength}.';
    }
    return null;
  }

  static String? confirmPasswordValidate(
    String? newPassword,
    String? confirmPassword,
    String key,
  ) {
    if (confirmPassword == null || confirmPassword.isEmptyWithTrim()) {
      return '$key ${S.current.mustNotBeEmpty}';
    } else if (newPassword == null || newPassword.trim() != confirmPassword.trim()) {
      return S.current.passwordNotMatched;
    }
    return null;
  }
}
