class LocalAuthModel {
  String? id;
  String? deviceId;
  String? userId;
  int? isActiveBiometrics;

  LocalAuthModel({
    this.id,
    this.deviceId,
    this.userId,
    this.isActiveBiometrics,
  });

  LocalAuthModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    deviceId = json['deviceId'];
    userId = json['userId'];
    isActiveBiometrics =
        int.tryParse(json['isActiveBiometrics']); // 1 is TRUE 0 is FALSE
  }

  Map<String, Object?> jsonToSave() => {
        LocalAuthQuerieseField.id: id,
        LocalAuthQuerieseField.deviceId: deviceId,
        LocalAuthQuerieseField.userId: userId,
        LocalAuthQuerieseField.isActiveBiometrics: isActiveBiometrics,
      };
}

class LocalAuthQuerieseField {
  static String id = 'id';
  static String deviceId = 'deviceId';
  static String pinCode = 'pinCode';
  static String userId = 'userId';
  static String isActiveBiometrics = 'isActiveBiometrics';
}
