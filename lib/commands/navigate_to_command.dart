import 'package:go_router/go_router.dart';
import 'package:myapp/shared/utils/my_logger.dart';

import 'base_command.dart';

class NavigateToCommand extends BaseAppCommand {
  Future<void> run(String name,
      {Object? extra,
      Map<String, String> pathParameters = const <String, String>{},
      Map<String, dynamic> queryParameters = const <String, dynamic>{}}) async {
    MyLogger.safePrint('NavigateToCommand: $name');
    mainNavigator?.goNamed(name,
        extra: extra,
        pathParameters: pathParameters,
        queryParameters: queryParameters);
  }

  Future<Object?> pushToNamed(
    String name, {
    Object? extra,
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
  }) async {
    MyLogger.safePrint('NavigatePushToCommand: $name');
    return await mainNavigator?.pushNamed(name,
        extra: extra,
        pathParameters: pathParameters,
        queryParameters: queryParameters);
  }
}
