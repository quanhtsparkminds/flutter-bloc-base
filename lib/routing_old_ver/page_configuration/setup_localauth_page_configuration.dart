import 'package:flutter/material.dart';
import 'package:myapp/routing_old_ver/app_routes.dart';
import 'package:myapp/routing_old_ver/page_configuration.dart';

class SetupLocalAuthPageConfiguration extends PageConfiguration {
  SetupLocalAuthPageConfiguration()
      : super(
            key: 'setup-local-page',
            path: Paths.SETUP_LOCAL_AUTHENTICATE,
            uiPage: Routes.SETUPLOCALAUTHENTICATION);

  factory SetupLocalAuthPageConfiguration.fromLocation(
      RouteInformation location) {
    final config = SetupLocalAuthPageConfiguration();
    return config;
  }
}
