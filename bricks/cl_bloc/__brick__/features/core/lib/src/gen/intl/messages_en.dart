// ignore_for_file: type=lint, strict_top_level_inference, implementation_imports
import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "alreadyHaveAccount": MessageLookupByLibrary.simpleMessage("Already have an account? "),
        "appName": MessageLookupByLibrary.simpleMessage("My App"),
        "appearance": MessageLookupByLibrary.simpleMessage("Appearance"),
        "camera": MessageLookupByLibrary.simpleMessage("Camera"),
        "confirmPassword": MessageLookupByLibrary.simpleMessage("Confirm Password"),
        "containsCharacters": MessageLookupByLibrary.simpleMessage("must contains only characters."),
        "darkMode": MessageLookupByLibrary.simpleMessage("Dark Mode"),
        "digits": MessageLookupByLibrary.simpleMessage("digits"),
        "email": MessageLookupByLibrary.simpleMessage("Email"),
        "emailAddress": MessageLookupByLibrary.simpleMessage("Email Address"),
        "english": MessageLookupByLibrary.simpleMessage("English"),
        "firstName": MessageLookupByLibrary.simpleMessage("First Name"),
        "gallery": MessageLookupByLibrary.simpleMessage("Gallery"),
        "general": MessageLookupByLibrary.simpleMessage("General"),
        "hindi": MessageLookupByLibrary.simpleMessage("Hindi"),
        "home": MessageLookupByLibrary.simpleMessage("Home"),
        "language": MessageLookupByLibrary.simpleMessage("Language"),
        "lastName": MessageLookupByLibrary.simpleMessage("Last Name"),
        "login": MessageLookupByLibrary.simpleMessage("Login"),
        "logout": MessageLookupByLibrary.simpleMessage("Logout"),
        "mustBe": MessageLookupByLibrary.simpleMessage("must be"),
        "mustNotBeEmpty": MessageLookupByLibrary.simpleMessage("must not be empty."),
        "noDataAvailable": MessageLookupByLibrary.simpleMessage("No data available at this moment"),
        "noInternetConnection": MessageLookupByLibrary.simpleMessage("No internet connection"),
        "notifications": MessageLookupByLibrary.simpleMessage("Notifications"),
        "otp": MessageLookupByLibrary.simpleMessage("OTP"),
        "password": MessageLookupByLibrary.simpleMessage("Password"),
        "passwordNotMatched": MessageLookupByLibrary.simpleMessage("New password and confirm password not matched"),
        "phoneNumber": MessageLookupByLibrary.simpleMessage("Phone Number"),
        "pinCode": MessageLookupByLibrary.simpleMessage("pinCode"),
        "profile": MessageLookupByLibrary.simpleMessage("Profile"),
        "register": MessageLookupByLibrary.simpleMessage("Register"),
        "selectLanguage": MessageLookupByLibrary.simpleMessage("Select Language"),
        "serverFailureMsg": MessageLookupByLibrary.simpleMessage("Server might not be working"),
        "settings": MessageLookupByLibrary.simpleMessage("Settings"),
        "settingsTitle": MessageLookupByLibrary.simpleMessage("App Settings"),
        "showPassword": MessageLookupByLibrary.simpleMessage("Show Password"),
        "signIn": MessageLookupByLibrary.simpleMessage("Sign in"),
        "somethingWentWrong": MessageLookupByLibrary.simpleMessage("Something went wrong"),
        "validEmail": MessageLookupByLibrary.simpleMessage("Enter Valid Email."),
        "validMobile": MessageLookupByLibrary.simpleMessage("Enter valid Mobile number."),
        "validPasswordLength": MessageLookupByLibrary.simpleMessage("minimum length should be"),
        "validPinCode": MessageLookupByLibrary.simpleMessage("Enter valid pinCode."),
        "version": MessageLookupByLibrary.simpleMessage("Version"),
        "welcome": MessageLookupByLibrary.simpleMessage("Welcome"),
        "welcomeMessage": MessageLookupByLibrary.simpleMessage("Your app is ready to go!")
      };
}
