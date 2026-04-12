import 'package:dio/dio.dart';

abstract class Failure {
  Failure(this.errorMessage);

  final String errorMessage;
}

class ServerFailure extends Failure {
  ServerFailure(super.errorMessage);

  factory ServerFailure.fromDioException(DioException exception) {
    return switch (exception.type) {
      DioExceptionType.connectionTimeout => ServerFailure(
        'الرجاء التحقق من اتصالك بالإنترنت والمحاولة مرة أخرى',
      ),
      DioExceptionType.sendTimeout => ServerFailure(
        'الرجاء التحقق من اتصالك بالإنترنت والمحاولة مرة أخرى',
      ),
      DioExceptionType.receiveTimeout => ServerFailure(
        'الرجاء التحقق من اتصالك بالإنترنت والمحاولة مرة أخرى',
      ),
      DioExceptionType.badCertificate => ServerFailure(
        'حدث خطأ ما, الرجاء المحاولة مرة أخرى',
      ),
      DioExceptionType.cancel => ServerFailure('قام الخادم بإلغاء الطلب'),
      DioExceptionType.connectionError => ServerFailure(
        'لم يتم العثور على الخادم',
      ),
      DioExceptionType.unknown => ServerFailure(
        'حدث خطأ ما, الرجاء المحاولة مرة أخرى',
      ),
      DioExceptionType.badResponse => ServerFailure.fromResponse(
        exception.response!.statusCode!,
        exception.response,
      ),
    };
  }

  factory ServerFailure.fromResponse(int statusCode, Response? response) {
    if (statusCode == 400 ||
        statusCode == 403 ||
        statusCode == 422 ||
        statusCode == 429) {
      return _handleError(
        response: response,
        defaultMessage: 'حدث خطأ ما, الرجاء المحاولة مرة أخرى',
      );
    }

    if (statusCode == 401) {
      _handleError(
        response: response,
        defaultMessage: 'إنتهت الجلسة, الرجاء تسجيل الدخول مرة أخرى',
      );

      // if (response!.data['session_expired'] == true) {
      //   return ServerFailure(response.data['message']);
      // } else {
      //   return ServerFailure('Session expired, Please login again');
      // }
    }

    if (statusCode == 404) {
      return _handleError(
        response: response,
        defaultMessage: 'لم يتم العثور على طلبك',
      );
    }

    if (statusCode == 500) {
      return _handleError(
        response: response,
        defaultMessage: 'حدث خطأ ما, الرجاء المحاولة مرة أخرى',
      );
    }

    return ServerFailure('حدث خطأ ما, الرجاء المحاولة مرة أخرى');
  }

  static ServerFailure _handleError({
    required Response? response,
    required String defaultMessage,
  }) {
    if (response == null || response.data == null) {
      return ServerFailure(defaultMessage);
    }

    final data = response.data;

    if (data is Map<String, dynamic>) {
      if (data.containsKey('message') && data['message'] != "") {
        return ServerFailure(data['message'].toString());
      }
      if (data.containsKey('error')) {
        return ServerFailure(data['error'].toString());
      }
      if (data.containsKey('errors')) {
        final errors = data['errors'];
        if (errors is Map<String, dynamic>) {
          final firstError = errors.values.first;
          if (firstError is List && firstError.isNotEmpty) {
            return ServerFailure(firstError.first.toString());
          } else if (firstError is String) {
            return ServerFailure(firstError);
          }
        } else if (errors is List && errors.isNotEmpty) {
          return ServerFailure(errors.first.toString());
        }
      }
    }

    return ServerFailure(defaultMessage);
  }
}

class CacheFailure extends Failure {
  CacheFailure(super.errorMessage);

  // factory CacheFailure.fromHiveError(HiveError error) {
  //   return CacheFailure(HiveError(error.toString()).toString());
  // }
}

class AppFailure extends Failure {
  AppFailure(super.errorMessage);
}

class ForceChangePasswordFailure extends Failure {
  ForceChangePasswordFailure(super.errorMessage);
}
