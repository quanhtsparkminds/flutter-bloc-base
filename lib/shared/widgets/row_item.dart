import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myapp/commands/core/app_color.dart';
import 'package:myapp/commands/core/app_spacing.dart';
import 'package:myapp/gen/assets.gen.dart';
import 'package:myapp/shared/utils/screen_size.dart';
import 'package:myapp/shared/widgets/app_sized_box/app_sized_box.dart';
import 'package:myapp/shared/widgets/app_text/app_text.types.dart';
import 'package:myapp/shared/widgets/app_text/text_custom.dart';
import 'package:myapp/shared/widgets/row_item_inrow.dart';

Widget rowItemInRow(BuildContext context,
        {String title = '',
        TextStyle? titleStyle,
        double? height,
        Widget? leading,
        EdgeInsets? padding,
        Widget? subWidget,
        Function? onItemTap,
        Widget? ratingWidget,
        Widget? inforWidget,
        Widget? acction,
        Function? onPressAction,
        LineColor lineColor = LineColor.white,
        Color bgColor = Colors.white,
        bool isEnd = false,
        String subTitle = '',
        Function? onSubTap}) =>
    CupertinoButton(
      onPressed: onItemTap != null ? () => onItemTap() : null,
      padding: padding ?? EdgeInsets.zero,
      color: bgColor,
      disabledColor: bgColor,
      pressedOpacity: 0.9,
      borderRadius: const BorderRadius.all(Radius.circular(AppSpacing.x10)),
      child: Container(
        height: height,
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    width: Screens.resizeFitDevice(context, 1),
                    color: isEnd
                        ? AppColors.transparent
                        : lineColor == LineColor.white
                            ? AppColors.white
                            : AppColors.grey3Dark))),
        child: Row(
          children: [
            leading ?? const Offstage(),
            leading != null ? AppSizedBox.square15 : const Offstage(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.x6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: TextCustom(
                        title,
                        style: titleStyle,
                      ),
                    ),
                    AppSizedBox.square8,
                    Visibility(
                      visible: subTitle.isNotEmpty,
                      child: TextCustom(
                        subTitle,
                        maxLines: 1,
                        variant: AppTextVariant.subtitle,
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: AppColors.primaryColor),
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.right,
                      ),
                    ),
                    Visibility(
                        visible: ratingWidget != null,
                        child: Expanded(child: ratingWidget ?? Container())),
                    Visibility(
                        visible: inforWidget != null,
                        child: Expanded(child: inforWidget ?? Container()))
                  ],
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.x6),
                child: acction ?? const Offstage()),
          ],
        ),
      ),
    );

Widget iconArrow() => SvgPicture.asset(
      Assets.svg.backTo,
      height: 22,
    );
