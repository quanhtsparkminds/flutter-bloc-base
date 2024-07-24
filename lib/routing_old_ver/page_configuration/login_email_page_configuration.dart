import 'package:flutter/material.dart';
import 'package:myapp/routing_old_ver/app_routes.dart';
import 'package:myapp/routing_old_ver/page_configuration.dart';
import 'package:myapp/routing_old_ver/page_configuration/authenticate_page_configuration.dart';

class LoginEmailPageConfiguration extends PageConfiguration {
  // String? id;
  LoginEmailPageConfiguration()
      : super(
            key: 'login-email',
            path: Paths.LOGINWITHEMAIL,
            uiPage: Routes.LOGINWITHEMAIL);

  factory LoginEmailPageConfiguration.fromLocation(RouteInformation location) {
    // final uri = Uri.parse(location);
    // final pathSegments = uri.pathSegments;
    final config = LoginEmailPageConfiguration();
    return config;
  }
  @override
  List<PageConfiguration> get pageTree =>
      [AuthenticatePageConfiguration(), this];
}
