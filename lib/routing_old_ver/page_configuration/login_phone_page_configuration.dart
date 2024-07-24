import 'package:flutter/material.dart';
import 'package:myapp/routing_old_ver/app_routes.dart';
import 'package:myapp/routing_old_ver/page_configuration.dart';
import 'package:myapp/routing_old_ver/page_configuration/authenticate_page_configuration.dart';

class LoginPhonePageConfiguration extends PageConfiguration {
  LoginPhonePageConfiguration()
      : super(
            key: 'login-phone',
            path: Paths.LOGINWITHPHONE,
            uiPage: Routes.LOGINWITHPHONE);

  factory LoginPhonePageConfiguration.fromLocation(RouteInformation location) {
    final config = LoginPhonePageConfiguration();
    return config;
  }
  @override
  List<PageConfiguration> get pageTree =>
      [AuthenticatePageConfiguration(), this];
}
