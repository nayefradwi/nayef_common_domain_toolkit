import 'dart:async';

import 'result.dart';

mixin IUseCase<T, P> {
  Result<T> call({required P param}) {
    try {
      return execute(param);
    } catch (e) {
      return Result.exception(e);
    }
  }

  Result<T> execute(P param);
}

mixin IFutureUseCase<T, P> {
  FutureResult<T> call({required P param}) async {
    try {
      return await execute(param);
    } catch (e) {
      return Result.exception(e);
    }
  }

  FutureResult<T> execute(P param);
}

mixin IStreamUseCase<T, P> {
  final StreamController<Result<T>> _streamController =
      StreamController.broadcast();

  ResultStream<T> get stream => _streamController.stream;

  void startStream({required P param}) {
    try {
      processStream(param);
    } catch (e) {
      _streamController.add(Result.exception(e));
    }
  }

  void processStream(P param);

  void stopStream() => _streamController.close();

  void emit(Result<T> result) => _streamController.add(result);
}
