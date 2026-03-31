import 'dart:async';

import 'package:fpdart/fpdart.dart';

import '../error/failure.dart';

/// [T] is the success data (Entity)
/// [Params] is the input data.
abstract class UseCase<T, Params> {
  FutureOr<Either<Failure, T>> call(Params params);
}

extension type const NoParams._(Null _) {
  NoParams() : this._(null);
}
