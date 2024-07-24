import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:myapp/app_initialized.dart';
import 'package:myapp/commands/bootstrap_command.dart';
import 'package:myapp/config/application.dart';
import 'package:myapp/feature/authentication/login_with_email/login_email_cubit/login_email_cubit.dart';
import 'package:myapp/feature/authentication/login_with_phone/login_phone_cubit/login_phone_cubit.dart';
import 'package:myapp/feature/bottom_tabbar/bottom_tabbar_cubit/bottom_tabbar_cubit.dart';
import 'package:myapp/go_router/app_go_router.dart';
import 'package:myapp/model/main_app_state.dart';
import 'package:myapp/model/main_auth_state.dart';
import 'package:myapp/model/main_local_auth_state.dart';
import 'package:myapp/model/network_connection_model.dart';
import 'package:myapp/shared/helps/storage_hepler.dart';
import 'package:myapp/shared/helps/translation_service.dart';
import 'package:myapp/shared/utils/my_logger.dart';
import 'package:myapp/themes.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

Future<void> runMain() async {
  WidgetsFlutterBinding.ensureInitialized();
  Application application = Application();
  await application.setup();
  await appInitialized();
  AppInitResult appInitResult = await doingAppInit();

  MainAppState mainAppState =
      MainAppState(userRepository: application.userRepository);
  MainAuthState mainAuthState = MainAuthState();
  ConnectivityState networkState = ConnectivityState();
  MainLocalAuthState mainLocalAuthState = MainLocalAuthState();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  await SentryFlutter.init(
    (options) {
      options.dsn =
          'https://09d2330dd0f0c0aac1ac1ea6a1125f8d@o4506267090157568.ingest.us.sentry.io/4507542378119168';
    },
    appRunner: () => runApp(
      MultiProvider(
        providers: [
          Provider.value(value: application.userRepository),
          BlocProvider<LoginEmailCubit>.value(
            value: LoginEmailCubit(),
          ),
          BlocProvider<LoginPhoneCubit>.value(
            value: LoginPhoneCubit(),
          ),
          BlocProvider<BottomTabbarCubit>.value(
            value: BottomTabbarCubit(),
          ),
          ChangeNotifierProvider.value(value: mainAppState),
          ChangeNotifierProvider.value(value: mainAuthState),
          ChangeNotifierProvider.value(value: networkState),
          ChangeNotifierProvider.value(value: mainLocalAuthState)
        ],
        child: _AppBootstrapper(appInitResult: appInitResult),
      ),
    ),
  );
}

final navigatorKey = GlobalKey<NavigatorState>();

class _AppBootstrapper extends StatefulWidget {
  final AppInitResult appInitResult;
  const _AppBootstrapper({required this.appInitResult});

  @override
  _AppBootstrapperState createState() => _AppBootstrapperState();
}

class _AppBootstrapperState extends State<_AppBootstrapper> {
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    scheduleMicrotask(() {
      BootstrapCommand().run(context);
      MyLogger.d('init main');
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(builder: (context, orientation) {
        return GetMaterialApp.router(
          routeInformationParser: AppRouter.router.routeInformationParser,
          routerDelegate: AppRouter.router.routerDelegate,
          routeInformationProvider: AppRouter.router.routeInformationProvider,
          debugShowCheckedModeBanner: false,
          locale: widget.appInitResult.locale,
          theme: AppTheme.light(),
          supportedLocales: const [
            Locale('en', 'US'),
            Locale('vi', 'VN'),
          ],
          fallbackLocale: TranslationService.fallbackLocale,
          translations: TranslationService(),
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          localeResolutionCallback: (locale, supportedLocales) {
            if (supportedLocales.contains(locale)) {
              return locale;
            }
            if (locale?.languageCode == 'vi') {
              return const Locale('vi', 'VN');
            }
            return const Locale('en', 'US');
          },
          builder: EasyLoading.init(
            builder: (context, child) {
              return MediaQuery(
                data: MediaQuery.of(context)
                    .copyWith(textScaler: TextScaler.noScaling),
                child: child ?? const SizedBox.shrink(),
              );
            },
          ),
        );
      });
    });
  }
}

class AppInitResult {
  final Locale? locale;
  final String? accessToken;
  final String? refreshToken;
  final bool? isDarkMode;

  AppInitResult(
      {this.locale, this.accessToken, this.refreshToken, this.isDarkMode});
}

Future<AppInitResult> doingAppInit() async {
  // Clear secure storage on reinstall app
  await SecureStorageHelper().clearSecureStorageOnReinstall();

  // Load language from storage
  String storedLanguage = StorageHelper().getLanguage();
  // Load access token from storage
  String storedAccessToken = await SecureStorageHelper().getAccessToken();

  // Load is darkmode from storage
  bool isDarkMode = StorageHelper().getIsDarkMode();

  return AppInitResult(
    locale: storedLanguage.isNotEmpty
        ? Locale(storedLanguage)
        : TranslationService.fallbackLocale,
    accessToken: storedAccessToken,
    isDarkMode: isDarkMode,
  );
}
