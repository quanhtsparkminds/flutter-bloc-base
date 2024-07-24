import 'package:myapp/domain/api_client/api_response.dart';
import 'package:myapp/domain/model/auth_model/auth_model.dart';

class LoginEmailRequest {
  String email;
  String password;
  LoginEmailRequest({required this.email, required this.password});

  Map<String, dynamic> toJson() => {'email': email, 'password': password};
}

class LoginPhoneRequest {
  String phone;
  String otp;
  LoginPhoneRequest({required this.phone, required this.otp});

  Map<String, dynamic> toJson() => {'phone': phone, 'otp': otp};
}

class LoginResponse extends ApiResponse<AuthToken> {
  LoginResponse({
    required super.statusCode,
    required super.data,
  });
}
