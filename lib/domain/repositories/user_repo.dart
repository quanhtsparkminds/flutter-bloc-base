// import 'dart:convert';

// import 'package:dio/dio.dart';
import 'package:myapp/commands/set_localauth_command.dart';
import 'package:myapp/domain/model/auth_model/user_model.dart';
import 'package:myapp/domain/repositories/auth_responsitory/auth_repo.dart';
// import 'package:myapp/di.dart';

class UserRepository {
  late AuthRepository authRepo;
  UserModel? _currentUser;
  UserModel? get currentUser => _currentUser;

  Future<dynamic> authGetMe() async {
    try {
      // final result = await getRequest(
      //     apiURL: ApiConfig.profile,
      //     getJsonCallback: (map) {
      //       return ResponseModel.fromJson(map, fromJsonT: UserModel.fromJson);
      //     });
      // _currentUser = result.data;
      return true;
    } catch (e) {
      rethrow;
    }
  }

  bool _isCurrentUser = false;
  bool get isCurrentUser => _isCurrentUser;

  getIsCurrentUser() async {
    if (LocalAuthCommand().accessToken.isNotEmpty) {
      _isCurrentUser = true;
    } else {
      _isCurrentUser = false;
    }
  }
}
