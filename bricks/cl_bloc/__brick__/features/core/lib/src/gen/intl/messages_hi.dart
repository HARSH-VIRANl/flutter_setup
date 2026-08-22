// ignore_for_file: type=lint, strict_top_level_inference, implementation_imports
import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'hi';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "alreadyHaveAccount": MessageLookupByLibrary.simpleMessage("पहले से खाता है? "),
        "appName": MessageLookupByLibrary.simpleMessage("मेरा ऐप"),
        "appearance": MessageLookupByLibrary.simpleMessage("रूप-रंग"),
        "camera": MessageLookupByLibrary.simpleMessage("कैमरा"),
        "confirmPassword": MessageLookupByLibrary.simpleMessage("पासवर्ड की पुष्टि करें"),
        "containsCharacters": MessageLookupByLibrary.simpleMessage("केवल अक्षर होने चाहिए।"),
        "darkMode": MessageLookupByLibrary.simpleMessage("डार्क मोड"),
        "digits": MessageLookupByLibrary.simpleMessage("अंक"),
        "email": MessageLookupByLibrary.simpleMessage("ईमेल"),
        "emailAddress": MessageLookupByLibrary.simpleMessage("ईमेल पता"),
        "english": MessageLookupByLibrary.simpleMessage("अंग्रेज़ी"),
        "firstName": MessageLookupByLibrary.simpleMessage("पहला नाम"),
        "gallery": MessageLookupByLibrary.simpleMessage("गैलरी"),
        "general": MessageLookupByLibrary.simpleMessage("सामान्य"),
        "hindi": MessageLookupByLibrary.simpleMessage("हिंदी"),
        "home": MessageLookupByLibrary.simpleMessage("होम"),
        "language": MessageLookupByLibrary.simpleMessage("भाषा"),
        "lastName": MessageLookupByLibrary.simpleMessage("अंतिम नाम"),
        "login": MessageLookupByLibrary.simpleMessage("लॉगिन"),
        "logout": MessageLookupByLibrary.simpleMessage("लॉग आउट"),
        "mustBe": MessageLookupByLibrary.simpleMessage("होना चाहिए"),
        "mustNotBeEmpty": MessageLookupByLibrary.simpleMessage("खाली नहीं होना चाहिए।"),
        "noDataAvailable": MessageLookupByLibrary.simpleMessage("इस समय कोई डेटा उपलब्ध नहीं है"),
        "noInternetConnection": MessageLookupByLibrary.simpleMessage("इंटरनेट कनेक्शन नहीं है"),
        "notifications": MessageLookupByLibrary.simpleMessage("सूचनाएं"),
        "otp": MessageLookupByLibrary.simpleMessage("OTP"),
        "password": MessageLookupByLibrary.simpleMessage("पासवर्ड"),
        "passwordNotMatched": MessageLookupByLibrary.simpleMessage("नया पासवर्ड और पुष्टि पासवर्ड मेल नहीं खाते"),
        "phoneNumber": MessageLookupByLibrary.simpleMessage("फोन नंबर"),
        "pinCode": MessageLookupByLibrary.simpleMessage("पिन कोड"),
        "profile": MessageLookupByLibrary.simpleMessage("प्रोफ़ाइल"),
        "register": MessageLookupByLibrary.simpleMessage("पंजीकरण"),
        "selectLanguage": MessageLookupByLibrary.simpleMessage("भाषा चुनें"),
        "serverFailureMsg": MessageLookupByLibrary.simpleMessage("सर्वर काम नहीं कर रहा होगा"),
        "settings": MessageLookupByLibrary.simpleMessage("सेटिंग्स"),
        "settingsTitle": MessageLookupByLibrary.simpleMessage("ऐप सेटिंग्स"),
        "showPassword": MessageLookupByLibrary.simpleMessage("पासवर्ड दिखाएं"),
        "signIn": MessageLookupByLibrary.simpleMessage("साइन इन"),
        "somethingWentWrong": MessageLookupByLibrary.simpleMessage("कुछ गलत हो गया"),
        "validEmail": MessageLookupByLibrary.simpleMessage("वैध ईमेल दर्ज करें।"),
        "validMobile": MessageLookupByLibrary.simpleMessage("वैध मोबाइल नंबर दर्ज करें।"),
        "validPasswordLength": MessageLookupByLibrary.simpleMessage("न्यूनतम लंबाई होनी चाहिए"),
        "validPinCode": MessageLookupByLibrary.simpleMessage("वैध पिन कोड दर्ज करें।"),
        "version": MessageLookupByLibrary.simpleMessage("संस्करण"),
        "welcome": MessageLookupByLibrary.simpleMessage("स्वागत है"),
        "welcomeMessage": MessageLookupByLibrary.simpleMessage("आपका ऐप तैयार है!")
      };
}
