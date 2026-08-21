import 'dart:io';
import 'package:crypto/crypto.dart';
import 'package:dio/io.dart';

class SSLConfig {
  static IOHttpClientAdapter createAdapter(String fingerprint) {
    return IOHttpClientAdapter(
      createHttpClient: () {
        final client = HttpClient(context: SecurityContext(withTrustedRoots: false));
        client.badCertificateCallback = (_, __, ___) => true;
        return client;
      },
      validateCertificate: (certificate, host, port) {
        if (certificate == null) return false;
        final hash = sha256.convert(certificate.der).toString();
        return hash == fingerprint;
      },
    );
  }
}
