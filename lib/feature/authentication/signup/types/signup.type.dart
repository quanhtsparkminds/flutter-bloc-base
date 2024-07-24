import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myapp/gen/assets.gen.dart';
import 'package:myapp/shared/widgets/appbar_custom.dart';

enum SignupStep {
  enterUsername,
  chooseCountry,
  chooseLocation,
  enterInfo,
  verifyOtpPhone,
  signupSuccess,
}

extension ExSignupStep on SignupStep {
  int get index {
    switch (this) {
      case SignupStep.enterUsername:
        return 0;
      case SignupStep.chooseCountry:
        return 1;
      case SignupStep.chooseLocation:
        return 2;
      case SignupStep.enterInfo:
        return 3;
      case SignupStep.verifyOtpPhone:
        return 4;
      case SignupStep.signupSuccess:
        return 5;
    }
  }

  SignupStep? get prevEnum {
    switch (this) {
      case SignupStep.enterUsername:
      case SignupStep.signupSuccess:
        return null;
      case SignupStep.chooseCountry:
        return SignupStep.enterUsername;
      case SignupStep.chooseLocation:
        return SignupStep.chooseCountry;
      case SignupStep.enterInfo:
        return SignupStep.chooseLocation;
      case SignupStep.verifyOtpPhone:
        return SignupStep.enterInfo;
    }
  }

  SignupStep? get nextEnum {
    switch (this) {
      case SignupStep.enterUsername:
        return SignupStep.chooseCountry;
      case SignupStep.chooseCountry:
        return SignupStep.chooseLocation;
      case SignupStep.chooseLocation:
        return SignupStep.enterInfo;
      case SignupStep.enterInfo:
        return SignupStep.verifyOtpPhone;
      case SignupStep.verifyOtpPhone:
        return SignupStep.signupSuccess;
      case SignupStep.signupSuccess:
        return null; // There's no step after signupSuccess
    }
  }

  String get title {
    switch (this) {
      case SignupStep.enterUsername:
      case SignupStep.enterInfo:
        return 'Sign up';
      case SignupStep.chooseCountry:
        return 'Choose a country';
      case SignupStep.chooseLocation:
        return 'Select location';
      case SignupStep.verifyOtpPhone:
        return 'Phone Verification';
      case SignupStep.signupSuccess:
        return '';
    }
  }

  Widget get actionAppBar {
    switch (this) {
      case SignupStep.enterUsername:
      case SignupStep.enterInfo:
      case SignupStep.chooseLocation:
      case SignupStep.verifyOtpPhone:
      case SignupStep.signupSuccess:
        return const Offstage();
      case SignupStep.chooseCountry:
        return SvgPicture.asset(Assets.svg.seachOutline);
    }
  }

  LeadingType get leadingType {
    switch (this) {
      case SignupStep.enterUsername:
      case SignupStep.enterInfo:
      case SignupStep.chooseLocation:
      case SignupStep.verifyOtpPhone:
      case SignupStep.signupSuccess:
        return LeadingType.back;
      case SignupStep.chooseCountry:
        return LeadingType.close;
    }
  }
}
