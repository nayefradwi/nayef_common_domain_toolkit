import 'package:dio/dio.dart';
import 'package:nayef_common_data_toolkit/src/api_response.dart';
import 'package:nayef_common_domain_toolkit/nayef_common_domain_toolkit.dart';

typedef ErrorResponseFactory = ErrorResponse<dynamic> Function(
  DioException error,
);

class ResponseParser extends Interceptor {
  ResponseParser({required this.errorResponseFactory});
  final ErrorResponseFactory errorResponseFactory;
  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    final successfulResponse = SuccessfulResponse<dynamic>.fromResponse(
      response,
    );
    return handler.resolve(successfulResponse);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.message != null) logger.warning(err.message);
    final errorResponse = errorResponseFactory(err);
    final newError = DioException(
      requestOptions: err.requestOptions,
      response: errorResponse,
      error: err.error,
      type: err.type,
    );
    handler.next(newError);
  }
}
