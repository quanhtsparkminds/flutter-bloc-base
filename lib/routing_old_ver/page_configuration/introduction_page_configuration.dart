import 'package:flutter/material.dart';
import 'package:myapp/routing_old_ver/app_routes.dart';
import 'package:myapp/routing_old_ver/page_configuration.dart';

class IntroductionPageConfiguration extends PageConfiguration {
  IntroductionPageConfiguration()
      : super(
            key: 'introduction-page',
            path: Paths.INTRODUCTION,
            uiPage: Routes.INTRODUCTION);

  factory IntroductionPageConfiguration.fromLocation(
      RouteInformation location) {
    final config = IntroductionPageConfiguration();
    return config;
  }
}
