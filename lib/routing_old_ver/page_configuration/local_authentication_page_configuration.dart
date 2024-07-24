import 'package:flutter/material.dart';
import 'package:myapp/routing_old_ver/app_routes.dart';
import 'package:myapp/routing_old_ver/page_configuration.dart';
import 'package:myapp/routing_old_ver/page_configuration/bottom_tabbar_page_configuration.dart';

class LocalAuthenticationPageConfiguration extends PageConfiguration {
  LocalAuthenticationPageConfiguration()
      : super(
            key: 'setup-local-page',
            path: Paths.LOCAL_AUTHENTICATE,
            uiPage: Routes.LOCALAUTHENTICATION);

  factory LocalAuthenticationPageConfiguration.fromLocation(
      RouteInformation location) {
    final config = LocalAuthenticationPageConfiguration();
    return config;
  }
  @override
  List<PageConfiguration> get pageTree =>
      [BottomTabbarPageConfiguration(), this];
}
