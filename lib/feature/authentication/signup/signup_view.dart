// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazy_load_indexed_stack/lazy_load_indexed_stack.dart';
import 'package:myapp/commands/core/app_color.dart';
import 'package:myapp/feature/authentication/signup/pages/signup_step_choose_country.dart';
import 'package:myapp/feature/authentication/signup/pages/signup_step_info.dart';
import 'package:myapp/feature/authentication/signup/pages/signup_step_otp.dart';
import 'package:myapp/feature/authentication/signup/pages/signup_step_select_localtion.dart';
import 'package:myapp/feature/authentication/signup/pages/signup_step_success.dart';

import 'package:myapp/feature/authentication/signup/pages/signup_step_username.dart';
import 'package:myapp/feature/authentication/signup/signup_cubit/signup_cubit.dart';
import 'package:myapp/feature/authentication/signup/types/signup.type.dart';
import 'package:myapp/shared/widgets/appbar_custom.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  late SignupCubit _bloc;

  @override
  void initState() {
    _bloc = context.read();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(builder: (context, state) {
      return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: WillPopScope(
          onWillPop: () async {
            if (!_bloc.isFirstStep) {
              Future(() => false);
            }
            return Future(() => true);
          },
          child: Scaffold(
            appBar: appBarCustom(
              context,
              hideBackButton: _bloc.isLastStep,
              hideBackground: _bloc.isLastStep,
              title: _bloc.signupStep.title,
              leadingType: _bloc.signupStep.leadingType,
              action: [_bloc.signupStep.actionAppBar],
              leadingPress: () => _bloc.goToPreviousStep(context),
            ),
            backgroundColor: AppColors.secondaryColor,
            body: LazyLoadIndexedStack(
              index: _bloc.signupStep.index,
              children: [
                SignupUserNameStepView(bloc: _bloc),
                SignupChooseCountryView(bloc: _bloc),
                SignupChooseLocationView(bloc: _bloc),
                SignupInfoView(bloc: _bloc),
                SignupVeiryOtpView(bloc: _bloc),
                const SignupSuccessView()
              ],
            ),
          ),
        ),
      );
    });
  }
}
