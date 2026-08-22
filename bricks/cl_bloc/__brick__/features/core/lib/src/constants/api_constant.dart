import 'package:flutter/foundation.dart';

class APIConstant {
  APIConstant._();

  //TODO: Change Base URL here
  static const String apiBaseURL = 'https://dummyjson.com/';

  //product list API endpoint
  static const String products = 'products';

  // agency dashboard demo endpoint
  static const String agencyDashboard = 'https://jsonplaceholder.typicode.com/users';
}

T? tryParseJsonObject<T>(Function fun) {
  try {
    return fun.call();
  } catch (e) {
    debugPrint('@16 parseJson exe::$e');
    return null;
  }
}

List<T> tryParseList<T>(
  List<dynamic> list,
  T? Function(Map<String, dynamic> map) parse,
) {
  return list
      .whereType<Map<String, dynamic>>()
      .map((data) {
        try {
          return parse.call(data);
        } catch (e) {
          debugPrint('Oh Error in Mapping ->----------------------<-');
          debugPrint('Error Message : $e');

          return null;
        }
      })
      .whereType<T>()
      .toList();
}
