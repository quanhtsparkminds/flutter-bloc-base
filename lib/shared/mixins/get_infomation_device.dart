import 'package:flutter/cupertino.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:myapp/commands/core/app_key.dart';
import 'package:myapp/shared/helps/spref.dart';

getInfoDevice() async {
  try {
    String? deviceId = await FlutterUdid.udid;
    await SPref.instance.set(AppKey.deviceId, deviceId);
    debugPrint('deviceId______________ ${SPref.instance.get(AppKey.deviceId)}');
  } catch (error) {
    rethrow;
  }
}
