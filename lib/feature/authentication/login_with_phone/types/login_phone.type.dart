enum SigninPhoneSteps {
  enterPhone,
  verifyOtp,
}

extension ExSigninPhoneStep on SigninPhoneSteps {
  int get index {
    switch (this) {
      case SigninPhoneSteps.enterPhone:
        return 0;
      case SigninPhoneSteps.verifyOtp:
        return 1;
    }
  }

  SigninPhoneSteps? get prevEnum {
    switch (this) {
      case SigninPhoneSteps.enterPhone:
        return null;
      case SigninPhoneSteps.verifyOtp:
        return SigninPhoneSteps.enterPhone;
    }
  }

  SigninPhoneSteps? get nextEnum {
    switch (this) {
      case SigninPhoneSteps.enterPhone:
        return SigninPhoneSteps.verifyOtp;
      case SigninPhoneSteps.verifyOtp:
        return null; // There's no step after signupSuccess
    }
  }

  String get title {
    switch (this) {
      case SigninPhoneSteps.enterPhone:
        return 'Sign up';
      case SigninPhoneSteps.verifyOtp:
        return 'Phone Verification';
    }
  }
}
