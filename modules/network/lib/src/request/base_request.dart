import 'package:dio/dio.dart';

import 'request_model.dart';

var _header = <String, String>{};
var _token = <String, String>{};
var _userId = <String, String>{};
var _baseUrl = '';
var _refreshToken = '';
var _acceptedLanguage = <String, String>{};

class BaseRequestDefaults {
  BaseRequestDefaults._() {
    // Initialize the token from the constant
  }

  static final _instance = BaseRequestDefaults._();

  static BaseRequestDefaults get instance => _instance;

  void setHeader(Map<String, String> header) => _header = header;

  void setToken(String token, {String? refreshToken}) {
    _token = {'Authorization': 'Bearer $token'};
    if (refreshToken != null) {
      _refreshToken = refreshToken;
    }
  }

  String getToken() {
    return _token['Authorization'] ?? "";
  }

  String getBaseUrl() {
    return _baseUrl;
  }

  void setUserId(String nUserId) {
    _userId = {'userId': nUserId};
  }

  String getRefreshToken() {
    return _refreshToken;
  }

  void setAcceptedLanguage(String languageCode) {
    _acceptedLanguage = {
      'Accept-Language': languageCode == 'en' ? 'en-US' : "ar-EG"
    };
  }

  void removeToken() => _token = {};

  void setBaseUrl(String baseUrl) => _baseUrl = baseUrl;
}

abstract class BaseRequest {
  BaseRequest(this.path, this.method, this.queryParameters, this.requestModel,
      this.data);

  final RequestModel requestModel;
  final String path;
  final String method;
  final Future<dynamic> queryParameters;
  final Future<dynamic> data;
}

mixin Request implements BaseRequest {
  String get baseUrl => _baseUrl;

  String get refreshToken => _refreshToken;

  Map<String, String> get token => _token;

  Map<String, String> get userId => _userId;

  String get url => baseUrl + path;

  CancelToken get cancelToken => requestModel.cancelToken;

  bool get includeAuthorization => true;

  bool get includeLocalization => true;

  bool get multiPart => false;

  bool get isEncoded => false;

  String get lanCode => "langCode";

  Duration? get sendTimeout => const Duration(seconds: 60);

  Duration? get receiveTimeout => const Duration(seconds: 60);

  Duration? get connectTimeout => const Duration(seconds: 60);

  Map<String, String>? get headers {
    final headers = <String, String>{};
    headers.addAll(_header);
    if (token.isNotEmpty && includeAuthorization) headers.addAll(token);
    if (isEncoded) {
      headers["content-Type"] = 'application/x-www-form-urlencoded';
    }
    if (lanCode.isNotEmpty && includeLocalization) {
      headers.addAll({'Accept-Language': lanCode});
    } else if (_acceptedLanguage.isNotEmpty && includeLocalization) {
      headers.addAll(_acceptedLanguage);
    }
    return headers;
  }
}

mixin GetRequest on Request {
  @override
  RequestModel get requestModel => EmptyRequestModel();

  @override
  Future<dynamic> get queryParameters async {
    final map = await requestModel.toMap();
    if (map is Map<String, dynamic>) {
      return map.isEmpty ? null : map;
    }
  }

  @override
  Future<dynamic> get data async => null;

  @override
  String get method => 'GET';
}

mixin PostRequest on Request {
  @override
  Future<Map<String, dynamic>?> get queryParameters async => null;

  @override
  Future<dynamic> get data async {
    final map = await requestModel.toMap();
    if (map is Map<String, dynamic>) {
      if (map.isEmpty) return null;
      return multiPart ? FormData.fromMap(map) : map;
    } else {
      return map;
    }
  }

  @override
  String get method => 'POST';
}

mixin PutRequest on Request {
  @override
  Future<Map<String, dynamic>?> get queryParameters async => null;

  @override
  Future<dynamic> get data async {
    final map = await requestModel.toMap();
    if (map is Map<String, dynamic>) {
      if (map.isEmpty) return null;
      return multiPart ? FormData.fromMap(map) : map;
    } else {
      return map;
    }
  }

  @override
  String get method => 'PUT';
}

mixin DeleteRequest on Request {
  @override
  RequestModel get requestModel => EmptyRequestModel();

  @override
  Future<dynamic> get queryParameters async {
    final map = await requestModel.toMap();
    if (map is Map<String, dynamic>) {
      return map.isEmpty ? null : map;
    }
  }

  @override
  Future<dynamic> get data async {
    final map = await requestModel.toMap();
    if (map is Map<String, dynamic>) {
      return map.isEmpty ? null : map;
    }
  }

  @override
  String get method => 'DELETE';
}
