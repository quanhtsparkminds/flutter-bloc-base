import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get/utils.dart';
import 'package:local_auth/local_auth.dart';
import 'package:myapp/commands/bootstrap_command.dart';
import 'package:myapp/commands/core/app_style.dart';
import 'package:myapp/commands/navigate_to_command.dart';
import 'package:myapp/commands/set_localauth_command.dart';
import 'package:myapp/constants/constants.dart';
import 'package:myapp/go_router/routes.types.dart';
import 'package:myapp/model/network_connection_model.dart';
import 'package:myapp/shared/translations/translation_key.dart';
import 'package:myapp/shared/utils/my_logger.dart';
import 'package:myapp/shared/widgets/app_button/app_button.dart';
import 'package:myapp/shared/widgets/app_button/app_button.types.dart';
import 'package:myapp/shared/widgets/app_sized_box/app_sized_box.dart';
import 'package:myapp/shared/widgets/dialog_custom.dart';
import 'package:myapp/shared/widgets/loader.dart';
import 'package:local_auth/error_codes.dart' as auth_error;
import 'package:permission_handler/permission_handler.dart';
part 'setup_localauth_state.dart';
part 'setup_localauth_cubit.freezed.dart';

enum FormFieldNames { phone, password }

class SetupLocalAuthCubit extends Cubit<SetupLocalAuthState> {
  SetupLocalAuthCubit() : super(const SetupLocalAuthState.initial());
  final LocalAuthentication auth = LocalAuthentication();

  void initState() {}

  startProcess() {
    emit(const SetupLocalAuthState.processing());
  }

  endLoading() {
    emit(const SetupLocalAuthState.endProcess());
  }

  bool _agreeTermAndCondition = false;
  bool get agreeTermAndCondition => _agreeTermAndCondition;
  void toogleTermAndCondition(bool input) =>
      emit(SetupLocalAuthState.enableButton(_agreeTermAndCondition = input));

  Future<void> validateBiometric(BuildContext context) async {
    try {
      MyLogger.d('Debugger ${LocalAuthCommand().biometricNiceName}');
      if (!await ConnectivityState().checkConnection(isShowError: true)) {
        return;
      }
      if (LocalAuthCommand().biometricNiceName != '') {
        bool authenticated = await auth.authenticate(
            localizedReason: 'Please authenticate to login',
            options: const AuthenticationOptions(
                stickyAuth: true, biometricOnly: true));
        if (authenticated) {
          if (!context.mounted) return;
          showLoader(context, asyncFunction: () async {
            await LocalAuthCommand().enableBiometric(context);
            await Future.delayed(Constants.animationDuration);
            NavigateToCommand().run(AppRoutes.home.name);
          });
        } else {}
      } else {
        showMessageDialog(
          BootstrapCommand().mainNavigator!,
          title: TranslationKeys.titleBiometricFailed.tr,
          message: TranslationKeys.contentBiometricFailed.tr,
        );
      }
    } on PlatformException catch (e) {
      MyLogger.d('error code ${e.code}');
      if (e.code == auth_error.notAvailable) {
        return;
      }
      showMessageDialog(BootstrapCommand().mainNavigator!,
          title: TranslationKeys.titleBiometricSetting
              .trParams({'biometric': biometricName}),
          message: TranslationKeys.contentBiometricSetting
              .trParams({'biometric': biometricName}),
          buttons: [
            Expanded(
              child: AppButton(
                  title: TranslationKeys.biometricPopupButton2.tr,
                  style: ButtonStyles.buttonPopupStyle,
                  variant: AppButtonVariant.primaryAmber,
                  onPressed: () async {
                    await showLoader(context, asyncFunction: () async {
                      return Navigator.of(context, rootNavigator: true)
                          .pop(false);
                    });
                  }),
            ),
            AppSizedBox.square10,
            Expanded(
              child: AppButton(
                  title: TranslationKeys.settings.tr,
                  style: ButtonStyles.buttonPopupStyle,
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop(true);
                    openAppSettings();
                    return;
                  }),
            ),
          ]);
    }
  }

  String get biometricName => LocalAuthCommand().biometricNiceName;
  String get biometricIcon => LocalAuthCommand().biometricIcon;
}
