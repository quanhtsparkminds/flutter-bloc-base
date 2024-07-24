import 'package:get/get.dart';
import 'package:myapp/routing_old_ver/page_configuration.dart';
import 'package:myapp/shared/utils/my_logger.dart';

class NavigationStack {
  final List<PageConfiguration> _stack;

  NavigationStack(this._stack);

  List<PageConfiguration> get pages =>
      List.unmodifiable(_stack.map((e) => e.uiPage));

  List<PageConfiguration> get configs => _stack;
  int get length => _stack.length;
  PageConfiguration get firstPage => _stack.first;
  PageConfiguration get lastPage => _stack.last;

  ///the reason behind returning Navigation Stack instead of just being a void
  ///is to chain calls as we'll see in navigation_cubit.dart
  //not to go into how a cubit defines a state to be new with lists, I've just returned a new instance

  void clear() => _stack.removeRange(0, _stack.length - 2);

  bool canPop() => _stack.length > 1;

  NavigationStack pop() {
    if (canPop()) _stack.remove(_stack.last);
    return NavigationStack(_stack);
  }

  NavigationStack pushBeneathCurrent(PageConfiguration config) {
    if (_stack.last.key != config.key) _stack.insert(_stack.length, config);
    return NavigationStack(_stack);
  }

  NavigationStack push(PageConfiguration config) {
    if (_stack.last.key != config.key) {
      _stack.addIf(_stack.last.key != config.key, config);
    }
    MyLogger.d('navigation stack -- ${NavigationStack(_stack)._stack}');
    return NavigationStack(_stack);
  }

  NavigationStack replace(PageConfiguration config) {
    if (canPop()) {
      _stack.removeLast();
      push(config);
    } else {
      _stack.insert(0, config);
      _stack.removeLast();
    }
    return NavigationStack(_stack);
  }

  NavigationStack clearAndPush(PageConfiguration config) {
    _stack.clear();
    _stack.add(config);
    return NavigationStack(_stack);
  }

  NavigationStack clearAndPushAll(List<PageConfiguration> configs) {
    _stack.clear();
    _stack.addAll(configs);
    return NavigationStack(_stack);
  }
}
