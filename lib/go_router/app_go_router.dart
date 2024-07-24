import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
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
import 'package:myapp/feature/category/category_cubit/category_cubit.dart';
import 'package:myapp/feature/category/category_view.dart';
import 'package:myapp/feature/electrician/electrician_cubit/electrician_cubit.dart';
import 'package:myapp/feature/electrician/electrician_view.dart';
import 'package:myapp/feature/favorite/favorite_cubit/favorite_cubit.dart';
import 'package:myapp/feature/favorite/favorite_view.dart';
import 'package:myapp/feature/flash/flash_view.dart';
import 'package:myapp/feature/forgot_password/forgot_password_cubit/forgot_password_cubit.dart';
import 'package:myapp/feature/forgot_password/forgot_password_view.dart';
import 'package:myapp/feature/introduction/introduction_cubit/introduction_cubit.dart';
import 'package:myapp/feature/introduction/introduction_view.dart';
import 'package:myapp/feature/local_authentication/format_cubit/local_authentication_cubit.dart';
import 'package:myapp/feature/local_authentication/local_authentication_view.dart';
import 'package:myapp/feature/main_auth/authenticate_view.dart';
import 'package:myapp/feature/popular_handyman/popular_handyman_cubit/popular_handyman_cubit.dart';
import 'package:myapp/feature/popular_handyman/popular_handyman_view.dart';
import 'package:myapp/feature/setup_localauth/setup_localauth_cubit/setup_localauth_cubit.dart';
import 'package:myapp/feature/setup_localauth/setup_localauth_view.dart';
import 'package:myapp/go_router/routes.types.dart';

class AppRouter {
  AppRouter._();
  static final _rootNavigator = GlobalKey<NavigatorState>();

  static GlobalKey<NavigatorState> get rootNavigator => _rootNavigator;

  static final _shellNavigatorHome =
      GlobalKey<NavigatorState>(debugLabel: 'HOME NAVIGATOR');
  static final _shellNavigatorRecentActivity =
      GlobalKey<NavigatorState>(debugLabel: 'RECENTACTIVITY NAVIGATOR');
  static final _shellNavigatorBooking =
      GlobalKey<NavigatorState>(debugLabel: 'BOOKING NAVIGATOR');
  static final _shellNavigatorInbox =
      GlobalKey<NavigatorState>(debugLabel: 'INBOX NAVIGATOR');
  static final _shellNavigatorProfile =
      GlobalKey<NavigatorState>(debugLabel: 'PROFILE NAVIGATOR');
  static GoRouter get router => _goRouter;

  static final GoRouter _goRouter = GoRouter(
    initialLocation: AppRoutes.flash.path,
    navigatorKey: _rootNavigator,
    routes: [
      GoRoute(
        path: AppRoutes.flash.path,
        name: AppRoutes.flash.name,
        builder: (context, state) => const FlashScreens(),
      ),
      GoRoute(
        path: AppRoutes.introduction.path,
        name: AppRoutes.introduction.name,
        builder: (context, state) => BlocProvider<IntroductionCubit>(
            create: (BuildContext context) {
              final cubit = IntroductionCubit();
              cubit.initState();
              return cubit;
            },
            child: const IntroductionView()),
      ),
      GoRoute(
        path: AppRoutes.authenticate.path,
        name: AppRoutes.authenticate.name,
        builder: (context, state) => const AuthenticateView(),
        routes: <GoRoute>[
          GoRoute(
            path: AppRoutes.loginWithEmail.path,
            name: AppRoutes.loginWithEmail.name,
            builder: (context, state) => BlocProvider<LoginEmailCubit>(
                create: (context) {
                  final cubit = LoginEmailCubit();
                  cubit.initState(context);
                  return cubit;
                },
                child: const LoginWithEmailView()),
          ),
          GoRoute(
            path: AppRoutes.loginWithPhone.path,
            name: AppRoutes.loginWithPhone.name,
            builder: (context, state) => BlocProvider<LoginPhoneCubit>(
                create: (context) {
                  final cubit = LoginPhoneCubit();
                  cubit.initState(context);
                  return cubit;
                },
                child: const LoginWithPhoneView()),
          ),
          GoRoute(
            path: AppRoutes.forgotPassword.path,
            name: AppRoutes.forgotPassword.name,
            builder: (context, state) => BlocProvider<ForgotPasswordCubit>(
                create: (context) {
                  final cubit = ForgotPasswordCubit();
                  cubit.initState();
                  return cubit;
                },
                child: const ForgotPasswordView()),
          ),
          GoRoute(
            path: AppRoutes.signup.path,
            name: AppRoutes.signup.name,
            builder: (context, state) => BlocProvider<SignupCubit>(
                create: (context) {
                  final cubit = SignupCubit();
                  cubit.initState();
                  return cubit;
                },
                child: const SignUpView()),
          ),
          GoRoute(
            path: AppRoutes.setupLocalAuthentication.path,
            name: AppRoutes.setupLocalAuthentication.name,
            builder: (context, state) => BlocProvider<SetupLocalAuthCubit>(
                create: (context) {
                  final cubit = SetupLocalAuthCubit();
                  cubit.initState();
                  return cubit;
                },
                child: const SetupLocalAuthView()),
          ),
          GoRoute(
            path: AppRoutes.localAuthentication.path,
            name: AppRoutes.localAuthentication.name,
            builder: (context, state) => BlocProvider<LocalAuthenticationCubit>(
                create: (context) {
                  final cubit = LocalAuthenticationCubit();
                  cubit.initState(context);
                  return cubit;
                },
                child: const LocalAuthenticationView()),
          ),
        ],
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) => MultiBlocProvider(
          providers: [
            BlocProvider<BottomTabbarCubit>(create: (BuildContext context) {
              final cubit = BottomTabbarCubit();
              cubit.initState();
              return cubit;
            }),
            BlocProvider<HomeCubit>(create: (BuildContext context) {
              final cubit = HomeCubit();
              cubit.initState();
              return cubit;
            }),
            BlocProvider<RecentActivityCubit>(create: (BuildContext context) {
              final cubit = RecentActivityCubit();
              cubit.initState();
              return cubit;
            }),
            BlocProvider<BookingCubit>(create: (BuildContext context) {
              final cubit = BookingCubit();
              cubit.initState();
              return cubit;
            }),
            BlocProvider<ChatCubit>(create: (BuildContext context) {
              final cubit = ChatCubit();
              cubit.initState();
              return cubit;
            }),
            BlocProvider<SettingsCubit>(create: (BuildContext context) {
              final cubit = SettingsCubit();
              cubit.initState();
              return cubit;
            }),
          ],
          child: const BottomTabbarView(),
        ),
        branches: <StatefulShellBranch>[
          // HOME
          StatefulShellBranch(
            navigatorKey: _shellNavigatorHome,
            routes: <RouteBase>[
              GoRoute(
                  path: AppRoutes.home.path,
                  name: AppRoutes.home.name,
                  builder: (BuildContext context, GoRouterState state) =>
                      BlocProvider<HomeCubit>(
                          create: (BuildContext context) {
                            final cubit = HomeCubit();
                            cubit.initState();
                            return cubit;
                          },
                          child: const HomeView()),
                  routes: [
                    GoRoute(
                      parentNavigatorKey: _rootNavigator,
                      path: AppRoutes.favorite.path,
                      name: AppRoutes.favorite.name,
                      builder: (BuildContext context, GoRouterState state) =>
                          BlocProvider<FavoriteCubit>(
                              create: (BuildContext context) {
                                final cubit = FavoriteCubit();
                                cubit.initState();
                                return cubit;
                              },
                              child: const FavoriteView()),
                    )
                  ]),
            ],
          ),
          // RECENT ACTIVTY
          StatefulShellBranch(
            navigatorKey: _shellNavigatorRecentActivity,
            routes: <RouteBase>[
              GoRoute(
                  path: AppRoutes.recentActivity.path,
                  name: AppRoutes.recentActivity.name,
                  builder: (BuildContext context, GoRouterState state) =>
                      BlocProvider<RecentActivityCubit>(
                          create: (BuildContext context) {
                            final cubit = RecentActivityCubit();
                            cubit.initState();
                            return cubit;
                          },
                          child: const RecentActivityView()),
                  routes: [
                    GoRoute(
                      parentNavigatorKey: _rootNavigator,
                      path: AppRoutes.popularHandyman.path,
                      name: AppRoutes.popularHandyman.name,
                      builder: (BuildContext context, GoRouterState state) =>
                          BlocProvider<PopularHandymanCubit>(
                              create: (BuildContext context) {
                                final cubit = PopularHandymanCubit();
                                cubit.initState();
                                return cubit;
                              },
                              child: const PopularHandymanView()),
                    ),
                  ]),
            ],
          ),
          // BOOKING TAB
          StatefulShellBranch(
            navigatorKey: _shellNavigatorBooking,
            routes: <RouteBase>[
              GoRoute(
                path: AppRoutes.booking.path,
                name: AppRoutes.booking.name,
                builder: (BuildContext context, GoRouterState state) =>
                    BlocProvider<BookingCubit>(
                        create: (BuildContext context) {
                          final cubit = BookingCubit();
                          cubit.initState();
                          return cubit;
                        },
                        child: const BookingView()),
              ),
            ],
          ),
          // CHAT TAB
          StatefulShellBranch(
            navigatorKey: _shellNavigatorInbox,
            routes: <RouteBase>[
              GoRoute(
                path: AppRoutes.chat.path,
                name: AppRoutes.chat.name,
                builder: (BuildContext context, GoRouterState state) =>
                    BlocProvider<ChatCubit>(
                        create: (BuildContext context) {
                          final cubit = ChatCubit();
                          cubit.initState();
                          return cubit;
                        },
                        child: const ChatsView()),
              ),
            ],
          ),
          // PROFILE TAB
          StatefulShellBranch(
            navigatorKey: _shellNavigatorProfile,
            routes: <RouteBase>[
              GoRoute(
                path: AppRoutes.profile.path,
                name: AppRoutes.profile.name,
                builder: (BuildContext context, GoRouterState state) =>
                    BlocProvider<SettingsCubit>(
                        create: (BuildContext context) {
                          final cubit = SettingsCubit();
                          cubit.initState();
                          return cubit;
                        },
                        child: const SettingsView()),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigator,
        path: AppRoutes.category.path,
        name: AppRoutes.category.name,
        builder: (context, state) => BlocProvider<CategoryCubit>(
            create: (BuildContext context) {
              final cubit = CategoryCubit();
              // final categori = currentConfiguration.state as Categories;
              cubit.initState();
              return cubit;
            },
            child: const CategoryView()),
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigator,
        path: AppRoutes.electrician.path,
        name: AppRoutes.electrician.name,
        builder: (context, state) => BlocProvider<ElectricianCubit>(
            create: (BuildContext context) {
              final cubit = ElectricianCubit();
              cubit.initState(true);
              return cubit;
            },
            child: const ElectricianView()),
      ),
    ],
    // redirect: (context, state) {
    //   return state.namedLocation(AppRoutes.flash.name);
    // },
  );
}
