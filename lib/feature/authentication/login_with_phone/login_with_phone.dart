import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazy_load_indexed_stack/lazy_load_indexed_stack.dart';
import 'package:myapp/commands/core/app_color.dart';
import 'package:myapp/feature/authentication/login_with_phone/login_phone_cubit/login_phone_cubit.dart';
import 'package:myapp/feature/authentication/login_with_phone/types/login_phone.type.dart';
import 'package:myapp/feature/authentication/login_with_phone/views/enter_phone.view.dart';
import 'package:myapp/feature/authentication/login_with_phone/views/verify_phone.view.dart';
import 'package:myapp/shared/widgets/appbar_custom.dart';
import 'package:myapp/shared/widgets/padding.dart';

class LoginWithPhoneView extends StatefulWidget {
  const LoginWithPhoneView({super.key});

  @override
  State<LoginWithPhoneView> createState() => _LoginWithPhoneViewState();
}

class _LoginWithPhoneViewState extends State<LoginWithPhoneView> {
  late LoginPhoneCubit _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = context.read();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginPhoneCubit, LoginWithPhoneState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            appBar: appBarCustom(
              context,
              title: _bloc.signinSteps.title,
              leadingType: LeadingType.back,
              action: [const Offstage()],
              leadingPress: () => _bloc.goToPreviousStep(context),
            ),
            backgroundColor: AppColors.secondaryColor,
            body: Padding(
              padding: getScreensPadding(context),
              child: LazyLoadIndexedStack(
                index: _bloc.signinSteps.index,
                children: [
                  EnterPhoneView(bloc: _bloc),
                  VerifyPhoneView(bloc: _bloc),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
