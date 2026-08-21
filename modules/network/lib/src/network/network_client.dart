import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:core/core.dart';
import 'error_handler.dart';
import 'interceptors.dart';
import 'ssl_config.dart';

class NetworkUtilImpl implements Network {
  // final LocalStorage localStorage;
  final Dio _dio = Dio();
  final DioErrorHandler _errorHandler = DioErrorHandler();

  NetworkUtilImpl() {
    _dio.interceptors.addAll(NetworkInterceptors.create(
      dio: _dio,
      refreshToken: _refreshToken,
      retryRequest: _retry,
    ));
  }

  @override
  void setSSLCertificate(String fingerprint) {
    if (fingerprint.isNotEmpty) {
      _dio.httpClientAdapter = SSLConfig.createAdapter(fingerprint);
    }
  }

  Future<Response<dynamic>> _retry(RequestOptions options) async {
    final retryOptions = Options(
      method: options.method,
      headers: {
        ...options.headers,
        'Authorization': BaseRequestDefaults.instance.getToken()
      },
    );

    return _dio.request(
      options.path,
      data: options.data,
      queryParameters: options.queryParameters,
      options: retryOptions,
    );
  }

  Future<bool> _refreshToken() async {
    try {
      final response = await _dio.post(
          '${BaseRequestDefaults.instance.getBaseUrl()}api/DynamicApp/v1/Authentication/RefreshToken',
          options: Options(
            headers: {
              'x-api-key': 'bosch@1234',
            },
          ),
          data: {
            "data": {
              "AccessToken": AppDataHolder.instance.token,
              "RefreshToken": BaseRequestDefaults.instance.getRefreshToken()
            },
          });

      if (response.statusCode == 200) {
        final token = response.data["result"]["accessToken"];
        final newRefresh = response.data["result"]["refreshToken"];
        BaseRequestDefaults.instance.setToken(token, refreshToken: newRefresh);
        // await localStorage.setValue(
        //     value: StringType(newRefresh),
        //     key: StorageKeys.refreshToken,
        //     isSecureStorage: true);
        // await localStorage.setValue(
        //     value: StringType(token),
        //     key: StorageKeys.token,
        //     isSecureStorage: true);
        return true;
      }
      return false;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<R> send<R, ER extends ResponseModel>({
    required Request request,
    required R Function(dynamic map) responseFromMap,
    ER Function(Map<String, dynamic> map)? errorResponseFromMap,
  }) async {
    try {
      _dio.options = BaseOptions(connectTimeout: request.connectTimeout);
      final response = await _dio.request(
        request.url,
        data: await request.data,
        queryParameters: await request.queryParameters,
        cancelToken: request.cancelToken,
        onSendProgress: request.requestModel.progressListener?.onSendProgress,
        onReceiveProgress:
            request.requestModel.progressListener?.onReceiveProgress,
        options: Options(
          headers: request.headers,
          method: request.method,
          sendTimeout: request.sendTimeout,
          receiveTimeout: request.receiveTimeout,
        ),
      );
      return responseFromMap(response.data!);
    } on DioException catch (error) {
      throw _errorHandler.handle(error,
          errorResponseFromMap: errorResponseFromMap);
    } catch (e) {
      throw const ParsingException();
    }
  }
}
