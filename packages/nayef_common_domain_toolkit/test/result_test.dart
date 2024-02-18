import 'package:test/test.dart';

import 'use_cases.dart';

void main() {
  test("should call on success from fold", () {
    final useCase = DoubleUseCase();
    final result = useCase.call(param: 2);
    String actual = '';
    result.fold(
      onSuccess: (data) => actual = 'success',
      onError: (error) => actual = 'error',
    );
    expect(actual, 'success');
  });

  test("should call on error from fold", () {
    final useCase = ThrowsUseCase();
    final result = useCase.call();
    String actual = '';
    result.fold(
      onSuccess: (data) => actual = 'success',
      onError: (error) => actual = 'error',
    );
    expect(actual, 'error');
  });

  test("should catch exception and call on error from fold", () {
    final useCase = DoubleUseCase();
    final result = useCase.call(param: 2);
    String actual = '';
    result.fold(
      onSuccess: (data) => throw Exception('error'),
      onError: (error) => actual = 'error',
    );
    expect(actual, 'error');
  });
}
