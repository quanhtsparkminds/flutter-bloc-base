import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:myapp/commands/core/app_color.dart';
import 'package:myapp/commands/core/app_spacing.dart';
import 'package:myapp/feature/electrician/widgets/item_electrician_listview.dart';
import 'package:myapp/feature/electrician/widgets/vertical_divider.widget.dart';
import 'package:myapp/feature/popular_handyman/popular_handyman_cubit/popular_handyman_cubit.dart';
import 'package:myapp/gen/assets.gen.dart';
import 'package:myapp/shared/translations/translation_key.dart';
import 'package:myapp/shared/widgets/app_dropdown.dart/app_dropdown.dart';
import 'package:myapp/shared/widgets/app_dropdown.dart/dropdown_model.dart';
import 'package:myapp/shared/widgets/app_sized_box/app_sized_box.dart';
import 'package:myapp/shared/widgets/app_text/app_text.types.dart';
import 'package:myapp/shared/widgets/app_text/text_custom.dart';
import 'package:myapp/shared/widgets/appbar_custom.dart';
import 'package:myapp/shared/widgets/padding.dart';
import 'package:myapp/shared/widgets/pull_to_refresh/pull_to_list.dart';

class PopularHandymanView extends StatefulWidget {
  const PopularHandymanView({super.key});

  @override
  State<PopularHandymanView> createState() => _PopularHandymanViewState();
}

class _PopularHandymanViewState extends State<PopularHandymanView> {
  late PopularHandymanCubit _bloc;
  @override
  void initState() {
    super.initState();
    _bloc = context.read();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PopularHandymanCubit, PopularHandymanState>(
      builder: (context, state) {
        return Scaffold(
          appBar: appBarCustom(
            context,
            title: TranslationKeys.popularHandyman.tr,
            action: [const Offstage()],
            leadingPress: () => _bloc.handleBackPressed(),
            leadingType: LeadingType.back,
          ),
          backgroundColor: AppColors.secondaryColor,
          body: Padding(
            padding: getScreensPadding(context).copyWith(bottom: 0),
            child: Column(
              children: [
                AppSizedBox.square20,
                _buildFilterControls(),
                AppSizedBox.square20,
                _listViewBuilder(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildFilterControls() {
    TextStyle textFilterStyle = getAppTextStyleByVariant(AppTextVariant.text1)
        .copyWith(color: AppColors.greyStrong, fontWeight: FontWeight.bold);
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(AppSpacing.x7)),
        color: AppColors.white,
      ),
      padding: const EdgeInsets.only(right: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              AppdropdownButton(
                onChange: (ouput) => {},
                items: _bloc.listCategory,
                hintText: 'Top Rated',
                icon: Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: SvgPicture.asset(Assets.svg.iconIonicIosArrowDown),
                ),
                hintTextStyle: textFilterStyle,
                dropdownButtonStyle: DropdownButtonStyle2(
                  backgroundColor: AppColors.transparent,
                  borderRadius: BorderRadius.zero,
                  width: 140,
                ),
              ),
              const VerticalDividerWidget(height: 40),
            ],
          ),
          const Spacer(),
          CupertinoButton(
            onPressed: () => {},
            padding: EdgeInsets.zero,
            child: Row(
              children: [
                SvgPicture.asset(Assets.svg.iconIonicIosArrowRoundDown),
                SvgPicture.asset(Assets.svg.iconIonicIosArrowRoundUp),
                AppSizedBox.square10,
                TextCustom('Sort', style: textFilterStyle),
                AppSizedBox.square30,
                const VerticalDividerWidget(height: 40),
              ],
            ),
          ),
          const Spacer(),
          CupertinoButton(
            onPressed: () => {},
            padding: EdgeInsets.zero,
            child: Row(
              children: [
                SvgPicture.asset(Assets.svg.iconAwesomeFilter),
                AppSizedBox.square10,
                TextCustom('Filter', style: textFilterStyle),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _listViewBuilder() {
    return Expanded(
      child: PullToRefreshIndicator(
        isLoading: false,
        onRefresh: () async {
          return await Future(() => true);
        },
        data: _bloc.handrymans,
        itemBuilder: (context, index) {
          return ElectricianListWidget(
            item: _bloc.handrymans[index],
            onPressed: (item) {},
            onPressedHeart: (item) {},
          );
        },
        paddingContent: EdgeInsets.zero,
        separatorBuilder: (context, index) => AppSizedBox.square10,
      ),
    );
  }
}
