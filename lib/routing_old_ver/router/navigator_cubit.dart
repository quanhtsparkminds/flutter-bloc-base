import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/routing_old_ver/router/navigator_stack.dart';
import 'package:myapp/routing_old_ver/page_configuration.dart';

///@author Jalal Addin Okbi
class NavigationCubit extends Cubit<NavigationStack> {
  NavigationCubit(List<PageConfiguration> initialPages)
      : super(NavigationStack(initialPages));

  void push(PageConfiguration page) {
    print('push called with $page ');
    PageConfiguration config = page;
    emit(state.push(config));
  }

  void clearAndPush(PageConfiguration page) {
    PageConfiguration config = page;
    emit(state.clearAndPush(config));
  }

  void pop() => emit(state.pop());

  bool canPop() => state.canPop();

  void pushBeneathCurrent(PageConfiguration page) {
    final PageConfiguration config = page;
    emit(state.pushBeneathCurrent(config));
  }
}
