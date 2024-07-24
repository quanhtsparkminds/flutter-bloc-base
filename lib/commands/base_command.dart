import 'package:flutter/material.dart';
import 'package:myapp/go_router/app_go_router.dart';
import 'package:myapp/model/main_app_state.dart';
import 'package:myapp/model/main_auth_state.dart';
import 'package:myapp/model/main_local_auth_state.dart';
import 'package:myapp/model/network_connection_model.dart';
import 'package:myapp/themes.dart';
import 'package:provider/provider.dart';

BuildContext? _mainContext;
BuildContext? get mainContext => _mainContext;

/// Someone needs to call this so our Commands can access models and services. Usually main_view.dart
void setContext(BuildContext c) {
  _mainContext = c;
}

class BaseAppCommand {
  /// Provide quick lookups for the main Models and Services in the App.
  T getProvided<T>() {
    assert(mainContext != null,
        'You must call AbstractCommand.init(BuildContext) method before calling Commands.');
    return mainContext!.read<T>();
  }

  BuildContext? get mainNavigator =>
      AppRouter.router.routerDelegate.navigatorKey.currentContext;
  AppTheme get appTheme => getProvided();
  MainAppState get mainAppState => getProvided();
  MainAuthState get mainAuthState => getProvided();
  ConnectivityState get networkState => getProvided();
  MainLocalAuthState get mainLocalAuthState => getProvided();
}
