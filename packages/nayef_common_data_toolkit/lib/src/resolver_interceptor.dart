import 'package:dio/dio.dart';

class ResponseResolver extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response != null) return handler.resolve(err.response!);
    return super.onError(err, handler);
  }
}
