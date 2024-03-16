import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'base_exception.dart';

@LazySingleton(as: ErrorHandlerI)
class ErrorHandler implements ErrorHandlerI {
  ErrorHandler();

  @override
  Response<dynamic> handleError(Response<dynamic> response) {
    if (response.statusCode == 200) {
      return response;
    } else if (response.statusCode == 429) {
      throw BaseException(
        messageText: 'Too Many Requests',
        errorCodeStr: 'too_many_requests',
      );
    } else if (response.statusCode == 500) {
      throw BaseException(
        messageText: 'Internal Server Error',
        errorCodeStr: 'internal_server_error',
      );
    } else {
      throw BaseException(
        messageText: '.Oops! Something went wrong.',
        errorCodeStr: '',
      );
    }
  }

  @override
  Future<void> handleDioError(Object? error, StackTrace stackTrace) async {
    throw BaseException(
      messageText: '.Oops! Something went wrong.',
      errorCodeStr: '',
    );
  }
}

abstract class ErrorHandlerI {
  Response<dynamic> handleError(Response<dynamic> response);

  Future<void> handleDioError(Object? error, StackTrace stackTrace);
}
