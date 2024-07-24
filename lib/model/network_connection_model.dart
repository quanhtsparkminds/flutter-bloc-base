import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:myapp/commands/bootstrap_command.dart';
import 'package:myapp/event/event_bus.dart';
import 'package:myapp/model/main_app_state.dart';
import 'package:myapp/shared/utils/my_logger.dart';
import 'package:myapp/shared/widgets/dialog_custom.dart';

class ConnectivityState extends AbstractModel {
  bool firstTimeEvent = false;
  final Connectivity _connectivity = Connectivity();

  bool _isConnected = false;

  ConnectivityStatus _connectionStatus = ConnectivityStatus.none;

  ConnectivityStatus get connectionStatus => _connectionStatus;
  Connectivity get connectivity => _connectivity;
  bool get isConnected => _isConnected;

  static final ConnectivityState _connectivityService =
      ConnectivityState._privateConstructor();

  factory ConnectivityState() {
    return _connectivityService;
  }

  ConnectivityState._privateConstructor() {
    checkConnection(isShowError: true).then((value) => {
          _setConnected(value),
        });
    _connectivity.onConnectivityChanged
        .listen((ConnectivityResult result) async {
      _connectivityEvent(result);
    });
  }
  Future<bool> checkConnection({bool isShowError = false}) async {
    ConnectivityResult connectivityStatus =
        await _connectivity.checkConnectivity();
    if (connectivityStatus != ConnectivityResult.none) {
      try {
        final result = await InternetAddress.lookup('example.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          return true;
        } else {
          return false;
        }
      } on SocketException catch (_) {
        if (isShowError) {
          showMessageDialog(
            BootstrapCommand().mainNavigator!,
            title: 'No internet connection avalable',
            message:
                'Your device is not connect to internet, \nplease make sure your connection is working.',
          );
        }
        return false;
      }
    } else {
      if (isShowError) {
        showMessageDialog(
          BootstrapCommand().mainNavigator!,
          title: 'No internet connection avalable',
          message:
              'Your device is not connect to internet, \nplease make sure your connection is working.',
        );
      }
      return false;
    }
  }

  _connectivityEvent(ConnectivityResult result) async {
    if (!firstTimeEvent) {
      notify(() => firstTimeEvent = true);
      return;
    }
    _connectionStatus = _getStatusFromResult(result);
    MyLogger.d('Connectivity status: $_connectionStatus');

    if (result != ConnectivityResult.none) {
      try {
        final result = await InternetAddress.lookup('example.com');

        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          _setConnected(true);
          MyLogger.d('check connect auto');
        } else {
          _setConnected(false);
        }
      } on SocketException catch (_) {
        showMessageDialog(
          BootstrapCommand().mainNavigator!,
          title: 'No internet connection avalable',
          message:
              'Your device is not connect to internet, \nplease make sure your connection is working.',
        );
      }
    } else {
      _setConnected(false);
    }
    eventBus.fire(ConnectivityStatusEvent(_isConnected
        ? ConnectivityStatusType.connected
        : ConnectivityStatusType.disconnected));
  }

  ConnectivityStatus _getStatusFromResult(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.mobile:
        return ConnectivityStatus.mobile;
      case ConnectivityResult.wifi:
        return ConnectivityStatus.wifi;
      case ConnectivityResult.none:
        return ConnectivityStatus.none;
      default:
        return ConnectivityStatus.none;
    }
  }

  Future<bool> getStatusConnected() async {
    bool status = false;
    await checkConnection(isShowError: false).then((value) => status = value);
    _setConnected(status);
    return status;
  }

  void _setConnected(bool connected) {
    notify(() => _isConnected = connected);
  }
}

enum ConnectivityStatus { wifi, mobile, none }
