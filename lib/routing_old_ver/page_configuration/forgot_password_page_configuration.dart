import 'package:flutter/material.dart';
import 'package:myapp/routing_old_ver/app_routes.dart';
import 'package:myapp/routing_old_ver/page_configuration.dart';
import 'package:myapp/routing_old_ver/page_configuration/login_email_page_configuration.dart';

class ForgotPasswordPageConfiguration extends PageConfiguration {
  // String? id;
  ForgotPasswordPageConfiguration()
      : super(
            key: 'forgot-password',
            path: Paths.FORGOT_PASSWORD,
            uiPage: Routes.FORGOTPASSWORD);

  factory ForgotPasswordPageConfiguration.fromLocation(
      RouteInformation location) {
    // final uri = Uri.parse(location);
    // final pathSegments = uri.pathSegments;
    final config = ForgotPasswordPageConfiguration();
    return config;
  }
  @override
  List<PageConfiguration> get pageTree => [LoginEmailPageConfiguration(), this];
}
