import 'dart:async';
import 'dart:io';

import 'package:core/core_exports.dart';

abstract class AppException implements Exception {}

class CustomException extends AppException {
  String message;

  CustomException(this.message);
}

class NoInternetException extends AppException {
  String message;

  NoInternetException(this.message);
}

extension ShowException on Exception {
  void getException() {
    try {
      if (this is SocketException) {
        throw CustomException(S.current.noInternetConnection);
      } else if (this is TimeoutException) {
        throw CustomException(S.current.somethingWentWrong);
      } else if (this is DioException) {
        String message = _handleDioError(this as DioException);
        NavigationService.navigatorKey.currentContext
            ?.showErrorSnackBarOnState(message: message);
      } else {
        NavigationService.navigatorKey.currentContext
            ?.showErrorSnackBarOnState(message: S.current.somethingWentWrong);
      }
    } catch (e) {
      AppLogger.w((e.toString()));
    }
  }
}

String _handleDioError(DioException error) {
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
      return 'Connection timeout occurred';
    case DioExceptionType.sendTimeout:
      return 'Send timeout occurred';
    case DioExceptionType.receiveTimeout:
      return 'Timeout occurred while sending or receiving';
    case DioExceptionType.badResponse:
      final statusCode = error.response?.statusCode;
      if (statusCode != null) {
        switch (statusCode) {
          case 400:
            return 'Bad Request';
          case 401:
            return 'Unauthorized';
          case 403:
            return 'Unauthorized';
          case 404:
            return 'Not Found';
          case 409:
            return 'Conflict';
          case 500:
            return 'Internal Server Error';
        }
      }
      break;
    case DioExceptionType.cancel:
      return 'Request canceled';
    case DioExceptionType.unknown:
      return 'No Internet Connection';
    case DioExceptionType.badCertificate:
      return 'Internal Server Error';
    case DioExceptionType.connectionError:
      return 'Connection Error';
    default:
      return 'Unknown Error';
  }
  return 'Unknown Error';
}
