import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:core/core.dart';

class NetworkInterceptors {
  static List<Interceptor> create({
    required Dio dio,
    required Future<bool> Function() refreshToken,
    required Future<Response<dynamic>> Function(RequestOptions) retryRequest,
  }) {
    return [
      InterceptorsWrapper(
        onError: (error, handler) async {
          if (error.response?.statusCode == 401) {
            // if (await refreshToken()) {
            //   return handler.resolve(await retryRequest(error.requestOptions));
            // }
          }
          return handler.next(error);
        },
        onRequest: (options, handler) async {
          final oldToken = options.headers['Authorization'];
          if (oldToken != null && Jwt.isExpired(oldToken)) {
            if (await refreshToken()) {
              return handler.resolve(await retryRequest(options));
            }
          }
          handler.next(options);
        },
      ),
      if (kDebugMode) PrettyDioLogger(requestHeader: true, requestBody: true),
    ];
  }
}
