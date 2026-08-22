import 'dart:io';

import '../error/exceptions.dart';
import '../error/failure.dart';
import '../models/error_message_response.dart';

class FailureHandler {
  final Exception exception;

  FailureHandler(this.exception);

  Failure getExceptionFailure() {
    try {
      switch (exception.runtimeType) {
        case const (SocketException):
          return NoConnectionFailure(
            title: "noConnection",
            message: "noConnectionMessage",
            // imagePath: AppAssets.noNetworkIcon
          );

        case const (ServerException):
          var catchException = exception as ServerException;
          return ServerFailure(
              message: ErrorMessageResponse.fromMap(catchException
                          .response?.data is Map
                      ? catchException.response?.data as Map<String, dynamic>
                      : null)
                  .message);

        case const (CacheException):
          return ServerFailure();
        case const (ParsingException):
          return ParsingFailure();

        case const (BadRequestException):
          return ServerFailure();
        case const (InternalServerException):
          return ServerFailure();
        case const (AuthException):
          return AuthFailure();
        case const (TimeoutException):
          return TimeoutFailure();
        case const (UnExpectedException):
          return ServerFailure(message: "someThingWentWrong");
        case const (FormatException):
          return ParsingFailure();
        case const (ErrorException):
          var catchException = exception as ErrorException;
          var errorMessage =
              catchException.errorResponse as ErrorMessageResponse;
          return ServerFailure(
              message: errorMessage.message, errorsList: errorMessage.errors);
        case const (ConnectionException):
          return NoConnectionFailure(
            message: "noConnectionMessage",
            title: "noConnection",
            // imagePath: AppAssets.noNetworkIcon
          );
        default:
          return ServerFailure();
      }
    } catch (e) {
      return UnhandledFailure(message: "somethingWentWrong");
    }
  }
}
