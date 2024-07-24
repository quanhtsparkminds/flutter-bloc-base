// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:myapp/shared/utils/my_logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:xdg_directories/xdg_directories.dart' as xdg_directories;

class PathUtil {
  static Future<String> get dataPath async {
    String result = '';
    if (Platform.isLinux) {
      result = '${xdg_directories.dataHome.path}/coreflutter';
    } else {
      try {
        return (await getApplicationSupportDirectory()).path;
      } catch (e) {
        MyLogger.d('$e');
      }
    }
    return result;
  }

  static Future<String> get homePath async {
    return '~/';
  }
}
