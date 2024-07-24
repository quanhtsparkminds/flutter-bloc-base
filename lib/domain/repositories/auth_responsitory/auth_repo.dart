import 'package:myapp/domain/api_client/api_config.dart';
import 'package:myapp/domain/api_client/dio_client.dart';
import 'package:myapp/domain/model/auth_model/auth_model.dart';
import 'package:myapp/domain/repositories/auth_responsitory/auth.type.dart';
import 'package:myapp/domain/repositories/auth_responsitory/auth_service.dart';

class AuthRepository extends AuthService {
  @override
  Future<LoginResponse> loginWithEmail(
      {required LoginEmailRequest body}) async {
    final response = await apiUtils.post(
      ApiConfig.loginWithEmail,
      data: body.toJson(),
    );
    final res = LoginResponse(
        data: AuthToken.fromJson(response.data),
        statusCode: response.statusCode);
    return res;
  }

  @override
  Future<LoginResponse> loginWithPhone({required LoginPhoneRequest body}) {
    //
    throw UnimplementedError();
  }

  @override
  Future<void> logout() {
    throw UnimplementedError();
  }
}
