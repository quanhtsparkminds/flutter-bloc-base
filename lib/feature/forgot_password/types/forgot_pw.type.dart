enum ForgotPasswordSteps { enterEmail, verifyOtp, enterNewPw }

extension ExForgotPasswordSteps on ForgotPasswordSteps {
  int get index {
    switch (this) {
      case ForgotPasswordSteps.enterEmail:
        return 0;
      case ForgotPasswordSteps.verifyOtp:
        return 1;
      case ForgotPasswordSteps.enterNewPw:
        return 2;
    }
  }

  ForgotPasswordSteps? get prevEnum {
    switch (this) {
      case ForgotPasswordSteps.enterEmail:
        return null;
      case ForgotPasswordSteps.verifyOtp:
        return ForgotPasswordSteps.enterEmail;
      case ForgotPasswordSteps.enterNewPw:
        return ForgotPasswordSteps.enterEmail;
    }
  }

  ForgotPasswordSteps? get nextEnum {
    switch (this) {
      case ForgotPasswordSteps.enterEmail:
        return ForgotPasswordSteps.verifyOtp;
      case ForgotPasswordSteps.verifyOtp:
        return ForgotPasswordSteps.enterNewPw;
      case ForgotPasswordSteps.enterNewPw:
        return null;
    }
  }

  String get title {
    switch (this) {
      case ForgotPasswordSteps.enterEmail:
      case ForgotPasswordSteps.verifyOtp:
        return 'Forgot Password';
      case ForgotPasswordSteps.enterNewPw:
        return 'Changed Password';
    }
  }
}
