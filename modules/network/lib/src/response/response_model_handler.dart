import 'package:core/core.dart';
import 'package:core/packages/dartz/dartz.dart';

class DAppRight {
  static Either<Failure, T> handle<T>(ResponseModel<T> response) {
    if (response.statusCode == AppValues.successCode && response.result != null) {
      return Right(response.result ?? null as T);
    } else {
      return Left(ValidationFailure(message: response.message!));
    }
  }
}
