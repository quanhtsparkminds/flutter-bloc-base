// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:myapp/routing_old_ver/page_configuration.dart';
import 'package:myapp/shared/utils/my_logger.dart';

class AppRouteParser extends RouteInformationParser<PageConfiguration> {
  @override
  Future<PageConfiguration> parseRouteInformation(
      RouteInformation routeInformation) async {
    PageConfiguration link = PageConfiguration.fromLocation(routeInformation);

    MyLogger.d('parseRouteInfo: ${routeInformation.location} ');
    MyLogger.d('Location: ${link.location} ');
    MyLogger.d('object: ${link.state} ');
    return link;
  }

  @override
  RouteInformation restoreRouteInformation(PageConfiguration configuration) {
    String location = configuration.location;
    final state = configuration.state;
    MyLogger.d('restoreRouteInfo: $location -- $state');
    return RouteInformation(location: location, state: state);
  }
}
