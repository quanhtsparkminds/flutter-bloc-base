import 'package:bloc/bloc.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myapp/feature/bottom_tabbar/booking_view.dart';
import 'package:myapp/feature/bottom_tabbar/chats_view.dart';
import 'package:myapp/feature/bottom_tabbar/home_view.dart';
import 'package:myapp/feature/bottom_tabbar/recent_activity_view.dart';
import 'package:myapp/feature/bottom_tabbar/settings_view.dart';
import 'package:myapp/gen/assets.gen.dart';
import 'package:myapp/shared/utils/my_logger.dart';

part 'bottom_tabbar_state.dart';
part 'bottom_tabbar_cubit.freezed.dart';

enum FormFieldNames { phone, password }

class BottomTabbarCubit extends Cubit<BottomTabbarState> {
  BottomTabbarCubit() : super(const BottomTabbarState.initial());
  int _selectedIndex = 0;

  void handleIndexChange(int nextIndex) async {
    _selectedIndex = nextIndex;
    switch (_selectedIndex) {
      case 0:
        break;
      case 1:
        break;
      case 2:
        break;
      case 3:
        break;
      case 4:
        break;
      default:
        break;
    }
    emit(BottomTabbarState.bottomSelected(_selectedIndex));
  }

  void initState() {
    MyLogger.d('init bottomtabbar - $_selectedIndex');
  }

  startProcess() {
    emit(const BottomTabbarState.processing());
  }

  endLoading() {
    emit(const BottomTabbarState.endProcess());
  }

  List<Widget> get widgets => [
        const HomeView(),
        const RecentActivityView(),
        const BookingView(),
        const ChatsView(),
        const SettingsView(),
      ];

  List<TabItem> get tabbarItems => [
        TabItem(icon: Assets.icons.fiRrHome.image()),
        TabItem(icon: Assets.icons.fiRrSubtitles.image()),
        TabItem(icon: Assets.icons.fiRrAdd.image()),
        TabItem(icon: Assets.icons.fiRrEnvelope.image()),
        TabItem(icon: Assets.icons.fiRrUser.image()),
      ];

  int get selectedIndex => _selectedIndex;
  bool get isHomeTab => _selectedIndex == 0;
}
