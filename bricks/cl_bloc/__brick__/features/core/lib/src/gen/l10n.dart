// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

class S {
  S();

  static S? _current;

  static S get current {
    return _current ?? S();
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    return instance ?? S.current;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  String get mustNotBeEmpty => Intl.message('must not be empty.', name: 'mustNotBeEmpty');
  String get mustBe => Intl.message('must be', name: 'mustBe');
  String get digits => Intl.message('digits', name: 'digits');
  String get validMobile => Intl.message('Enter valid Mobile number.', name: 'validMobile');
  String get pinCode => Intl.message('pinCode', name: 'pinCode');
  String get validPinCode => Intl.message('Enter valid pinCode.', name: 'validPinCode');
  String get otp => Intl.message('OTP', name: 'otp');
  String get validEmail => Intl.message('Enter Valid Email.', name: 'validEmail');
  String get validPasswordLength => Intl.message('minimum length should be', name: 'validPasswordLength');
  String get passwordNotMatched => Intl.message('New password and confirm password not matched', name: 'passwordNotMatched');
  String get containsCharacters => Intl.message('must contains only characters.', name: 'containsCharacters');
  String get firstName => Intl.message('First Name', name: 'firstName');
  String get lastName => Intl.message('Last Name', name: 'lastName');
  String get email => Intl.message('Email', name: 'email');
  String get register => Intl.message('Register', name: 'register');
  String get signIn => Intl.message('Sign in', name: 'signIn');
  String get somethingWentWrong => Intl.message('Something went wrong', name: 'somethingWentWrong');
  String get serverFailureMsg => Intl.message('Server might not be working', name: 'serverFailureMsg');
  String get noInternetConnection => Intl.message('No internet connection', name: 'noInternetConnection');
  String get login => Intl.message('Login', name: 'login');
  String get alreadyHaveAccount => Intl.message('Already have an account? ', name: 'alreadyHaveAccount');
  String get password => Intl.message('Password', name: 'password');
  String get confirmPassword => Intl.message('Confirm Password', name: 'confirmPassword');
  String get phoneNumber => Intl.message('Phone Number', name: 'phoneNumber');
  String get emailAddress => Intl.message('Email Address', name: 'emailAddress');
  String get showPassword => Intl.message('Show Password', name: 'showPassword');
  String get camera => Intl.message('Camera', name: 'camera');
  String get gallery => Intl.message('Gallery', name: 'gallery');
  String get noDataAvailable => Intl.message('No data available at this moment', name: 'noDataAvailable');
  String get appName => Intl.message('My App', name: 'appName');
  String get home => Intl.message('Home', name: 'home');
  String get settings => Intl.message('Settings', name: 'settings');
  String get darkMode => Intl.message('Dark Mode', name: 'darkMode');
  String get language => Intl.message('Language', name: 'language');
  String get english => Intl.message('English', name: 'english');
  String get hindi => Intl.message('Hindi', name: 'hindi');
  String get welcome => Intl.message('Welcome', name: 'welcome');
  String get welcomeMessage => Intl.message('Your app is ready to go!', name: 'welcomeMessage');
  String get settingsTitle => Intl.message('App Settings', name: 'settingsTitle');
  String get appearance => Intl.message('Appearance', name: 'appearance');
  String get general => Intl.message('General', name: 'general');
  String get version => Intl.message('Version', name: 'version');
  String get selectLanguage => Intl.message('Select Language', name: 'selectLanguage');
  String get logout => Intl.message('Logout', name: 'logout');
  String get profile => Intl.message('Profile', name: 'profile');
  String get notifications => Intl.message('Notifications', name: 'notifications');
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale('en'),
      Locale('hi'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);

  @override
  Future<S> load(Locale locale) => S.load(locale);

  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
