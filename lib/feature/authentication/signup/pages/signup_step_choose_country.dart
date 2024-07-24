import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:myapp/commands/core/app_color.dart';
import 'package:myapp/commands/core/app_spacing.dart';
import 'package:myapp/feature/authentication/signup/signup_cubit/signup_cubit.dart';
import 'package:myapp/gen/assets.gen.dart';
import 'package:myapp/shared/translations/translation_key.dart';
import 'package:myapp/shared/widgets/app_button/app_button.dart';
import 'package:myapp/shared/widgets/app_language/country.dart';
import 'package:myapp/shared/widgets/app_sized_box/app_sized_box.dart';
import 'package:myapp/shared/widgets/app_text/app_text.types.dart';
import 'package:myapp/shared/widgets/custom_text_form_field.dart';
import 'package:myapp/shared/widgets/padding.dart';
import 'package:myapp/shared/widgets/row_item_inrow.dart';

class SignupChooseCountryView extends StatefulWidget {
  final SignupCubit bloc;
  const SignupChooseCountryView({super.key, required this.bloc});

  @override
  State<SignupChooseCountryView> createState() =>
      _SignupChooseCountryViewState();
}

class _SignupChooseCountryViewState extends State<SignupChooseCountryView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(builder: (context, state) {
      return Column(
        children: [
          Expanded(
            child: Container(
              padding: getScreensPadding(context).copyWith(top: AppSpacing.x20),
              child: Column(
                children: [
                  CustomTextFormField(
                    controller: widget.bloc.searchController,
                    focusNode: widget.bloc.searchFocusNode,
                    hintText: TranslationKeys.placeholderSearchCountry.tr,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                          errorText: TranslationKeys.validateRequired.tr),
                    ]),
                    fillColor: AppColors.white,
                    keyboardType: TextInputType.text,
                    prefixIcon: SvgPicture.asset(
                      Assets.svg.seachOutline,
                      colorFilter:
                          ColorFilter.mode(AppColors.textDark, BlendMode.srcIn),
                    ),
                    fieldKey: widget.bloc.formFieldKeys[FormFieldName.search]!,
                    name: widget.bloc.formFieldNames[FormFieldName.search]!,
                  ),
                  AppSizedBox.square20,
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      color: AppColors.white,
                      child: ListView.separated(
                          itemBuilder: (context, index) {
                            CountryResidence country =
                                widget.bloc.listCountries[index];
                            bool isActive =
                                widget.bloc.countrySelect == country;
                            return rowItemInLine(
                              context,
                              leading: SvgPicture.asset(
                                country.flag,
                              ),
                              onItemTap: () =>
                                  widget.bloc.handleSelectCountry(country),
                              titleStyle: getAppTextStyleByVariant(
                                      AppTextVariant.button)
                                  .copyWith(fontWeight: FontWeight.w400),
                              title: country.countryName,
                              subItemType: SubItemType.custom,
                              subWidget: isActive
                                  ? SvgPicture.asset(
                                      Assets.svg.checkMark,
                                      width: AppSpacing.x20,
                                    )
                                  : const Offstage(),
                            );
                          },
                          separatorBuilder: (context, index) =>
                              Divider(color: AppColors.greyLine),
                          itemCount: widget.bloc.listCountries.length),
                    ),
                  )
                ],
              ),
            ),
          ),
          Visibility(
            visible: widget.bloc.countrySelect != CountryResidence.unknown,
            child: Container(
              padding: getScreensPadding(context).copyWith(top: AppSpacing.x0),
              child: AppButton(
                title: TranslationKeys.continueBtn.tr,
                onPressed: () => widget.bloc.goToNextStep(context),
              ),
            ),
          ),
        ],
      );
    });
  }
}
