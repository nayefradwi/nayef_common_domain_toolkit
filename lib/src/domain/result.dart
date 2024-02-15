import 'error.dart';

typedef FutureResult<T> = Future<Result<T>>;
typedef ResultStream<T> = Stream<Result<T>>;

class Result<T> {
  Result._();
  factory Result.success(T data) => ResultWithData<T>._(data);
  factory Result.error(ResultError error) => ResultWithError<T>._(error);
  factory Result.exception(e) =>
      ResultWithError<T>._(UnknownError(message: e.toString()));
}

class ResultWithData<T> extends Result<T> {
  final T data;
  ResultWithData._(this.data) : super._();
}

class ResultWithError<T> extends Result<T> {
  final ResultError error;
  ResultWithError._(this.error) : super._();
}
