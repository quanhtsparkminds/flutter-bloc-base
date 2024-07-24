import 'package:go_router/go_router.dart';

import 'base_command.dart';

class NavigateBackCommand extends BaseAppCommand {
  Future<void> run({Object? result}) async {
    mainNavigator?.pop(result);
  }
}
