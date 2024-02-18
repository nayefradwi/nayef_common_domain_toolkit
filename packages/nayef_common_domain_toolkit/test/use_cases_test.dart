import 'package:nayef_common_domain_toolkit/nayef_common_domain_toolkit.dart';
import 'package:test/test.dart';

import 'use_cases.dart';

void main() {
  test("should return double", () {
    final useCase = DoubleUseCase();
    final result = useCase.call(param: 2);
    expect(result.isSuccess, true);
    final data = (result as ResultWithData).data;
    expect(data, 4);
  });

  test("should return done", () async {
    final useCase = FutureUseCase();
    final result = await useCase.call();
    expect(result.isSuccess, true);
    final data = (result as ResultWithData).data;
    expect(data, 'done');
  });

  test("should return error", () async {
    final useCase = FutureThrowsUseCase();
    final result = await useCase.call();
    expect(result.isError, true);
    final err = (result as ResultWithError).error;
    expect(err, isA<UnknownError>());
  });

  test("should return error", () {
    final useCase = ThrowsUseCase();
    final result = useCase.call();
    expect(result.isError, true);
    final err = (result as ResultWithError).error;
    expect(err, isA<UnknownError>());
  });

  test("should return stream", () async {
    final useCase = StreamUseCase();
    final stream = useCase.stream;
    final results = <Result<num>>[];
    stream.listen((result) => results.add(result));
    useCase.startStream();
    await Future.delayed(Duration(seconds: 1));
    expect(results.length, 5);
    expect(results[0].isSuccess, true);
    expect(results[1].isSuccess, true);
    expect(results[2].isSuccess, true);
    expect(results[3].isSuccess, true);
    expect(results[4].isSuccess, true);
    useCase.stopStream();
  });
}
