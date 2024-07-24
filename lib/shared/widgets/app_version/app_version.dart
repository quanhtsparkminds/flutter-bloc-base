import 'package:flutter/material.dart';
import 'package:myapp/commands/core/app_color.dart';
import 'package:myapp/flavors.dart';
import 'package:myapp/shared/utils/screen_size.dart';
import 'package:myapp/shared/widgets/app_text/app_text.types.dart';
import 'package:myapp/shared/widgets/app_text/text_custom.dart';

import 'package:package_info_plus/package_info_plus.dart';

class AppVersion extends StatefulWidget {
  const AppVersion({super.key});

  @override
  State<AppVersion> createState() => _AppVersionState();
}

class _AppVersionState extends State<AppVersion> {
  Future<PackageInfo> _getPackageInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Screens.getWidth(context),
      child: Center(
        child: Material(
          color: Colors.transparent,
          child: FutureBuilder<PackageInfo>(
            initialData: null,
            future: _getPackageInfo(),
            builder: (_, AsyncSnapshot<PackageInfo> snapshot) {
              if (snapshot.hasData) {
                return TextCustom(
                  F.env != 'production'
                      ? "${'App version'} (${snapshot.data?.version} +${snapshot.data?.buildNumber} ${F.env})"
                      : '',
                  style: TextStyle(
                      color: AppColors.borderInputColor, fontSize: 12),
                  variant: AppTextVariant.h4,
                );
              }
              return const Offstage();
            },
          ),
        ),
      ),
    );
  }
}
