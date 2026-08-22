class AppConstants {
  AppConstants._();

  static const int otpMaxLength = 6;
  static const int mobileMaxLength = 10;
  static const int passwordMaxLength = 6;
  static const int postCodeMaxLength = 6;
  static const Duration noInternetConnectionDuration =
      Duration(milliseconds: 300);

  //define server status code here
  static const int serverSuccessCode = 200;
  static const int defaultHttpStatusCode = 500;

  //dashboard grid list keys
  static const String manageServicesKey = 'manage_services_key';
  static const String observationsKey = 'observationsKey';
  static const String documentKey = 'documentKey';
  static const String historyKey = 'historyKey';
  static const String subscriptionKey = 'subscriptionKey';
  static const String profileKey = 'profileKey';
  static const String notificationKey = 'notificationKey';
  static const String complaintsKey = 'complaintsKey';
  static const String forgotPasswordKey = 'forgotPasswordKey';
}
