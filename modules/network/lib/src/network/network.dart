import 'dart:async';
import 'package:core/core.dart';

abstract class Network {
  Future<R> send<R, ER extends ResponseModel>({
    required Request request,
    required R Function(dynamic map) responseFromMap,
    ER Function(Map<String, dynamic> map)? errorResponseFromMap,
  });

  void setSSLCertificate(String fingerprint);
}