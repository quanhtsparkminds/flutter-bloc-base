import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myapp/commands/core/app_color.dart';
import 'package:myapp/gen/assets.gen.dart';
import 'package:myapp/shared/utils/screen_size.dart';
import 'package:myapp/shared/widgets/app_sized_box/app_sized_box.dart';
import 'package:myapp/shared/widgets/app_text/app_text.types.dart';
import 'package:myapp/shared/widgets/app_text/text_custom.dart';

PreferredSize appBarCustom(BuildContext context,
        {required Function leadingPress,
        Function? rightPress,
        String title = '',
        String? titleLeading,
        bool hideBackground = false,
        bool hideBackButton = false,
        Widget? titleCustom,
        double elevation = 0,
        Color leadingIconColor = const Color(0xff504D49),
        Color? appBarColor,
        LeadingType leadingType = LeadingType.drawer,
        bool isLongAction = false,
        List<Widget> action = const []}) =>
    PreferredSize(
      preferredSize: Screens.appbarHeight(context),
      child: AppBar(
        flexibleSpace: hideBackground
            ? Container()
            : Container(
                color: appBarColor ?? AppColors.white,
              ),
        backgroundColor: Colors.transparent,
        elevation: elevation,
        centerTitle: true,
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (!hideBackButton) AppSizedBox.square20,
            if (!hideBackButton)
              LeadingButtonCustom(
                leadingPress: leadingPress,
                titleLeading: titleLeading,
                leadingType: leadingType,
              ),
            if (!hideBackButton) const Spacer(),
            titleCustom ??
                TextCustom(
                  title,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  variant: AppTextVariant.title,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
            action.isNotEmpty ? const Spacer() : const Offstage(),
            Container(
              alignment: Alignment.centerRight,
              child: FittedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(width: Screens.resizeFitDevice(context, 10)),
                    Row(
                      children: action,
                    ),
                    const TextCustom(''),
                    SizedBox(width: Screens.resizeFitDevice(context, 24))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

class LeadingButtonCustom extends StatefulWidget {
  final Function? leadingPress;
  final LeadingType leadingType;
  final String? titleLeading;

  const LeadingButtonCustom({
    Key? key,
    this.leadingPress,
    required this.leadingType,
    this.titleLeading,
  }) : super(key: key);

  @override
  State<LeadingButtonCustom> createState() => _LeadingButtonCustomState();
}

class _LeadingButtonCustomState extends State<LeadingButtonCustom> {
  bool isTapDown = false;

  Widget _actionAppBar() {
    switch (widget.leadingType) {
      case LeadingType.drawer:
        return Row(
          children: [
            SizedBox(
              width: Screens.resizeFitDevice(context, 52),
              child: SvgPicture.asset(
                Assets.svg.menuLeft,
                colorFilter: ColorFilter.mode(
                    isTapDown ? AppColors.grey3Dark : AppColors.grey3Dark,
                    BlendMode.srcIn),
              ),
            ),
          ],
        );
      case LeadingType.close:
        return Row(
          children: [
            SizedBox(
              width: Screens.resizeFitDevice(context, 52),
              child: SvgPicture.asset(
                Assets.svg.closeOutline,
                colorFilter: ColorFilter.mode(
                    isTapDown ? AppColors.grey3Dark : AppColors.grey3Dark,
                    BlendMode.srcIn),
              ),
            ),
          ],
        );
      case LeadingType.back:
        return Row(
          children: [
            SizedBox(
              width: Screens.resizeFitDevice(context, 32),
              child: SvgPicture.asset(
                Assets.svg.backTo,
                colorFilter: ColorFilter.mode(
                    isTapDown ? AppColors.grey3Dark : AppColors.grey3Dark,
                    BlendMode.srcIn),
              ),
            ),
          ],
        );
      case LeadingType.none:
        return const Offstage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTapDown: (details) {
        setState(() {
          isTapDown = true;
        });
      },
      onTapUp: (details) {
        setState(() {
          isTapDown = false;
        });
      },
      onTapCancel: () {
        setState(() {
          isTapDown = false;
        });
      },
      onTap: widget.leadingPress != null
          ? () {
              widget.leadingPress?.call();
            }
          : () => Navigator.of(context).pop(),
      child: _actionAppBar(),
    );
  }
}

enum LeadingType { drawer, close, back, none }
