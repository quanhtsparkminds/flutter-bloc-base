import 'package:get/get.dart';

class ApiResponse<T> {
  final T data;
  final int? statusCode;

  ApiResponse({required this.data, this.statusCode});

  bool get isOk => statusCode == 200 || statusCode == 201;
}

class FieldErrors {
  String? field;
  String? messageCode;
  FieldErrors(this.field, this.messageCode);

  FieldErrors.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return;
    }
    messageCode = json['messageCode'];
    field = json['field'];
  }
}

class ApiResponseStatus {
  final String messageCode;
  final String detail;
  final String type;
  final FieldErrors errorFields;

  ApiResponseStatus(
      {required this.messageCode,
      required this.detail,
      required this.type,
      required this.errorFields});

  factory ApiResponseStatus.fromJson(Map<String, dynamic> json) =>
      ApiResponseStatus(
        messageCode: json['messageCode'] ?? '',
        type: json['type'] ?? '',
        detail: json['detail'] ?? '',
        errorFields: json['errorFields'],
      );

  String get translatedError => messageCode.toString().tr;
  String? get fieldsError => errorFields.field;
}
