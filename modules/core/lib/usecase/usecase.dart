import 'package:dartz/dartz.dart';
import 'package:failures/failures.dart';

abstract class UseCase<T, Params> {
  Future<Either<Failure, T>> call(Params params);
}

abstract class DirectTypeUseCase<T, Params> {
  T call(Params params);
}

abstract class StreamUseCase<T, Params> {
  Stream<Either<Failure, T>> streamCall(Params params);
}
