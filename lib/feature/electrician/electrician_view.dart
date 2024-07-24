import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myapp/commands/core/app_color.dart';
import 'package:myapp/commands/core/app_spacing.dart';
import 'package:myapp/feature/electrician/widgets/item_electrician_gridview.dart';
import 'package:myapp/feature/electrician/electrician_cubit/electrician_cubit.dart';
import 'package:myapp/feature/electrician/types/electrician.types.dart';
import 'package:myapp/feature/electrician/widgets/item_electrician_listview.dart';
import 'package:myapp/feature/electrician/widgets/vertical_divider.widget.dart';
import 'package:myapp/gen/assets.gen.dart';
import 'package:myapp/shared/widgets/app_dropdown.dart/app_dropdown.dart';
import 'package:myapp/shared/widgets/app_dropdown.dart/dropdown_model.dart';
import 'package:myapp/shared/widgets/app_sized_box/app_sized_box.dart';
import 'package:myapp/shared/widgets/app_text/app_text.types.dart';
import 'package:myapp/shared/widgets/app_text/text_custom.dart';
import 'package:myapp/shared/widgets/appbar_custom.dart';
import 'package:myapp/shared/widgets/padding.dart';
import 'package:myapp/shared/widgets/pull_to_refresh/pull_to_list.dart';

class ElectricianView extends StatefulWidget {
  const ElectricianView({super.key});

  @override
  State<ElectricianView> createState() => _ElectricianViewState();
}

class _ElectricianViewState extends State<ElectricianView> {
  late ElectricianCubit _bloc;
  @override
  void initState() {
    super.initState();
    _bloc = context.read();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ElectricianCubit, ElectricianState>(
      builder: (context, state) {
        return Scaffold(
          appBar: appBarCustom(
            context,
            title: 'Electrician',
            action: [const Offstage()],
            leadingPress: () => _bloc.handleBackPressed(),
            leadingType: LeadingType.back,
          ),
          backgroundColor: AppColors.secondaryColor,
          body: Padding(
            padding: getScreensPadding(context).copyWith(bottom: 0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextCustom(
                      _bloc.listType.title,
                      variant: AppTextVariant.text,
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: AppColors.greyStrong),
                    ),
                    Row(
                      children: [
                        _buildBoxIcon(
                          Assets.svg.iconAwesomeList,
                          ListType.listView,
                          onPressed: (value) => _bloc.onChangedTypeList(value),
                        ),
                        AppSizedBox.square10,
                        _buildBoxIcon(
                          Assets.svg.iconAwesomeGrid,
                          ListType.gird,
                          onPressed: (value) => _bloc.onChangedTypeList(value),
                        ),
                      ],
                    )
                  ],
                ),
                AppSizedBox.square20,
                _buildFilterControls(),
                AppSizedBox.square20,
                _bloc.isListView ? _listViewBuilder() : _gridViewBuilder(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildBoxIcon(String assets, ListType type,
      {required Function(ListType type) onPressed}) {
    bool isActive = _bloc.listType != type;
    return CupertinoButton(
      onPressed: () => onPressed(type),
      borderRadius: const BorderRadius.all(Radius.circular(AppSpacing.x7)),
      color: isActive ? AppColors.white : AppColors.secondaryColor3,
      disabledColor: AppColors.white,
      padding: const EdgeInsets.all(AppSpacing.x6),
      child: SizedBox(
        width: 20,
        child: SvgPicture.asset(
          assets,
          colorFilter: ColorFilter.mode(
              isActive ? AppColors.black : AppColors.white, BlendMode.srcIn),
        ),
      ),
    );
  }

  Widget _buildFilterControls() {
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
                hintText: 'Category',
                icon: Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: SvgPicture.asset(Assets.svg.iconIonicIosArrowDown),
                ),
                hintTextStyle: getAppTextStyleByVariant(AppTextVariant.text1)
                    .copyWith(color: AppColors.greyStrong),
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
            onPressed: () => _bloc.handleSortby(),
            padding: EdgeInsets.zero,
            child: Row(
              children: [
                SvgPicture.asset(Assets.svg.iconIonicIosArrowRoundDown),
                SvgPicture.asset(Assets.svg.iconIonicIosArrowRoundUp),
                AppSizedBox.square10,
                const TextCustom('Sort'),
                AppSizedBox.square30,
                const VerticalDividerWidget(height: 40),
              ],
            ),
          ),
          const Spacer(),
          CupertinoButton(
            onPressed: () => _bloc.handleFilter(),
            padding: EdgeInsets.zero,
            child: Row(
              children: [
                SvgPicture.asset(Assets.svg.iconAwesomeFilter),
                AppSizedBox.square10,
                const TextCustom('Filter'),
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

  Widget _gridViewBuilder() {
    return Expanded(
      child: GridView.builder(
        scrollDirection: Axis.vertical,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: AppSpacing.x16,
          mainAxisSpacing: AppSpacing.x16,
          childAspectRatio: 0.7,
        ),
        itemCount: _bloc.handrymans.length,
        itemBuilder: (context, index) {
          final item = _bloc.handrymans[index];
          return ElectricianGridWidget(
            item: item,
            onPressed: (Electrician item) {},
            onPressedHeart: (Electrician item) {},
            positioned: Posisition(top: 10, right: 10),
          );
        },
      ),
    );
  }
}
