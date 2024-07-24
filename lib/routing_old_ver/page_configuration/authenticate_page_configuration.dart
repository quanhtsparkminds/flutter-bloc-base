import 'package:flutter/material.dart';
import 'package:myapp/routing_old_ver/app_routes.dart';
import 'package:myapp/routing_old_ver/page_configuration.dart';

class AuthenticatePageConfiguration extends PageConfiguration {
  AuthenticatePageConfiguration()
      : super(
            key: 'authenticate-page',
            path: Paths.AUTHENTICATE,
            uiPage: Routes.AUTHENTICATE);

  factory AuthenticatePageConfiguration.fromLocation(
      RouteInformation location) {
    final config = AuthenticatePageConfiguration();
    return config;
  }
  @override
  List<PageConfiguration> get pageTree =>
      [AuthenticatePageConfiguration(), this];
}
