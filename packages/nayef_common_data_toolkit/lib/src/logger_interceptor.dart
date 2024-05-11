import 'package:dio/dio.dart';
import 'package:nayef_common_domain_toolkit/nayef_common_domain_toolkit.dart';

class LoggerInterceptor extends Interceptor {
  LoggerInterceptor({this.trackError});
  void Function(DioException err)? trackError;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    logger
      ..finest('''
    Request: ${options.method} ${options.uri}
    headers: ${options.headers}
    ''')
      ..finest(options.data.toString());
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    logger
      ..finest('''
    Response:
    status code: ${response.statusCode}
    headers: ${response.headers}
    ''')
      ..finest(response.data.toString());
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    logger
      ..warning('''
    Error:
    ${err.message}
    ${err.response?.statusCode}
    ${err.response?.headers}
    ''')
      ..warning(err.response?.data.toString());
    trackError?.call(err);
    return super.onError(err, handler);
  }
}
