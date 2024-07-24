class ApiConfig {
  ApiConfig._();

  static const Duration receiveTimeout = Duration(seconds: 30);
  static const Duration connectionTimeout = Duration(seconds: 30);
  static const String loginWithEmail = '/public/auth';
  static const String loginPhone = 'public/auth/otp/phone/verify';
}
