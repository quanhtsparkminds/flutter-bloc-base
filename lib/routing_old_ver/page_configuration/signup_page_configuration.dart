import 'package:flutter/material.dart';
import 'package:myapp/routing_old_ver/app_routes.dart';
import 'package:myapp/routing_old_ver/page_configuration.dart';
import 'package:myapp/routing_old_ver/page_configuration/authenticate_page_configuration.dart';

class SignUpPageConfiguration extends PageConfiguration {
  SignUpPageConfiguration()
      : super(key: 'SignUp-page', path: Paths.SIGN_UP, uiPage: Routes.SIGNUP);

  factory SignUpPageConfiguration.fromLocation(RouteInformation location) {
    final config = SignUpPageConfiguration();
    return config;
  }
  @override
  List<PageConfiguration> get pageTree =>
      [AuthenticatePageConfiguration(), this];
}
