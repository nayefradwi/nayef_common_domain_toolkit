import 'package:nayef_common_domain_toolkit/src/app_log.dart';

Logger _logger = Logger('nayef_common_domain_toolkit_logger');

Logger get logger => _logger;

void setLoggerName(String loggerName) {
  _logger = Logger(loggerName);
}

class Logger {
  final String name;
  Logger(this.name);
  static AppLogType level = AppLogType.debug;

  static void Function(AppLog log) listen = (log) {};

  void debug(
    String text, {
    String? methodName,
    String? line,
    String? file,
    Map<String, dynamic>? metadata,
    Object? error,
    bool shouldLogTrace = false,
    StackTrace? stack,
  }) {
    final log = AppLog.debug(
      line: line,
      file: file,
      method: methodName,
      text: text,
      errorObject: error,
      metadata: metadata,
      shouldLogTrace: shouldLogTrace,
      stack: stack ?? StackTrace.current,
    );
    _printOnly(log);
  }

  void error(
    String? text, {
    Object? error,
    String? methodName,
    String? line,
    String? file,
    Map<String, dynamic>? metadata,
    StackTrace? stack,
  }) {
    final log = AppLog.error(
      line: line,
      file: file,
      method: methodName,
      errorObject: error,
      metadata: metadata,
      text: text,
      stack: stack ?? StackTrace.current,
    );
    _printOnly(log);
  }

  void info(
    String text, {
    String? methodName,
    String? line,
    String? file,
    Map<String, dynamic>? metadata,
  }) {
    final log = AppLog.info(
      line: line,
      file: file,
      method: methodName,
      text: text,
      metadata: metadata,
      stack: StackTrace.current,
    );
    _printOnly(log);
  }

  void fine(
    String text, {
    String? methodName,
    String? line,
    String? file,
    Map<String, dynamic>? metadata,
    StackTrace? stack,
  }) {
    final log = AppLog.fine(
      line: line,
      file: file,
      method: methodName,
      text: text,
      metadata: metadata,
      stack: stack ?? StackTrace.current,
    );
    _printOnly(log);
  }

  void warning(
    String text, {
    String? methodName,
    String? line,
    String? file,
    Map<String, dynamic>? metadata,
    StackTrace? stack,
  }) {
    final log = AppLog.warning(
      line: line,
      file: file,
      method: methodName,
      text: text,
      metadata: metadata,
      stack: stack ?? StackTrace.current,
    );
    _printOnly(log);
  }

  void _printOnly(AppLog log) {
    if (log.type.priority >= level.priority) listen(log);
  }
}
