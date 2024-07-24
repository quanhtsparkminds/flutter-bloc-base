import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/utils.dart';
import 'package:myapp/commands/core/app_color.dart';
import 'package:myapp/commands/core/app_spacing.dart';
import 'package:myapp/feature/local_authentication/format_cubit/local_authentication_cubit.dart';
import 'package:myapp/shared/translations/translation_key.dart';
import 'package:myapp/shared/widgets/app_body.dart';
import 'package:myapp/shared/widgets/app_button/app_button.dart';
import 'package:myapp/shared/widgets/app_button/app_button.types.dart';
import 'package:myapp/shared/widgets/app_sized_box/app_sized_box.dart';
import 'package:myapp/shared/widgets/app_text/app_text.types.dart';
import 'package:myapp/shared/widgets/app_text/text_custom.dart';
import 'package:myapp/shared/widgets/appbar_custom.dart';
import 'package:myapp/shared/widgets/padding.dart';

class LocalAuthenticationView extends StatefulWidget {
  const LocalAuthenticationView({super.key});

  @override
  State<LocalAuthenticationView> createState() =>
      _LocalAuthenticationViewState();
}

class _LocalAuthenticationViewState extends State<LocalAuthenticationView> {
  late LocalAuthenticationCubit _bloc;
  @override
  void initState() {
    super.initState();
    _bloc = context.read();
  }

  @override
  Widget build(BuildContext context) {
    double sizeImage = 125;
    return BlocBuilder<LocalAuthenticationCubit, LocalAuthenticationState>(
      builder: (context, state) {
        return Scaffold(
          appBar: appBarCustom(
            context,
            title: 'Sign in for Finger',
            leadingType: LeadingType.back,
            action: [const Offstage()],
            leadingPress: () => _bloc.navigateBottomTabbar(),
          ),
          backgroundColor: AppColors.secondaryColor,
          body: Padding(
            padding: getScreensPadding(context),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppSizedBox.square60,
                  TextCustom(
                    'Welcome Back!',
                    variant: AppTextVariant.title,
                    style: TextStyle(color: AppColors.primaryColor),
                  ),
                  TextCustom(
                    'Sign in to continue',
                    variant: AppTextVariant.text,
                    style: TextStyle(color: AppColors.greyStrong),
                  ),
                  AppSizedBox.square20,
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
                          ),
                        ),
                        AppSizedBox.square20,
                        TextCustom(
                          _bloc.biometricName,
                          variant: AppTextVariant.text,
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: AppColors.titleColor),
                        ),
                        AppSizedBox.square10,
                        TextCustom(
                          'Used ${_bloc.biometricName.toLowerCase()} to unlock',
                          variant: AppTextVariant.button,
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: AppColors.textDark),
                        ),
                        AppSizedBox.square20,
                        Visibility(
                          visible: _bloc.isEnableReTryBiometric,
                          child: Column(
                            children: [
                              AppButton(
                                title: 'Try again',
                                onPressed: () =>
                                    _bloc.validateBiometric(context),
                              ),
                              AppSizedBox.square30,
                            ],
                          ),
                        ),
                        AppButton(
                          title: TranslationKeys.cancel.tr,
                          variant: AppButtonVariant.primaryAmber,
                          onPressed: () => _bloc.navigateBottomTabbar(),
                        ),
                        AppSizedBox.square36,
                      ],
                    )),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
