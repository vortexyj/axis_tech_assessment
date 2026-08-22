import 'package:core/core.dart';
import 'package:dio/dio.dart';

class DioErrorHandler {
  final StatusChecker _statusChecker = StatusChecker();

  Exception handle(DioException error,
      {Function(Map<String, dynamic>)? errorResponseFromMap}) {
    if (error.type == DioExceptionType.badResponse) {
      final statusCode = error.response?.statusCode;
      if (statusCode != null && _statusChecker(statusCode) == HTTPCodes.error) {
        if (statusCode == 401 || statusCode == 403) {
          return const Exceptions.authException();
        }
        return Exceptions.errorException(
          statusCode,
          errorResponseFromMap != null
              ? errorResponseFromMap(
                  error.response?.data as Map<String, dynamic>)
              : ErrorMessageResponse.fromMap(
                  error.response?.data is Map<String, dynamic>
                      ? error.response?.data as Map<String, dynamic>
                      : null),
        );
      }
      return Exceptions.serverException(error.response!);
    }

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const TimeoutException();
      case DioExceptionType.connectionError:
      case DioExceptionType.badCertificate:
        return const ConnectionException();
      case DioExceptionType.cancel:
        return const RequestCanceledException();
      case DioExceptionType.unknown:
        if ((error.message ?? "").contains('SocketException')) {
          return const ConnectionException();
        }
        return const TimeoutException();
      default:
        return const TimeoutException();
    }
  }
}
