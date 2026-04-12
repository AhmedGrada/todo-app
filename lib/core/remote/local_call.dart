import 'package:dartz/dartz.dart';
import 'package:todo/core/errors/failure.dart';
import 'package:todo/core/utils/typedef.dart';

FutureOf<T> executeLocalCall<T>(Future<T> Function() call) async {
  try {
    final result = await call();
    return right(result);
  } catch (e) {
    return left(CacheFailure(e.toString()));
  }
}
