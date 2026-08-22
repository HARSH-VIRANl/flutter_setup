import 'package:core/core_exports.dart';

class UseCase {
  String getMessage(Exception e) {
    if (e is CustomException) {
      return e.message;
    }
    return S.current.noInternetConnection;
  }

  void l(dynamic s) {
    AppLogger.w(s);
  }
}
