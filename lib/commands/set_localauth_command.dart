import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:local_auth/local_auth.dart';
import 'package:myapp/commands/navigate_to_command.dart';
import 'package:myapp/domain/api_client/dio_client.dart';
import 'package:myapp/go_router/routes.types.dart';
import 'package:myapp/shared/helps/storage_hepler.dart';

import 'base_command.dart';

class LocalAuthCommand extends BaseAppCommand {
  String get deviceId => mainAuthState.deviceId;
  String get userId => mainAuthState.userId;
  bool get isAuthenticated => mainAuthState.isAuthenticated;
  String get accessToken => mainAuthState.accessToken;

  bool get isNotEmptyBiometric => mainLocalAuthState.listBiometric.isNotEmpty;
  bool get isSetupBiometric => mainLocalAuthState.isBiometricEnabled;
  BiometricType get typeBiometric => mainLocalAuthState.biometricType;
  String get biometricNiceName => mainLocalAuthState.biometricNiceName;
  String get biometricIcon => mainLocalAuthState.biometricIcon;

  Future logout() async {
    await SecureStorageHelper().boxSecure.deleteAll();
    await loadAuthData();
    NavigateToCommand().run(AppRoutes.authenticate.name);
  }

  Future syncLogin({String? accessToken, String? userId}) async {
    if (accessToken == null) return;
    await mainAuthState.setAccessToken(accessToken);
    await mainAuthState.setUserId(userId);
    await Future.delayed(2.seconds);
    ApiUtils().setToken(accessToken);
    await loadAuthData();
    await loadBiometric();
  }

  Future loadBiometric() async {
    await mainLocalAuthState.initState();
    await mainAppState.guard();
  }

  Future loadAuthData() async => await mainAuthState.load();

  enableBiometric(BuildContext context) async {
    await mainLocalAuthState.handleSetUpBiometrics(isEnable: true);
  }

  disableBiometric(BuildContext context) async {
    await mainLocalAuthState.handleSetUpBiometrics(isEnable: false);
  }
}
