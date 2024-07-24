// ignore_for_file: constant_identifier_names, unreachable_switch_case

enum Routes {
  SPASH,
  LAUNCH,
  INTRODUCTION,
  AUTHENTICATE,
  LOGINWITHPHONE,
  LOGINWITHEMAIL,
  FORGOTPASSWORD,
  SIGNUP,
  BOTTOM_TABBAR,
  SETUPLOCALAUTHENTICATION,
  LOCALAUTHENTICATION,
  CATEGORY,
  ELECTRICIAN,
}

abstract class Paths {
  Paths._();
  static const SPLASH = '/splash-page';
  static const INTRODUCTION = '/introduce-page';
  static const LAUNCH = '/launch';
  static const LOGINWITHEMAIL = '/login-with-email';
  static const LOGINWITHPHONE = '/login-with-phone';
  static const AUTHENTICATE = '/authenticate';
  static const SIGN_UP = '/sign-up';
  static const FORGOT_PASSWORD = '/forgot-password';
  static const LOCAL_AUTHENTICATE = '/local-authenticate';
  static const BOTTOM_TABBAR = '/bottom-tabbar';
  static const SETUP_LOCAL_AUTHENTICATE = '/setup-local-authenticate';
  static const CATEGORY = '/catergory';
  static const ELECTRICIAN = '/electrician';
}
