import 'package:nayef_common_domain_toolkit/src/domain/error.dart';

typedef FutureResult<T> = Future<Result<T>>;
typedef ResultStream<T> = Stream<Result<T>>;

abstract class Result<T> {
  Result._();
  factory Result.success(T data) => ResultWithData<T>._(data);
  factory Result.error(ResultError error) => ResultWithError<T>._(error);
  factory Result.exception(Object e) =>
      ResultWithError<T>._(UnknownError(message: e.toString()));

  bool get isSuccess => this is ResultWithData<T>;
  bool get isError => this is ResultWithError<T>;

  Future<R> foldAsync<R>({
    required Future<R> Function(T data) onSuccess,
    required Future<R> Function(ResultError error) onError,
  }) async {
    try {
      if (isError) return await onError((this as ResultWithError<T>).error);
      return await onSuccess((this as ResultWithData<T>).data);
    } catch (e) {
      return onError(UnknownError(message: e.toString()));
    }
  }

  R fold<R>({
    required R Function(T data) onSuccess,
    required R Function(ResultError error) onError,
  }) {
    try {
      if (isError) return onError((this as ResultWithError<T>).error);
      return onSuccess((this as ResultWithData<T>).data);
    } catch (e) {
      return onError(UnknownError(message: e.toString()));
    }
  }

  T? tryGetData() {
    if (isSuccess) return (this as ResultWithData<T>).data;
    return null;
  }

  ResultError? tryGetError() {
    if (isError) return (this as ResultWithError<T>).error;
    return null;
  }
}

class ResultWithData<T> extends Result<T> {
  final T data;
  ResultWithData._(this.data) : super._();
}

class ResultWithError<T> extends Result<T> {
  final ResultError error;
  ResultWithError._(this.error) : super._();
}
