import 'package:dio/dio.dart';
import 'package:nayef_common_domain_toolkit/nayef_common_domain_toolkit.dart';

abstract class ApiResponse<T> extends Response<T> {
  ApiResponse({required super.requestOptions});

  @override
  int get statusCode => super.statusCode ?? 0;

  bool get isSuccessful => this is SuccessfulResponse;

  bool get isError => this is ErrorResponse;
  ResultError? tryGetError() {
    if (this is ErrorResponse) {
      return (this as ErrorResponse).error;
    }
    return null;
  }
}

class SuccessfulResponse<T> extends ApiResponse<T> {
  SuccessfulResponse({required super.requestOptions});
  SuccessfulResponse.fromResponse(Response<T> response)
      : super(requestOptions: response.requestOptions) {
    data = response.data;
    headers = response.headers;
    extra = response.extra;
    statusCode = statusCode;
    response.isRedirect = response.isRedirect;
  }

  @override
  T get data => super.data!;
}

class ErrorResponse<T> extends ApiResponse<T> {
  final ResultError error;

  @override
  ErrorResponse({
    required super.requestOptions,
    required this.error,
  });
  ErrorResponse.fromResponse({
    required Response<T> response,
    required this.error,
  }) : super(requestOptions: response.requestOptions) {
    data = response.data;
    headers = response.headers;
    extra = response.extra;
    statusCode = statusCode;
    response.isRedirect = response.isRedirect;
  }

  ErrorResponse.fromApiRes({required ApiResponse<T> res, required this.error})
      : super(requestOptions: res.requestOptions) {
    data = res.data;
    headers = res.headers;
    extra = res.extra;
    statusCode = res.statusCode;
    isRedirect = res.isRedirect;
  }
}
