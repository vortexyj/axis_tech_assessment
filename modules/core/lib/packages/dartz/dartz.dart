import 'package:dartz/dartz.dart';

export 'package:dartz/dartz.dart';

extension EitherExtension<L, R> on Either<L, R> {
  R? getRight() => fold<R?>((_) => null, (r) => r);
  L? getLeft() => fold<L?>((l) => l, (_) => null);
}
