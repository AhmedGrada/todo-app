import 'package:dartz/dartz.dart';
import 'package:todo/core/errors/failure.dart';

typedef FutureOf<Type> = Future<Either<Failure, Type>>;

typedef FutureVoid = FutureOf<void>;

typedef Json = Map<String, dynamic>;
