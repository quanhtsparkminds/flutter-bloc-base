import 'package:myapp/domain/model/auth_model/user_model.dart';
import 'package:myapp/shared/utils/my_logger.dart';

import 'base_command.dart';

class SetCurrentUserCommand extends BaseAppCommand {
  UserModel? getCurrentUser() {
    return mainAppState.currentUser ?? const UserModel();
  }

  Future<void> run(int? userId) async {
    MyLogger.d('userId -- $userId');
  }
}
