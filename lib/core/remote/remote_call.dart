import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:todo/core/errors/failure.dart';
import 'package:todo/core/utils/typedef.dart';

FutureOf<T> executeRemoteCall<T>(Future<T> Function() call) async {
  try {
    final result = await call();
    return Right(result);
  } catch (e) {
    if (e is DioException) {
      return Left(ServerFailure.fromDioException(e));
    }
    return Left(ServerFailure(e.toString()));
  }
}
