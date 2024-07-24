// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:myapp/routing_old_ver/app_routes.dart';
import 'package:myapp/routing_old_ver/page_configuration.dart';
import 'package:myapp/routing_old_ver/page_configuration/bottom_tabbar_page_configuration.dart';

class ElectricianPageConfiguration extends PageConfiguration {
  final bool isRootPage;
  ElectricianPageConfiguration({this.isRootPage = true})
      : super(
          key: 'clectrician-page',
          path: Paths.ELECTRICIAN,
          uiPage: Routes.ELECTRICIAN,
          state: isRootPage,
        );

  factory ElectricianPageConfiguration.fromLocation(RouteInformation location) {
    final isRootPage = location.state as bool;
    final config = ElectricianPageConfiguration(isRootPage: isRootPage);
    return config;
  }
  @override
  List<PageConfiguration> get pageTree =>
      [BottomTabbarPageConfiguration(), this];
}
