enum AppLogType {
  debug(0),
  info(1),
  fine(2),
  warning(3),
  error(4);

  final int priority;
  const AppLogType(this.priority);
}

class AppLog {
  static String methodNameKey = 'methodName';
  static String fileNameKey = 'fileName';
  static String lineKey = 'line';
  static String metadataKey = 'metadata';
  static String textKey = 'text';
  static String deviceTimeKey = 'deviceTime';
  static String traceKey = 'trace';
  static String exceptionKey = 'exception';
  static String typeKey = 'type';

  late String methodName;
  late String fileName;
  late String line;
  Map<String, dynamic>? metadata;
  late String text;
  late DateTime deviceTime;
  String? trace;
  Object? errorObject;
  late StackTrace stack;
  late AppLogType type;

  AppLog.info({
    required this.text,
    String? file,
    String? method,
    String? line,
    this.metadata,
    StackTrace? stack,
  }) {
    this.stack = stack ?? StackTrace.current;
    final trace = ClassifiedTrace.fromCurrent(this.stack);
    fileName = file ?? trace.file;
    methodName = method ?? trace.function;
    this.line = line ?? trace.line;
    deviceTime = DateTime.now();
    type = AppLogType.info;
  }

  AppLog.fine({
    required this.text,
    String? file,
    String? method,
    String? line,
    this.metadata,
    StackTrace? stack,
  }) {
    this.stack = stack ?? StackTrace.current;
    final trace = ClassifiedTrace.fromCurrent(this.stack);
    fileName = file ?? trace.file;
    methodName = method ?? trace.function;
    this.line = line ?? trace.line;
    deviceTime = DateTime.now();
    type = AppLogType.info;
  }

  AppLog.warning({
    required this.text,
    String? file,
    String? method,
    String? line,
    this.metadata,
    StackTrace? stack,
  }) {
    this.stack = stack ?? StackTrace.current;
    final trace = ClassifiedTrace.fromCurrent(this.stack);
    fileName = file ?? trace.file;
    methodName = method ?? trace.function;
    this.line = line ?? trace.line;
    deviceTime = DateTime.now();
    type = AppLogType.info;
  }

  AppLog.error({
    required this.errorObject,
    String? text,
    String? file,
    String? method,
    String? line,
    this.metadata,
    StackTrace? stack,
  }) {
    this.stack = stack ?? StackTrace.current;
    final trace = ClassifiedTrace.fromCurrent(this.stack);
    fileName = file ?? trace.file;
    methodName = method ?? trace.function;
    this.line = line ?? trace.line;
    deviceTime = DateTime.now();
    type = AppLogType.error;
    if (text == null) {
      this.text = errorObject.toString();
    } else {
      this.text = '$text: $errorObject';
    }
    this.trace = this.stack.toString();
  }

  AppLog.debug({
    required this.text,
    String? file,
    String? method,
    String? line,
    this.metadata,
    this.errorObject,
    bool shouldLogTrace = false,
    StackTrace? stack,
  }) {
    this.stack = stack ?? StackTrace.current;
    final trace = ClassifiedTrace.fromCurrent(this.stack);
    fileName = file ?? trace.file;
    methodName = method ?? trace.function;
    this.line = line ?? trace.line;
    deviceTime = DateTime.now();
    type = AppLogType.debug;
    if (shouldLogTrace) this.trace = this.stack.toString();
  }

  bool get isErrorOrWarning =>
      type == AppLogType.warning || type == AppLogType.error;

  Map<String, dynamic> toJson() {
    return {
      methodNameKey: methodName,
      fileNameKey: fileName,
      lineKey: line,
      metadataKey: metadata,
      exceptionKey: errorObject.toString(),
      traceKey: trace,
      deviceTimeKey: deviceTime.toIso8601String(),
      typeKey: type.name,
      textKey: text,
    };
  }

  @override
  String toString() {
    return '$deviceTime - [ ${type.name}; $line ]:'
        ' $fileName, $methodName, $text'
        '\nMetadata: $metadata\nException: $errorObject';
  }
}

class ClassifiedTrace {
  late final String function;
  late final String file;
  late final String line;
  ClassifiedTrace._({
    required this.function,
    required this.file,
    required this.line,
  });

  ClassifiedTrace._empty() {
    file = 'empty';
    function = 'empty';
    line = 'empty';
  }

  factory ClassifiedTrace.fromCurrent(StackTrace trace) {
    try {
      final frames = trace.toString().split('\n');
      final callerFunctionName = _getFunctionNameFromFrame(frames[1]);
      final fileInfo = _getFileInfoFromFrame(frames[0]);
      return ClassifiedTrace._(
        function: callerFunctionName,
        file: fileInfo[0],
        line: fileInfo[1],
      );
    } catch (e) {
      return ClassifiedTrace._empty();
    }
  }

  static List<String> _getFileInfoFromFrame(String trace) {
    final indexOfFileName = trace.indexOf(RegExp('[A-Za-z]+.dart'));
    final fileInfo = trace.substring(indexOfFileName);
    return fileInfo.split(':');
  }

  static String _getFunctionNameFromFrame(String trace) {
    final indexOfWhiteSpace = trace.indexOf(' ');
    final subStr = trace.substring(indexOfWhiteSpace);
    final indexOfFunction = subStr.indexOf(RegExp('[A-Za-z0-9]'));
    return subStr
        .substring(indexOfFunction)
        .substring(0, subStr.substring(indexOfFunction).indexOf(' '));
  }
}
