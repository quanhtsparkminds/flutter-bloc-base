import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myapp/commands/core/app_color.dart';
import 'package:myapp/gen/assets.gen.dart';
import 'package:myapp/shared/utils/screen_size.dart';
import 'package:myapp/shared/widgets/app_sized_box/app_sized_box.dart';
import 'package:myapp/shared/widgets/app_text/text_custom.dart';

Widget rowItemInLine(BuildContext context,
        {String title = '',
        TextStyle? titleStyle,
        Widget? leading,
        Widget? subWidget,
        Function? onItemTap,
        SubItemType subItemType = SubItemType.text,
        LineColor lineColor = LineColor.white,
        Color bgColor = Colors.white,
        bool isEnd = false,
        String subTitle = '',
        Function? onSubTap}) =>
    CupertinoButton(
      onPressed: onItemTap != null ? () => onItemTap() : null,
      padding: EdgeInsets.zero,
      color: bgColor,
      disabledColor: bgColor,
      pressedOpacity: 0.4,
      borderRadius: BorderRadius.zero,
      child: Container(
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
            leading != null ? AppSizedBox.square10 : const Offstage(),
            TextCustom(
              title,
              style: titleStyle ??
                  TextStyle(
                    fontSize: Screens.resizeFitDevice(context, 28),
                  ),
            ),
            SizedBox(width: Screens.resizeFitDevice(context, 16)),
            subItemType == SubItemType.custom
                ? const Spacer()
                : const Offstage(),
            subItemType == SubItemType.text
                ? Expanded(
                    child: TextCustom(
                      subTitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.right,
                    ),
                  )
                : GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: onSubTap?.call(),
                    child: subWidget)
          ],
        ),
      ),
    );

Widget iconArrow() => SvgPicture.asset(
      Assets.svg.backTo,
      height: 22,
    );

enum SubItemType { text, custom }

enum LineColor { white, grey }
