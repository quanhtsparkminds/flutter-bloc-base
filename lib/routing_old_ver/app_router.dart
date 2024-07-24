import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:myapp/commands/navigate_back_command.dart';
import 'package:myapp/feature/authentication/login_with_email/login_email_cubit/login_email_cubit.dart';
import 'package:myapp/feature/authentication/login_with_email/login_with_email.dart';
import 'package:myapp/feature/authentication/login_with_phone/login_phone_cubit/login_phone_cubit.dart';
import 'package:myapp/feature/authentication/login_with_phone/login_with_phone.dart';
import 'package:myapp/feature/authentication/signup/signup_cubit/signup_cubit.dart';
import 'package:myapp/feature/authentication/signup/signup_view.dart';
import 'package:myapp/feature/bottom_tabbar/booking_cubit/booking_cubit.dart';
import 'package:myapp/feature/bottom_tabbar/booking_view.dart';
import 'package:myapp/feature/bottom_tabbar/bottom_tabbar_cubit/bottom_tabbar_cubit.dart';
import 'package:myapp/feature/bottom_tabbar/bottom_tabbar_view.dart';
import 'package:myapp/feature/bottom_tabbar/chat_cubit/chat_cubit.dart';
import 'package:myapp/feature/bottom_tabbar/chats_view.dart';
import 'package:myapp/feature/bottom_tabbar/home_cubit/home_cubit.dart';
import 'package:myapp/feature/bottom_tabbar/home_view.dart';
import 'package:myapp/feature/bottom_tabbar/recent_activity/recent_activity_cubit.dart';
import 'package:myapp/feature/bottom_tabbar/recent_activity_view.dart';
import 'package:myapp/feature/bottom_tabbar/settings_cubit/settings_cubit.dart';
import 'package:myapp/feature/bottom_tabbar/settings_view.dart';
import 'package:myapp/feature/category/category_view.dart';
import 'package:myapp/feature/category/category_cubit/category_cubit.dart';
import 'package:myapp/feature/electrician/electrician_cubit/electrician_cubit.dart';
import 'package:myapp/feature/electrician/electrician_view.dart';
import 'package:myapp/feature/flash/flash_view.dart';
import 'package:myapp/feature/forgot_password/forgot_password_cubit/forgot_password_cubit.dart';
import 'package:myapp/feature/forgot_password/forgot_password_view.dart';
import 'package:myapp/feature/format/format_view.dart';
import 'package:myapp/feature/introduction/introduction_cubit/introduction_cubit.dart';
import 'package:myapp/feature/introduction/introduction_view.dart';
import 'package:myapp/feature/local_authentication/format_cubit/local_authentication_cubit.dart';
import 'package:myapp/feature/local_authentication/local_authentication_view.dart';
import 'package:myapp/feature/main_auth/authenticate_view.dart';
import 'package:myapp/feature/setup_localauth/setup_localauth_cubit/setup_localauth_cubit.dart';
import 'package:myapp/feature/setup_localauth/setup_localauth_view.dart';
import 'package:myapp/model/main_app_state.dart';
import 'package:myapp/model/main_auth_state.dart';
import 'package:myapp/model/main_local_auth_state.dart';
import 'package:myapp/model/network_connection_model.dart';
import 'package:myapp/routing_old_ver/router/navigator_cubit.dart';
import 'package:myapp/routing_old_ver/router/navigator_stack.dart';
import 'package:myapp/routing_old_ver/app_routes.dart';
import 'package:myapp/routing_old_ver/page_configuration.dart';
import 'package:myapp/routing_old_ver/page_configuration/bottom_tabbar_page_configuration.dart';
import 'package:myapp/routing_old_ver/page_configuration/catergory_page_configuration.dart';
import 'package:myapp/routing_old_ver/page_configuration/electrician_page_configuration.dart';
import 'package:myapp/routing_old_ver/page_configuration/forgot_password_page_configuration.dart';
import 'package:myapp/routing_old_ver/page_configuration/local_authentication_page_configuration.dart';
import 'package:myapp/routing_old_ver/page_configuration/login_email_page_configuration.dart';
import 'package:myapp/routing_old_ver/page_configuration/setup_localauth_page_configuration.dart';
import 'package:myapp/routing_old_ver/page_configuration/login_phone_page_configuration.dart';
import 'package:myapp/routing_old_ver/page_configuration/authenticate_page_configuration.dart';
import 'package:myapp/routing_old_ver/page_configuration/introduction_page_configuration.dart';
import 'package:myapp/routing_old_ver/page_configuration/signup_page_configuration.dart';
import 'package:myapp/shared/utils/my_logger.dart';
import '../config/main_app_scaffold.dart';

class AppRouterDelegate extends RouterDelegate<PageConfiguration>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<PageConfiguration> {
  final MainAppState mainAppState;
  final MainAuthState mainAuthState;
  final ConnectivityState networkState;
  final MainLocalAuthState mainLocalAuthState;

  AppRouterDelegate(this.mainAppState, this.mainAuthState, this.networkState,
      this.mainLocalAuthState) {
    mainAppState.addListener(notifyListeners);
    mainAuthState.addListener(notifyListeners);
    networkState.addListener(notifyListeners);
    mainLocalAuthState.addListener(notifyListeners);
  }

  @override
  void dispose() {
    mainAppState.removeListener(notifyListeners);
    mainAuthState.removeListener(notifyListeners);
    networkState.removeListener(notifyListeners);
    mainLocalAuthState.removeListener(notifyListeners);
    super.dispose();
  }

  @override
  PageConfiguration get currentConfiguration => mainAppState.currentPage;

  @override
  Widget build(BuildContext context) {
    bool hasSetInitialRoute = mainAppState.hasSetInitialRoute;
    bool showSplash = hasSetInitialRoute == false;

    return MainAppScaffold(
      child: BlocBuilder<NavigationCubit, NavigationStack>(
        builder: (context, state) {
          return Navigator(
            onPopPage: _handleNavigatorPop,
            key: navigatorKey,
            pages: [
              if (showSplash) ...[
                _wrapContentInPage(const FlashScreens()),
              ] else ...[
                ..._buildPageList(context)
              ]
            ],
          );
        },
      ),
    );
  }

  List<Page> _buildPageList(BuildContext context) {
    MyLogger.d('page-tre -${currentConfiguration.pageTree}');
    switch (currentConfiguration.runtimeType) {
      case IntroductionPageConfiguration:
        return [
          _createContentInPage(
              BlocProvider<IntroductionCubit>(
                  create: (BuildContext context) {
                    final cubit = IntroductionCubit();
                    cubit.initState();
                    return cubit;
                  },
                  child: const IntroductionView()),
              currentConfiguration),
        ];
      case AuthenticatePageConfiguration:
        return [
          _createContentInPage(const AuthenticateView(), currentConfiguration)
        ];
      case SignUpPageConfiguration:
        return [
          _createContentInPage(
              BlocProvider<SignupCubit>(
                  create: (BuildContext context) {
                    final cubit = SignupCubit();
                    cubit.initState();
                    return cubit;
                  },
                  child: const SignUpView()),
              currentConfiguration),
        ];
      case LoginPhonePageConfiguration:
        return [
          _createContentInPage(
              BlocProvider<LoginPhoneCubit>(
                  create: (BuildContext context) {
                    final cubit = LoginPhoneCubit();
                    cubit.initState(context);
                    return cubit;
                  },
                  child: const LoginWithPhoneView()),
              currentConfiguration),
        ];
      case LoginEmailPageConfiguration:
        return [
          _createContentInPage(
              BlocProvider<LoginEmailCubit>(
                  create: (BuildContext context) {
                    final cubit = LoginEmailCubit();
                    cubit.initState(context);
                    return cubit;
                  },
                  child: const LoginWithEmailView()),
              currentConfiguration),
        ];
      case ForgotPasswordPageConfiguration:
        return [
          _createContentInPage(
              BlocProvider<ForgotPasswordCubit>(
                  create: (BuildContext context) {
                    final cubit = ForgotPasswordCubit();
                    cubit.initState();
                    return cubit;
                  },
                  child: const ForgotPasswordView()),
              currentConfiguration),
        ];
      case SetupLocalAuthPageConfiguration:
        return [
          _createContentInPage(
              BlocProvider<SetupLocalAuthCubit>(
                  create: (BuildContext context) {
                    final cubit = SetupLocalAuthCubit();
                    cubit.initState();
                    return cubit;
                  },
                  child: const SetupLocalAuthView()),
              currentConfiguration),
        ];
      case LocalAuthenticationPageConfiguration:
        return [
          _createContentInPage(
              BlocProvider<LocalAuthenticationCubit>(
                  create: (BuildContext context) {
                    final cubit = LocalAuthenticationCubit();
                    cubit.initState(context);
                    return cubit;
                  },
                  child: const LocalAuthenticationView()),
              currentConfiguration),
        ];
      case BottomTabbarPageConfiguration:
        return [
          _createContentInPage(
              MultiBlocProvider(
                providers: [
                  BlocProvider<BottomTabbarCubit>(
                      create: (BuildContext context) {
                        final cubit = BottomTabbarCubit();
                        cubit.initState();
                        return cubit;
                      },
                      child: const BottomTabbarView()),
                  BlocProvider<HomeCubit>(
                      create: (BuildContext context) {
                        final cubit = HomeCubit();
                        cubit.initState();
                        return cubit;
                      },
                      child: const HomeView()),
                  BlocProvider<RecentActivityCubit>(
                      create: (BuildContext context) {
                        final cubit = RecentActivityCubit();
                        cubit.initState();
                        return cubit;
                      },
                      child: const RecentActivityView()),
                  BlocProvider<BookingCubit>(
                      create: (BuildContext context) {
                        final cubit = BookingCubit();
                        cubit.initState();
                        return cubit;
                      },
                      child: const BookingView()),
                  BlocProvider<ChatCubit>(
                      create: (BuildContext context) {
                        final cubit = ChatCubit();
                        cubit.initState();
                        return cubit;
                      },
                      child: const ChatsView()),
                  BlocProvider<SettingsCubit>(
                      create: (BuildContext context) {
                        final cubit = SettingsCubit();
                        cubit.initState();
                        return cubit;
                      },
                      child: const SettingsView()),
                ],
                child: const BottomTabbarView(),
              ),
              currentConfiguration)
        ];
      case CategoryPageConfiguration:
        return [
          _createContentInPage(
              BlocProvider<CategoryCubit>(
                  create: (BuildContext context) {
                    final cubit = CategoryCubit();
                    // final categori = currentConfiguration.state as Categories;
                    cubit.initState();
                    return cubit;
                  },
                  child: const CategoryView()),
              currentConfiguration),
        ];
      case ElectricianPageConfiguration:
        return [
          _createContentInPage(
              BlocProvider<ElectricianCubit>(
                  create: (BuildContext context) {
                    final cubit = ElectricianCubit();
                    final params = currentConfiguration.state as bool;
                    cubit.initState(params);
                    return cubit;
                  },
                  child: const ElectricianView()),
              currentConfiguration),
        ];
      default:
        return [
          _createContentInPage(const FormatView(), currentConfiguration),
        ];
    }
  }

  Page _createContentInPage(Widget e, PageConfiguration configuration) {
    return MaterialPage<void>(
      child: e,
      key: ValueKey(configuration.key),
      name: configuration.path,
      arguments: configuration,
    );
  }

  Page _wrapContentInPage(Widget e) {
    return MaterialPage<void>(child: e);
  }

  @override
  Future<void> setInitialRoutePath(PageConfiguration configuration) async {
    if (kReleaseMode == false) {}
    await setNewRoutePath(configuration);
    await Future.delayed(1.seconds);
    mainAppState.hasSetInitialRoute = true;
    MyLogger.d('setInitialRoutePath complete');
  }

  @override
  Future<void> setNewRoutePath(PageConfiguration configuration) async {}

  bool tryGoBack() {
    if (currentConfiguration.pageTree.length > 1) {
      NavigateBackCommand().run();
      return true;
    }
    if (currentConfiguration.path != Paths.BOTTOM_TABBAR &&
        mainAuthState.isAuthenticated) {
      // NavigateToCommand().run(BottomTabbarPageConfiguration());
      // NavigateToCommand().run(AppRoutes.home.name);
      return true;
    }
    return false;
  }

  //
  @override
  Future<bool> popRoute() async => tryGoBack();

  bool _handleNavigatorPop(Route<dynamic> route, dynamic result) {
    if (route.didPop(result)) {
      return tryGoBack();
    }
    return false;
  }

  @override
  GlobalKey<NavigatorState>? get navigatorKey => GlobalKey();
}
