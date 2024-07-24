import 'package:myapp/domain/api_client/api_response.dart';
import 'package:myapp/domain/localstorage/database.dart';
import 'package:myapp/domain/model/auth_model/local_auth_model.dart';
import 'package:myapp/shared/utils/my_logger.dart';
import 'package:sqflite/sqflite.dart';

class LocalAuthByDevicesQueries {
  static const String table = 'local_authen_table';

  static Future<LocalAuthModel> readOne(String id) async {
    final Database db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> maps = await db.query(table,
        where: '${LocalAuthQuerieseField.id} = ?', whereArgs: [id]);

    if (maps.isNotEmpty) {
      return LocalAuthModel.fromJson(maps[0]);
    } else {
      throw Exception('No record user with ID: $id in system');
    }
  }

  static Future<List<LocalAuthModel>> readAll() async {
    final Database db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> maps = await db.query(table);

    return List.generate(maps.length, (index) {
      return LocalAuthModel.fromJson(maps[index]);
    });
  }

  static Future<ApiResponse> updateRowByDeviceIdAndUserId({
    required String deviceId,
    required String userId,
    bool enableBiometric = false,
  }) async {
    final Database db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> existingRecords = await db.query(
      table,
      where: 'userId = ? AND deviceId = ?',
      whereArgs: [userId, deviceId],
    );
    int rowChange = 0;

    if (existingRecords.isNotEmpty) {
      rowChange = await db.rawUpdate(
        'UPDATE $table SET ${LocalAuthQuerieseField.isActiveBiometrics} = ? '
        'WHERE ${LocalAuthQuerieseField.deviceId} = ? AND ${LocalAuthQuerieseField.userId} = ?',
        [enableBiometric ? 1 : 0, deviceId, userId],
      );
      // return rowChange;
      if (rowChange != 0) {
        return ApiResponse(
            statusCode: 200,
            data: ResponseModel(
                responseCode: 'biometric.create.success',
                responseMessage: 'Biometric create success'));
      }
    }
    try {
      // Insert data if the combination does not exist
      rowChange = await db.insert(
        table,
        LocalAuthModel(
                deviceId: deviceId,
                id: userId,
                userId: userId,
                isActiveBiometrics: enableBiometric ? 1 : 0)
            .jsonToSave(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (exception) {
      MyLogger.d('error insert row data pincode -- $exception');
    }

    MyLogger.d('-- row change insert data pincode-- $rowChange');
    // return rowChange;
    if (rowChange != 0) {
      return ApiResponse(
          statusCode: 200,
          data: ResponseModel(
              responseCode: 'biometric.create.success',
              responseMessage: 'Biometric create success'));
    }
    return ApiResponse(
        statusCode: 401,
        data: ResponseModel(
            responseCode: 'biometric.create.falied',
            responseMessage: 'Biometric create failed'));
  }
}

class ResponseModel<T> {
  T? data;
  String? responseMessage;
  String? responseCode;

  ResponseModel({this.responseMessage, this.responseCode, this.data});

  ResponseModel.fromJson(Map<String, dynamic> json,
      {T Function(Map<String, dynamic>)? fromJsonT}) {
    data = json['result'] != null ? fromJsonT!(json['result']) : null;
    responseCode = json['responseCode'];
    responseMessage = json['responseMessage'];
  }
}
