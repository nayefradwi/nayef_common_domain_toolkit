import 'package:nayef_common_domain_toolkit/nayef_common_domain_toolkit.dart';

const String unknownErrorCode = 'unknown_error';

abstract class ResultError {
  final String message;
  final String? code;
  final int statusCode;
  final StackTrace? stackTrace;
  ResultError(
    this.message, {
    this.code,
    this.statusCode = 0,
    this.stackTrace,
  }) {
    logger.severe(message, this, stackTrace);
  }

  @override
  String toString() {
    return 'message: $message, code: $code, '
        'statusCode: $statusCode\nstackTrace: $stackTrace';
  }
}

class NetworkError extends ResultError {
  NetworkError(super.message, {super.code});
}

class ServerError extends ResultError {
  ServerError(super.message, {super.code, super.statusCode = 0});
}

class UnknownError extends ResultError {
  UnknownError({
    String message = 'unknown error',
    super.code = unknownErrorCode,
    super.statusCode = 0,
  }) : super(
          message,
          stackTrace: StackTrace.current,
        );
}

class DomainError extends ResultError {
  DomainError(super.message);
}

class ValidationError extends ResultError {
  ValidationError(super.message, {required String code}) : super(code: code);
}
