class ResponseModel<T> {
  T? result;
  String? message;
  int? statusCode;
  String? statusName;
  String? referenceCode;
  List<dynamic>? errors;

  ResponseModel({
    this.result,
    this.message,
    this.statusCode,
    this.statusName,
    this.referenceCode,
    this.errors,
  });

  ResponseModel.fromJson(
      Map<String, dynamic> json,
      T Function(dynamic) fromJsonT,
      ) {
    result = json['result'] != null ? fromJsonT(json['result']) : null;
    message = json['message'];
    statusCode = json['statusCode'];
    statusName = json['statusName'];
    referenceCode = json['referenceCode'];
    if(json['errors'] != null && json['errors'] is List) {
      errors = json['errors'];
    }
  }

  Map<String, dynamic> toJson(Map<String, dynamic> Function(T) toJsonT) {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (result != null) {
      data['result'] = toJsonT(result!);
    }
    data['message'] = message;
    data['statusCode'] = statusCode;
    data['statusName'] = statusName;
    data['referenceCode'] = referenceCode;
    data['errors'] = errors;
    return data;
  }
}
