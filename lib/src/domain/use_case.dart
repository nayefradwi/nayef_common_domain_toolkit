import 'dart:async';

import 'result.dart';

abstract class IUseCase<T, P> {
  FutureResult<T> call({required P param}) async {
    try {
      return await execute(param);
    } catch (e) {
      return Result.exception(e);
    }
  }

  FutureResult<T> execute(P param);
}

abstract class IStreamUseCase<T, P> {
  final StreamController<Result<T>> _streamController =
      StreamController.broadcast();

  ResultStream<T> get stream => _streamController.stream;

  void startStream({required P param}) {
    try {
      execute(param);
    } catch (e) {
      _streamController.add(Result.exception(e));
    }
  }

  void execute(P param);

  void stopStream() => _streamController.close();
}
