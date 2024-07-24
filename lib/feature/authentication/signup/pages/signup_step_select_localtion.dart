import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:myapp/commands/core/app_color.dart';
import 'package:myapp/commands/core/app_spacing.dart';
import 'package:myapp/feature/authentication/signup/signup_cubit/signup_cubit.dart';
import 'package:myapp/shared/translations/translation_key.dart';
import 'package:myapp/shared/widgets/app_body.dart';
import 'package:myapp/shared/widgets/app_button/app_button.dart';
import 'package:myapp/shared/widgets/app_dropdown.dart/app_dropdown.dart';
import 'package:myapp/shared/widgets/app_dropdown.dart/dropdown_model.dart';
import 'package:myapp/shared/widgets/app_sized_box/app_sized_box.dart';
import 'package:myapp/shared/widgets/padding.dart';

class SignupChooseLocationView extends StatelessWidget {
  final SignupCubit bloc;
  const SignupChooseLocationView({super.key, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(builder: (context, state) {
      return Container(
        padding: getScreensPadding(context).copyWith(top: AppSpacing.x20),
        child: Column(
          children: [
            AppSizedBox.square16,
            BodyWrappedWithChild(
              padding: getScreensPadding(context).copyWith(top: AppSpacing.x20),
              child: Column(
                children: [
                  AppdropdownButton(
                    onChange: (ouput) => {},
                    items: bloc.listCity,
                    hintText: 'Select your City',
                    dropdownButtonStyle: DropdownButtonStyle2(
                        backgroundColor: AppColors.grey3Light),
                  ),
                  AppSizedBox.square10,
                  AppdropdownButton(
                    onChange: (ouput) => {},
                    items: bloc.listCity,
                    hintText: 'Select your Area',
                    dropdownButtonStyle: DropdownButtonStyle2(
                        backgroundColor: AppColors.grey3Light),
                  ),
                  AppSizedBox.square20,
                  AppButton(
                    title: TranslationKeys.continueBtn.tr,
                    onPressed: () => bloc.goToNextStep(context),
                  ),
                ],
              ),
            )
          ],
        ),
      );
    });
  }
}
