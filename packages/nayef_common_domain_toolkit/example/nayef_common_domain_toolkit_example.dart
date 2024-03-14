// ignore_for_file: avoid_print

import 'package:nayef_common_domain_toolkit/nayef_common_domain_toolkit.dart';

class AddTwoUseCase with IUseCase<int, int> {
  @override
  Result<int> execute(int param) {
    return Result.success(param + 2);
  }
}

class AddTwoMapper with IMapper<int, int> {
  @override
  int from(int other) {
    return other + 2;
  }
}

class StreamEvenNumbersUseCase with IStreamUseCase<int, void> {
  final mapper = AddTwoMapper();

  // this method is to omit the param from the startStream method
  @override
  void startStream({void param}) => super.startStream(param: null);

  @override
  void processStream(void _) {
    for (var i = 0; i < 10; i++) {
      final mapped = mapper.from(i);
      if (mapped.isEven) {
        emit(Result.success(mapped));
      }
    }
  }
}

class WillReturnIn5SecondsUseCase with IFutureUseCase<int, void> {
  @override
  FutureResult<int> call({void param}) => super.call(param: null);

  @override
  FutureResult<int> execute(void _) async {
    await Future<void>.delayed(const Duration(seconds: 5));
    return Result.success(5);
  }
}

void main() async {
  final useCase = AddTwoUseCase();
  useCase.call(param: 2).fold(
        onSuccess: (data) => print('new result is: $data'),
        onError: (_) {},
      );

  final steamUseCase = StreamEvenNumbersUseCase();
  steamUseCase.stream.listen((result) {
    result.fold(
      onSuccess: (data) => print('stream prints: $data'),
      onError: (_) {},
    );
  });
  steamUseCase.startStream();
  final futureUseCase = WillReturnIn5SecondsUseCase();
  final futureResult = await futureUseCase.call();
  futureResult.fold(
    onSuccess: (data) => print('future result is: $data'),
    onError: (_) {},
  );
}
