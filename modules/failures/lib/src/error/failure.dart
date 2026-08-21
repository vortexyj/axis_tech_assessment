import 'package:core/core.dart';
import 'package:core/packages/easy_localization/easy_localization.dart';

abstract class Failure {
  final String? message;
  final String? title;
  final String? code;
  final String? imagePath;
  final List<String>? errorsList;

  Failure({
    this.message = 'somethingWentWrong',
    this.code = "1",
    this.errorsList,
    this.title,
    this.imagePath,
  });

  Map<String, dynamic> toMap() => {"message": message};
}

abstract class ConnectionFailure extends Failure {
  ConnectionFailure({
    String? message,
    String? code,
    List<String>? errorsList,
    String? title,
    String? imagePath,
  }) : super(
            message: message,
            code: code,
            errorsList: errorsList,
            title: title,
            imagePath: imagePath);
}

//General Failures

class ServerFailure extends ConnectionFailure {
  ServerFailure({
    String? message,
    String? code,
    List<String>? errorsList,
  }) : super(
          message: message,
          code: "1001",
        );
}

class AuthFailure extends ConnectionFailure {
  AuthFailure({
    String? message,
  }) : super(message: AppValues.unAuth);
}

class ParsingFailure extends Failure {
  ParsingFailure() : super(message: "parsing_failure".tr());
}

class CacheFailure extends Failure {
  CacheFailure() : super(message: "Caching failure".tr());
}

class NoConnectionFailure extends ConnectionFailure {
  NoConnectionFailure({
    String? message,
    String? title,
    String? imagePath,
  }) : super(message: message, title: title, imagePath: imagePath);
}

class TimeoutFailure extends ConnectionFailure {
  TimeoutFailure() : super(message: "timeout_failure".tr());
}

class ValidationFailure extends Failure {
  ValidationFailure({
    String? message,
  }) : super(message: message);
}

class PermissionFailure extends Failure {
  PermissionFailure({
    String? message,
  }) : super(message: message);
}

class SessionEndedFailure extends ConnectionFailure {
  SessionEndedFailure({
    String? message,
  }) : super(message: message);
}

class UnhandledFailure extends Failure {
  UnhandledFailure({
    String? message,
  }) : super(message: message);
}

class SecurityFailure extends Failure {
  SecurityFailure() : super(message: "threat_found".tr());
}

class BiometricTestFailure extends Failure {
  BiometricTestFailure({
    String? message,
  }) : super(message: "biometric_test_failed".tr());
}
