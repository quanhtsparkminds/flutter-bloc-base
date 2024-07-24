import 'package:flutter/material.dart';
import 'package:myapp/routing_old_ver/app_routes.dart';
import 'package:myapp/routing_old_ver/page_configuration.dart';

class BottomTabbarPageConfiguration extends PageConfiguration {
  BottomTabbarPageConfiguration()
      : super(
            key: 'bottom-tabbar',
            path: Paths.BOTTOM_TABBAR,
            uiPage: Routes.BOTTOM_TABBAR);

  factory BottomTabbarPageConfiguration.fromLocation(
      RouteInformation location) {
    final config = BottomTabbarPageConfiguration();
    return config;
  }
}
