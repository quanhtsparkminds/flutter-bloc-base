import 'package:myapp/domain/repositories/auth_responsitory/auth.type.dart';

abstract class AuthService {
  Future<LoginResponse> loginWithEmail({required LoginEmailRequest body});
  Future<LoginResponse> loginWithPhone({required LoginPhoneRequest body});
  Future<void> logout();
}
