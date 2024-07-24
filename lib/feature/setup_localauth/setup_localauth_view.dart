import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myapp/commands/core/app_color.dart';
import 'package:myapp/commands/core/app_spacing.dart';
import 'package:myapp/feature/setup_localauth/setup_localauth_cubit/setup_localauth_cubit.dart';
import 'package:myapp/shared/widgets/app_body.dart';
import 'package:myapp/shared/widgets/app_button/app_button.dart';
import 'package:myapp/shared/widgets/app_checkbox/app_check_box.dart';
import 'package:myapp/shared/widgets/app_sized_box/app_sized_box.dart';
import 'package:myapp/shared/widgets/app_text/app_text.types.dart';
import 'package:myapp/shared/widgets/app_text/text_custom.dart';
import 'package:myapp/shared/widgets/appbar_custom.dart';
import 'package:myapp/shared/widgets/padding.dart';

class SetupLocalAuthView extends StatefulWidget {
  const SetupLocalAuthView({super.key});

  @override
  State<SetupLocalAuthView> createState() => _SetupLocalAuthViewState();
}

class _SetupLocalAuthViewState extends State<SetupLocalAuthView> {
  late SetupLocalAuthCubit _bloc;
  @override
  void initState() {
    super.initState();
    _bloc = context.read();
  }

  @override
  Widget build(BuildContext context) {
    double sizeImage = 215;
    return BlocBuilder<SetupLocalAuthCubit, SetupLocalAuthState>(
      builder: (context, state) {
        return Scaffold(
          appBar: appBarCustom(
            context,
            title: 'Sign up for Finger',
            leadingType: LeadingType.none,
            action: [const Offstage()],
            leadingPress: () => {},
          ),
          backgroundColor: AppColors.secondaryColor,
          body: Padding(
            padding: getScreensPadding(context),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: BodyWrappedWithChild(
                      child: Column(
                    children: [
                      AppSizedBox.square36,
                      Container(
                        height: sizeImage,
                        width: sizeImage,
                        decoration: BoxDecoration(
                            border: Border.all(color: AppColors.greyStrong),
                            borderRadius:
                                BorderRadius.all(Radius.circular(sizeImage))),
                        padding: const EdgeInsets.all(AppSpacing.x30),
                        child: SvgPicture.asset(
                          _bloc.biometricIcon,
                          // Assets.svg.fingerprint,
                        ),
                      ),
                      AppSizedBox.square10,
                      TextCustom(
                        'Please lift and rest your finger',
                        variant: AppTextVariant.button,
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: AppColors.textDark),
                      ),
                      AppSizedBox.square20,
                      AppButton(
                        title: 'Sign up by ${_bloc.biometricName}',
                        onPressed: _bloc.agreeTermAndCondition
                            ? () => _bloc.validateBiometric(context)
                            : null,
                      ),
                      AppSizedBox.square20,
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.x20),
                        child: CustomAppCheckbox(
                            name: 'checkbox',
                            size: AppSpacing.x18,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: AppSizedBox.square8,
                            suffixWidget: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                TextCustom(
                                  'By Signing up, your agree to our',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.greyStrong),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: AppSpacing.x20),
                                  child: TextCustom(
                                    'Terms and Conditions',
                                    textAlign: TextAlign.center,
                                    variant: AppTextVariant.button,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.primaryColor),
                                  ),
                                ),
                              ],
                            ),
                            onChanged: (p0) =>
                                _bloc.toogleTermAndCondition(p0 ?? false),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction),
                      ),
                      AppSizedBox.square36
                    ],
                  )),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
