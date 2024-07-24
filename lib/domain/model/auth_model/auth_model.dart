import 'package:myapp/domain/api_client/api_response.dart';

class AuthToken {
  String? accessToken;
  String? refreshToken;
  String? expiredTime;
  String? email;
  int? userId;
  String? sessionId;
  String? type;
  String? detail;
  String? messageCode;
  FieldErrors? errorFields;

  AuthToken({
    this.accessToken,
    this.refreshToken,
    this.expiredTime,
    this.email,
    this.userId,
    this.sessionId,
    this.type,
    this.detail,
    this.messageCode,
    this.errorFields,
  });

  factory AuthToken.fromJson(Map<String, dynamic> json) {
    return AuthToken(
      accessToken: json['token'],
      refreshToken: json['refreshToken'],
      expiredTime: json['expiredTime'],
      email: json['email'],
      userId: json['userId'],
      sessionId: json['sessionId'],
      type: json['type'],
      detail: json['detail'],
      messageCode: json['messageCode'],
      errorFields: json['errorFields'],
    );
  }
}
