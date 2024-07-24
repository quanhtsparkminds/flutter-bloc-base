import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myapp/commands/navigate_to_command.dart';
import 'package:myapp/constants/constants.dart';
import 'package:myapp/go_router/routes.types.dart';

part 'introduction_state.dart';
part 'introduction_cubit.freezed.dart';

class IntroductionCubit extends Cubit<IntroductionState> {
  IntroductionCubit() : super(const IntroductionState.initial());
  final int totalStep = 4;
  int _currentPage = 0;
  late PageController pageController;

  initState() {
    pageController = PageController(initialPage: _currentPage);
  }

  void handleNextPressed() {
    if (_currentPage < 4) {
      _currentPage++;
      pageController.nextPage(
          duration: Constants.animationDuration, curve: Curves.ease);
      emit(IntroductionState.setPage(_currentPage));
    }
  }

  void onPageChanged(int index) {
    _currentPage = index;
    emit(IntroductionState.setPage(_currentPage));
  }

  void handleBackPressed() {
    if (_currentPage > 0) {
      _currentPage--;
      pageController.previousPage(
          duration: Constants.animationDuration, curve: Curves.ease);
      emit(IntroductionState.setPage(_currentPage));
    }
  }

  void handleToMainAuuth(BuildContext context) {
    // NavigateToCommand().run(AuthenticatePageConfiguration());
    NavigateToCommand().run(AppRoutes.authenticate.name);
  }

  int get currentPage => _currentPage;
}
