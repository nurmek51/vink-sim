import 'package:flutter/foundation.dart';

enum LogLevel { debug, info, warning, error, fatal }

abstract class LoggingService {
  void log(
    LogLevel level,
    String message, {
    Object? error,
    StackTrace? stackTrace,
  });
  void debug(String message);
  void info(String message);
  void warning(String message, {Object? error});
  void error(String message, {Object? error, StackTrace? stackTrace});
  void fatal(String message, {Object? error, StackTrace? stackTrace});
}

class ConsoleLoggingService implements LoggingService {
  @override
  void log(
    LogLevel level,
    String message, {
    Object? error,
    StackTrace? stackTrace,
  }) {
    final timestamp = DateTime.now().toIso8601String();
    final levelStr = level.name.toUpperCase();

    if (kDebugMode) {
      debugPrint('[$timestamp] $levelStr: $message');

      if (error != null) {
        debugPrint('Error: $error');
      }

      if (stackTrace != null) {
        debugPrint('StackTrace: $stackTrace');
      }
    }
  }

  @override
  void debug(String message) => log(LogLevel.debug, message);

  @override
  void info(String message) => log(LogLevel.info, message);

  @override
  void warning(String message, {Object? error}) =>
      log(LogLevel.warning, message, error: error);

  @override
  void error(String message, {Object? error, StackTrace? stackTrace}) =>
      log(LogLevel.error, message, error: error, stackTrace: stackTrace);

  @override
  void fatal(String message, {Object? error, StackTrace? stackTrace}) =>
      log(LogLevel.fatal, message, error: error, stackTrace: stackTrace);
}
