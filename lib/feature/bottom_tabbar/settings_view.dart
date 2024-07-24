import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/commands/core/app_color.dart';
import 'package:myapp/commands/core/app_spacing.dart';
import 'package:myapp/commands/set_localauth_command.dart';
import 'package:myapp/feature/bottom_tabbar/settings_cubit/settings_cubit.dart';
import 'package:myapp/shared/widgets/app_button/app_button.dart';
import 'package:myapp/shared/widgets/appbar_custom.dart';
import 'package:myapp/shared/widgets/padding.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        return Scaffold(
          appBar: appBarCustom(context,
              title: 'Home Repair',
              action: [const Offstage()],
              leadingPress: () {},
              leadingType: LeadingType.none),
          backgroundColor: AppColors.secondaryColor,
          body: Padding(
            padding: getScreensPadding(context)
                .copyWith(top: AppSpacing.x0, bottom: 0),
            child: Column(
              children: [
                AppButton(
                  title: 'Logout',
                  onPressed: () => LocalAuthCommand().logout(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
