// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:myapp/routing_old_ver/app_routes.dart';
import 'package:myapp/routing_old_ver/page_configuration/catergory_page_configuration.dart';
import 'package:myapp/routing_old_ver/page_configuration/electrician_page_configuration.dart';
import 'package:myapp/routing_old_ver/page_configuration/forgot_password_page_configuration.dart';
import 'package:myapp/routing_old_ver/page_configuration/local_authentication_page_configuration.dart';
import 'package:myapp/routing_old_ver/page_configuration/login_email_page_configuration.dart';
import 'package:myapp/routing_old_ver/page_configuration/setup_localauth_page_configuration.dart';
import 'package:myapp/routing_old_ver/page_configuration/signup_page_configuration.dart';
import 'package:myapp/routing_old_ver/page_configuration/login_phone_page_configuration.dart';
import 'package:myapp/routing_old_ver/page_configuration/authenticate_page_configuration.dart';
import 'package:myapp/routing_old_ver/page_configuration/bottom_tabbar_page_configuration.dart';
import 'package:myapp/routing_old_ver/page_configuration/introduction_page_configuration.dart';
import 'package:myapp/shared/utils/my_logger.dart';

abstract class PageConfiguration {
  final String key;
  final String path;
  final Routes uiPage;
  final Object? state;
  var history = <PageConfiguration>[];
  get location => path;

  PageConfiguration({
    required this.key,
    required this.path,
    required this.uiPage,
    this.state,
  });

  factory PageConfiguration.fromLocation(RouteInformation location) {
    String locationDecode = Uri.decodeFull(location.location);
    final parsedUri = Uri.parse(locationDecode);
    final pathSegments = parsedUri.pathSegments;
    if (locationDecode.isNotEmpty) {
      return IntroductionPageConfiguration.fromLocation(location);
    }

    final path = pathSegments[0];
    MyLogger.d('path:$path -');
    MyLogger.d(pathSegments);

    switch (path) {
      case Paths.INTRODUCTION:
        return IntroductionPageConfiguration.fromLocation(location);
      case Paths.AUTHENTICATE:
        return AuthenticatePageConfiguration.fromLocation(location);
      case Paths.SIGN_UP:
        return SignUpPageConfiguration.fromLocation(location);
      case Paths.LOGINWITHEMAIL:
        return LoginEmailPageConfiguration.fromLocation(location);
      case Paths.LOGINWITHPHONE:
        return LoginPhonePageConfiguration.fromLocation(location);
      case Paths.FORGOT_PASSWORD:
        return ForgotPasswordPageConfiguration.fromLocation(location);
      case Paths.LOCAL_AUTHENTICATE:
        return LocalAuthenticationPageConfiguration.fromLocation(location);
      case Paths.SETUP_LOCAL_AUTHENTICATE:
        return SetupLocalAuthPageConfiguration.fromLocation(location);
      case Paths.BOTTOM_TABBAR:
        return BottomTabbarPageConfiguration.fromLocation(location);
      case Paths.CATEGORY:
        return CategoryPageConfiguration.fromLocation(location);
      case Paths.ELECTRICIAN:
        return ElectricianPageConfiguration.fromLocation(location);
      default:
        return IntroductionPageConfiguration.fromLocation(location);
    }
  }

  List<PageConfiguration> get pageTree => [this];
  List<Object?> get props => [path, state];
}
