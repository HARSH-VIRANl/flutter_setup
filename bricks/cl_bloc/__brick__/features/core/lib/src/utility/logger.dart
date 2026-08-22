import 'package:logger/logger.dart';

enum _LoggerType { info, warning, debug, error }

class AppLogger {
  AppLogger._();

  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 5,
      lineLength: 80,
      colors: true,
      printEmojis: true,
    ),
  );

  static void i(String message) => _printLogger(message, _LoggerType.info);

  static void w(String message) => _printLogger(message, _LoggerType.warning);

  static void d(String message) => _printLogger(message, _LoggerType.debug);

  static void e(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.e(message, error: error, stackTrace: stackTrace);
  }

  static void _printLogger(String message, _LoggerType type) {
    switch (type) {
      case _LoggerType.info:
        _logger.i(message);
        break;
      case _LoggerType.warning:
        _logger.w(message);
        break;
      case _LoggerType.debug:
        _logger.d(message);
        break;
      case _LoggerType.error:
        _logger.e(message);
        break;
    }
  }
}
