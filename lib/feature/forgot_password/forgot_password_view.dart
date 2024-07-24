import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazy_load_indexed_stack/lazy_load_indexed_stack.dart';
import 'package:myapp/commands/core/app_color.dart';
import 'package:myapp/feature/forgot_password/forgot_password_cubit/forgot_password_cubit.dart';
import 'package:myapp/feature/forgot_password/types/forgot_pw.type.dart';
import 'package:myapp/feature/forgot_password/views/enter_email_view.dart';
import 'package:myapp/feature/forgot_password/views/enter_new_pw_view.dart';
import 'package:myapp/feature/forgot_password/views/verify_otp_view.dart';
import 'package:myapp/shared/widgets/appbar_custom.dart';
import 'package:myapp/shared/widgets/padding.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  late ForgotPasswordCubit _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = context.read();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            appBar: appBarCustom(
              context,
              title: _bloc.forgotPwStep.title,
              leadingType: LeadingType.back,
              action: [const Offstage()],
              leadingPress: () => _bloc.goToPreviousStep(context),
            ),
            backgroundColor: AppColors.secondaryColor,
            body: Padding(
              padding: getScreensPadding(context),
              child: LazyLoadIndexedStack(
                index: _bloc.forgotPwStep.index,
                children: [
                  EnterEmailView(bloc: _bloc),
                  VerifyOtpView(bloc: _bloc),
                  NewPasswordView(bloc: _bloc),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
