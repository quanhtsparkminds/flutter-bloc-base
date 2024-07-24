import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazy_load_indexed_stack/lazy_load_indexed_stack.dart';
import 'package:myapp/commands/core/app_color.dart';
import 'package:myapp/commands/set_localauth_command.dart';
import 'package:myapp/feature/bottom_tabbar/bottom_tabbar_cubit/bottom_tabbar_cubit.dart';
import 'package:myapp/shared/utils/my_logger.dart';

class BottomTabbarView extends StatefulWidget {
  const BottomTabbarView({Key? key}) : super(key: key);

  @override
  State<BottomTabbarView> createState() => _BottomTabbarViewState();
}

class _BottomTabbarViewState extends State<BottomTabbarView> {
  late BottomTabbarCubit _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = context.read();
  }

  @override
  void dispose() {
    super.dispose();
    MyLogger.d('dispose bottomtabbar');
  }

  @override
  Widget build(BuildContext context) {
    String userId = LocalAuthCommand().userId;
    String accessToken = LocalAuthCommand().accessToken;
    MyLogger.d('useID |$userId|');
    MyLogger.d('accessToken |${accessToken.isNotEmpty}|');
    return BlocBuilder<BottomTabbarCubit, BottomTabbarState>(
        builder: (context, state) {
      return Scaffold(
        backgroundColor: AppColors.secondaryColor,
        body: LazyLoadIndexedStack(
          index: _bloc.selectedIndex,
          children: _bloc.widgets,
        ),
        bottomNavigationBar: ConvexAppBar(
          backgroundColor: AppColors.white,
          elevation: 0,
          onTap: _bloc.handleIndexChange,
          style: TabStyle.fixed,
          items: _bloc.tabbarItems,
        ),
      );
    });
  }
}
