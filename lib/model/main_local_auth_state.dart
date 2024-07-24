import 'dart:io';

import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:myapp/commands/set_localauth_command.dart';
import 'package:myapp/domain/api_client/api_response.dart';
import 'package:myapp/domain/localstorage/queires/auth_queries.dart';
import 'package:myapp/domain/model/auth_model/local_auth_model.dart';
import 'package:myapp/gen/assets.gen.dart';
import 'package:myapp/model/main_app_state.dart';
import 'package:myapp/shared/utils/my_logger.dart';

class MainLocalAuthState extends AbstractModel {
  LocalAuthentication localAuth = LocalAuthentication();

  // LOCAL IS VERIFY BIOMETRIC LOCAL BY DEVICES
  bool _isBiometricEnabled = false;
  List<BiometricType> _biometricTypes = <BiometricType>[];

  bool get isBiometricEnabled => _isBiometricEnabled;
  bool get isDeviceSupportBiometric => _biometricTypes.isNotEmpty;
  List<BiometricType> get listBiometric => _biometricTypes;

  String get biometricNiceName {
    if (Platform.isAndroid) {
      if (_biometricTypes.contains(BiometricType.fingerprint) ||
          _biometricTypes.contains(BiometricType.strong)) {
        return 'Finger Print';
      }
    } else if (Platform.isIOS) {
      if (_biometricTypes.contains(BiometricType.face)) {
        return 'Face ID';
      } else if (_biometricTypes.contains(BiometricType.fingerprint)) {
        return 'Finger Print';
      }
    }
    return '';
  }

  BiometricType get biometricType {
    if (Platform.isAndroid) {
      if (_biometricTypes.contains(BiometricType.fingerprint) ||
          _biometricTypes.contains(BiometricType.strong)) {
        return BiometricType.fingerprint;
      }
    } else if (Platform.isIOS) {
      if (_biometricTypes.contains(BiometricType.face)) {
        return BiometricType.face;
      } else if (_biometricTypes.contains(BiometricType.fingerprint)) {
        return BiometricType.fingerprint;
      }
    }
    return BiometricType.weak;
  }

  String get biometricIcon {
    if (_biometricTypes.contains(BiometricType.face)) {
      return Assets.svg.faceId;
    } else if (_biometricTypes.contains(BiometricType.fingerprint)) {
      return Assets.svg.fingerprint;
    }
    return '';
  }

  Future<void> getBiometricConfiguration() async {
    late List<BiometricType> availableBiometrics;
    try {
      availableBiometrics = await localAuth.getAvailableBiometrics();
      _biometricTypes = availableBiometrics;
      MyLogger.d('biometric -- $_biometricTypes');
    } on PlatformException catch (e) {
      _biometricTypes = <BiometricType>[];
      MyLogger.d(e);
    }
    notify(() => _biometricTypes = availableBiometrics);
  }

  Future<void> initState() async {
    await getBiometricConfiguration();
    if (LocalAuthCommand().isAuthenticated) {
      await checkExistBiometricByDevice();
    }
  }

  Future<void> handleSetUpBiometrics({required bool isEnable}) async {
    if (!LocalAuthCommand().isAuthenticated) {
      return;
    }
    ApiResponse response =
        await LocalAuthByDevicesQueries.updateRowByDeviceIdAndUserId(
            deviceId: LocalAuthCommand().deviceId,
            userId: LocalAuthCommand().userId,
            enableBiometric: isEnable);
    if (response.isOk) {
      notify(() => _isBiometricEnabled = isEnable);
    }
    return;
  }

  Future<void> checkExistBiometricByDevice() async {
    List<LocalAuthModel> biometricExistCheck = [];
    _isBiometricEnabled = false;
    if (!LocalAuthCommand().isAuthenticated) {
      return;
    }
    try {
      List<LocalAuthModel> biometricExist =
          await LocalAuthByDevicesQueries.readAll();
      if (LocalAuthCommand().userId.isNotEmpty) {
        biometricExistCheck = biometricExist
            .where((element) =>
                element.deviceId == LocalAuthCommand().deviceId &&
                element.userId == LocalAuthCommand().userId)
            .toList();

        print('object -- ${biometricExistCheck.first.isActiveBiometrics}');
        if (biometricExistCheck.isNotEmpty && _biometricTypes.isNotEmpty) {
          notify(() => _isBiometricEnabled =
              biometricExistCheck.first.isActiveBiometrics == 1 ? true : false);
          return;
        }
      } else {
        // handle if check any stuff
      }
      MyLogger.d('check set up biometric');
    } catch (e) {
      MyLogger.d('check set up pin code error -- $e');
    }
  }
}
