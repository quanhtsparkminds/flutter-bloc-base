// ignore_for_file: unused_field

import 'dart:async';

import 'package:flutter/services.dart';
import 'package:myapp/commands/navigate_to_command.dart';
import 'package:myapp/commands/set_localauth_command.dart';
import 'package:myapp/domain/model/auth_model/user_model.dart';
import 'package:myapp/domain/repositories/user_repo.dart';
import 'package:myapp/go_router/routes.types.dart';

import 'package:myapp/shared/utils/easy_notifier.dart';
import 'package:myapp/shared/utils/my_logger.dart';
import 'package:myapp/themes.dart';
import 'package:uni_links/uni_links.dart';

abstract class AbstractModel extends EasyNotifier {}

class MainAppState extends AbstractModel {
  static AppTheme get _defaultTheme => AppTheme();

  late StreamSubscription _unitLinkSub;

  UserRepository userRepository;

  MainAppState({required this.userRepository});

  UserModel? _currentUser;

  UserModel? get currentUser => _currentUser;

  set currentUser(UserModel? currentUser) {
    _currentUser = currentUser;
    if (_currentUser == null) {
      reset();
    }
    notify();
  }

  void reset() async {
    _currentUser = null;
    // notify(() => _currentPage = _defaultPage);
    // notify(() => cubit.clearAndPush(_defaults.last));
  }

  bool _hasSetInitialRoute = false;

  bool get hasSetInitialRoute => _hasSetInitialRoute;

  set hasSetInitialRoute(bool value) =>
      notify(() => _hasSetInitialRoute = value);

  /// Settings
  AppTheme _theme = _defaultTheme;

  AppTheme get theme => _theme;

  set setTheme(AppTheme theme) => notify(() => _theme = theme);

  TextDirection _textDirection = TextDirection.ltr;

  TextDirection get textDirection => _textDirection;

  set textDirection(TextDirection value) =>
      notify(() => _textDirection = value);

  load() async {
    try {
      await LocalAuthCommand().loadBiometric();

      userRepository.authGetMe();
      userRepository.getIsCurrentUser();
      _currentUser = userRepository.currentUser;
      // await guard();
    } catch (e) {
      print('Err, $e');
    }
  }

  Future guard() async {
    try {
      String namePage;
      if (LocalAuthCommand().isAuthenticated) {
        if (LocalAuthCommand().isNotEmptyBiometric) {
          if (LocalAuthCommand().isSetupBiometric) {
            namePage = AppRoutes.localAuthentication.name;
          } else {
            namePage = AppRoutes.setupLocalAuthentication.name;
          }
        } else {
          namePage = AppRoutes.home.name;
        }
      } else {
        namePage = AppRoutes.introduction.name;
      }
      NavigateToCommand().run(namePage);
    } catch (e) {
      MyLogger.d('ERROR GUARD $e');
    }
  }

  Future<String?> initUniLinks() async {
    try {
      final initialLink = await getInitialLink();
      _unitLinkSub = linkStream.listen((String? link) {
        if (link != null) {}
      }, onError: (err) {
        print(err);
      });
      return initialLink;
    } on PlatformException {
      return null;
    }
  }
}
