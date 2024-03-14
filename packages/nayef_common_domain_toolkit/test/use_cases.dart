import 'package:nayef_common_domain_toolkit/nayef_common_domain_toolkit.dart';

class DoubleUseCase with IUseCase<num, num> {
  @override
  Result<num> execute(num param) => Result.success(param * 2);
}

class FutureUseCase with IFutureUseCase<String, void> {
  @override
  FutureResult<String> call({void param}) => super.call(param: null);

  @override
  FutureResult<String> execute(void param) async {
    await Future<void>.delayed(const Duration(seconds: 1));
    return Result.success('done');
  }
}

class FutureThrowsUseCase with IFutureUseCase<void, void> {
  @override
  FutureResult<void> call({void param}) => super.call(param: null);

  @override
  FutureResult<void> execute(void param) async {
    await Future<void>.delayed(const Duration(seconds: 1));
    throw Exception('error');
  }
}

class ThrowsUseCase with IUseCase<void, void> {
  @override
  Result<void> call({void param}) => super.call(param: null);

  @override
  Result<void> execute(void param) => throw Exception('error');
}

class StreamUseCase with IStreamUseCase<num, void> {
  @override
  void startStream({void param}) => super.startStream(param: null);

  @override
  void processStream(void param) {
    emit(Result.success(1));
    emit(Result.success(2));
    emit(Result.success(3));
    emit(Result.success(4));
    emit(Result.success(5));
  }
}
