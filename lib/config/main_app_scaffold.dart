import 'package:myapp/commands/core/app_color.dart';
import 'package:myapp/event/event_bus.dart';
import 'package:myapp/exported_packages.dart';
import 'package:myapp/model/main_app_state.dart';
import 'package:myapp/model/network_connection_model.dart';
import 'package:myapp/shared/poppover/popover_controller.dart';
import 'package:myapp/commands/base_command.dart' as commands;
import 'package:flutter/material.dart';
import 'package:myapp/shared/utils/my_logger.dart';
import 'package:myapp/themes.dart';
import 'package:statsfl/statsfl.dart';

/// Wraps the entire app, providing it with various helper classes and wrapper widgets.
class MainAppScaffold extends StatefulWidget {
  const MainAppScaffold(
      {Key? key, required this.child, this.useSafeArea = false})
      : super(key: key);
  final Widget child;
  final bool useSafeArea;

  @override
  State<MainAppScaffold> createState() => _MainAppScaffoldState();
}

class _MainAppScaffoldState extends State<MainAppScaffold> {
  late ConnectivityState connectionStatus;
  @override
  void initState() {
    super.initState();
    addListenReconnectInternet();
  }

  @override
  void dispose() {
    super.dispose();
  }

  addListenReconnectInternet() async {
    eventBus.on<ConnectivityStatusEvent>().listen((event) async {
      MyLogger.d('##reconnect ${event.type}');
      if (event.type == ConnectivityStatusType.connected) {
      } else {
        // handle when no internet
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    TextDirection textDirection =
        context.select((MainAppState app) => app.textDirection);
    AppTheme appTheme = context.select((MainAppState app) => app.theme);
    return Provider.value(
      value: appTheme,
      child: StatsFl(
        isEnabled: false,
        align: Alignment.bottomCenter,
        child: Directionality(
          textDirection: textDirection,
          child: Navigator(
            onPopPage: (Route route, result) {
              if (route.didPop(result)) return true;
              return false;
            },
            pages: [
              MaterialPage(child: Builder(
                builder: (BuildContext builderContext) {
                  commands.setContext(builderContext);
                  return PopOverController(
                    child: _WindowBorder(
                      color: AppColors.transparent,
                      child: widget.useSafeArea
                          ? SafeArea(
                              child: Column(
                                verticalDirection: VerticalDirection.up,
                                children: [
                                  Expanded(child: widget.child),
                                ],
                              ),
                            )
                          : Column(
                              verticalDirection: VerticalDirection.up,
                              children: [
                                Expanded(child: widget.child),
                              ],
                            ),
                    ),
                  );
                },
              ))
            ],
          ),
        ),
      ),
    );
  }
}

class _WindowBorder extends StatelessWidget {
  const _WindowBorder(
      {Key? key, required this.child, this.color = Colors.white})
      : super(key: key);
  final Widget child;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      child,
      IgnorePointer(
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: color.withOpacity(.1), width: 1),
          ),
        ),
      ),
    ]);
  }
}
