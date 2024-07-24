import 'base_command.dart';

class SetNetworkCommand extends BaseAppCommand {
  Future run(bool isShowPopup) async {
    networkState.checkConnection(isShowError: isShowPopup);
  }

  bool get() {
    return networkState.isConnected;
  }
}
