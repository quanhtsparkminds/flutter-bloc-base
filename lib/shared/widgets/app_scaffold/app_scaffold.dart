import 'dart:async';

import 'package:flutter/material.dart';
import 'package:myapp/commands/navigate_back_command.dart';
import 'package:myapp/shared/widgets/app_button/app_button.dart';
import 'package:myapp/shared/widgets/app_button/app_button.types.dart';

class AppScafold extends StatelessWidget {
  final Widget child;
  final Widget? bottomWidget;
  final Function(String)? onSearch;
  final Function()? onFilter;
  final String? title;
  final Color? bgColor;
  final Color? appBarColor;
  final Color? appBarContentColor;
  final String? titleBottom;
  final bool? onBack;
  final EdgeInsets padding;
  final Function? onBackTap;
  final Function()? onBottomTap;
  const AppScafold(
      {super.key,
      required this.child,
      this.title,
      this.onSearch,
      this.titleBottom = '',
      this.bgColor,
      this.bottomWidget,
      this.appBarContentColor,
      this.appBarColor,
      this.onFilter,
      this.padding = const EdgeInsets.only(top: 23, left: 23, right: 23),
      this.onBottomTap,
      this.onBack = true,
      this.onAdd,
      this.onBackTap});
  final Function()? onAdd;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: false,
        titleSpacing: 0,
        backgroundColor: appBarColor ?? Colors.white,
        automaticallyImplyLeading: false,
        // elevation: 0,
        // brightness: Brightness.light,
        leading: (onBack ?? false)
            ? GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () async {
                  try {
                    if (onBackTap == null) {
                      Future.delayed(const Duration(milliseconds: 500), () {
                        NavigateBackCommand().run();
                      });
                    } else {
                      Timer.run(() {
                        onBackTap!();
                      });
                    }
                  } catch (e) {
                    print(e);
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: appBarContentColor ?? Colors.black54,
                    size: 20,
                  ),
                ),
              )
            : null,
        title: title != null
            ? Text(title!,
                style: TextStyle(
                    fontSize: 18,
                    color: appBarContentColor ?? Colors.black,
                    fontWeight: FontWeight.bold))
            : onSearch != null
                ? null
                : null,
        actions: [
          onFilter != null
              ? GestureDetector(
                  onTap: onFilter,
                  child: const Padding(
                    padding: EdgeInsets.only(right: 15),
                    child: Icon(
                      Icons.filter_list,
                      color: Colors.black54,
                    ),
                  ),
                )
              : Container(),
        ],
      ),
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              child: Container(
                padding: padding,
                constraints: const BoxConstraints.expand(),
                color: bgColor ?? Colors.grey[200],
                child: child,
              ),
            ),
            if (bottomWidget != null) bottomWidget!,
            if (onBottomTap != null)
              AppButton(
                title: 'titleBottom',
                variant: AppButtonVariant.primaryAmber,
                onPressed: onBottomTap,
              )
          ],
        ),
      ),
      floatingActionButton: onAdd != null
          ? FloatingActionButton(
              elevation: 0,
              mini: true,
              onPressed: () {
                onAdd!();
              },
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            )
          : null,
    );
  }
}
