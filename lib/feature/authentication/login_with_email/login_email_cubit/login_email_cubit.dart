import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get/get.dart';
import 'package:myapp/commands/navigate_to_command.dart';
import 'package:myapp/commands/set_localauth_command.dart';
import 'package:myapp/domain/repositories/auth_responsitory/auth.type.dart';
import 'package:myapp/domain/repositories/auth_responsitory/auth_repo.dart';
import 'package:myapp/domain/repositories/user_repo.dart';
import 'package:myapp/go_router/routes.types.dart';
import 'package:myapp/model/main_auth_state.dart';
import 'package:myapp/shared/helps/length.dart';
import 'package:myapp/shared/utils/app_regex.dart';
import 'package:myapp/shared/utils/format.dart';
import 'package:myapp/shared/utils/my_logger.dart';
import 'package:myapp/shared/widgets/dialog_custom.dart';
import 'package:myapp/shared/widgets/loader.dart';

part 'login_email_state.dart';
part 'login_email_cubit.freezed.dart';

enum FormFieldNames { email, password }

class LoginEmailCubit extends Cubit<LoginWithEmailState> {
  LoginEmailCubit() : super(const LoginWithEmailState.initial());
  late MainAuthState mainAuthState;

  final TextEditingController _emailController = TextEditingController();
  TextEditingController get emailController => _emailController;

  final TextEditingController _passwordController = TextEditingController();
  TextEditingController get passwordController => _passwordController;
  final AuthRepository authRepo = AuthRepository();
  final UserRepository memberGetMe = UserRepository();

  final GlobalKey<FormBuilderState> formKeyLogin =
      GlobalKey<FormBuilderState>();

  final Map<FormFieldNames, String> formFieldNames = {
    FormFieldNames.email: 'email',
    FormFieldNames.password: 'password',
  };
  late Map<FormFieldNames, GlobalKey<FormBuilderFieldState>> formFieldKeys =
      formFieldNames.map(
    (key, value) => MapEntry(key, GlobalKey<FormBuilderFieldState>()),
  );

  bool _isRememberme = false;
  bool get sRememberme => _isRememberme;

  onSelectCheckBox(bool output) {
    _isRememberme = output;
  }

  Future<void> loginWithEmail(BuildContext ctx) async {
    try {
      await showLoader(ctx, asyncFunction: () async {
        await Future.delayed(Durations.extralong1);
        startProcess();
        final String email = emailController.text;
        final String password = passwordController.text;
        final body = LoginEmailRequest(email: email, password: password);
        final response = await authRepo.loginWithEmail(body: body);
        if (response.isOk) {
          await LocalAuthCommand().syncLogin(
              accessToken: response.data.accessToken,
              userId: response.data.userId.toString());
        } else {
          if (!ctx.mounted) return;
          showMessageDialog(ctx,
              title: 'Login Failed',
              message: response.data.messageCode.toString().tr);
        }
      });
    } catch (e) {
      MyLogger.d('error $e');
    }
  }

  void initState(BuildContext context) {
    mainAuthState = context.read<MainAuthState>();
  }

  bool _isValidUsername = false;
  bool get isValidUsername => _isValidUsername;
  onFullFiledUsername(String? value) {
    _isValidUsername = false;
    if (value == null || value.isEmpty) return;
    _isValidUsername = AppRegex.emailRegex.hasMatch(emailController.text) &&
        isMaxLength(emailController.text, TlLengthFiled.maxLength100);
    emit(LoginWithEmailState.enableButton(_isValidUsername));
  }

  bool _isValidPassword = false;
  bool get isValidPassword => _isValidPassword;
  onFullFiledPassword(String? value) {
    _isValidPassword = false;
    if (value == null || value.isEmpty) return;
    _isValidPassword = AppRegex.password.hasMatch(passwordController.text);
    emit(LoginWithEmailState.enableButton(_isValidPassword));
  }

  bool get enableSigninButton => _isValidPassword && _isValidUsername;

  handleForgotPassword() {
    // NavigateToCommand().run(ForgotPasswordPageConfiguration());
    NavigateToCommand().run(AppRoutes.forgotPassword.name);
  }

  startProcess() {
    emit(const LoginWithEmailState.processing());
  }

  endLoading() {
    emit(const LoginWithEmailState.endProcess());
  }
}
