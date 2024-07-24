import 'package:flutter_udid/flutter_udid.dart';
import 'package:myapp/model/main_app_state.dart';
import 'package:myapp/shared/helps/storage_hepler.dart';

// * Make sure file is cleared when we logout (ChangeUserCommand)
class MainAuthState extends AbstractModel {
  MainAuthState();

  bool _isAuthenticated = false;
  String _deviceId = '';
  String get deviceId => _deviceId;
  String _userId = '';
  String get userId => _userId;
  String _accessToken = '';
  String get accessToken => _accessToken;

  load() async {
    _deviceId = await FlutterUdid.udid;
    _userId = await SecureStorageHelper().getUserId();
    _accessToken = await SecureStorageHelper().getAccessToken();
    _isAuthenticated = _accessToken.isNotEmpty;
    notify();
  }

  Future<void> getUserId() async {
    _userId = await SecureStorageHelper().getAccessToken();
    notify();
  }

  setAccessToken(String? accessToken) async {
    if (accessToken == null || accessToken.isEmpty) {
      await SecureStorageHelper().removeAccessToken();
    } else {
      await SecureStorageHelper().setAccessToken(accessToken);
    }
    _accessToken = await SecureStorageHelper().getAccessToken();
  }

  setUserId(String? userId) async {
    if (userId == null || userId.isEmpty) {
      await SecureStorageHelper().removeUserId();
    } else {
      await SecureStorageHelper().setUserId(userId);
    }
    _userId = await SecureStorageHelper().getUserId();
  }

  bool get isAuthenticated => _isAuthenticated;
}
