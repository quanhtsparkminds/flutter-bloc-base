import 'package:flutter/material.dart';
import 'package:myapp/routing_old_ver/app_routes.dart';
import 'package:myapp/routing_old_ver/page_configuration.dart';
import 'package:myapp/routing_old_ver/page_configuration/bottom_tabbar_page_configuration.dart';

class CategoryPageConfiguration extends PageConfiguration {
  // final Categories category;
  CategoryPageConfiguration()
      : super(
          key: 'category-page',
          path: Paths.CATEGORY,
          uiPage: Routes.CATEGORY,
          // state: category,
        );

  factory CategoryPageConfiguration.fromLocation(RouteInformation location) {
    // final category = location.state as Categories;
    final config = CategoryPageConfiguration();
    return config;
  }
  @override
  List<PageConfiguration> get pageTree =>
      [BottomTabbarPageConfiguration(), this];
}
