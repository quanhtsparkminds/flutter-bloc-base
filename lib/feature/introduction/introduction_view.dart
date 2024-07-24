import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:myapp/feature/introduction/introduction_cubit/introduction_cubit.dart';
import 'package:myapp/feature/introduction/widgets/dot_indicator_widget.dart';
import 'package:myapp/feature/introduction/widgets/page_view_widget.dart';
import 'package:myapp/gen/assets.gen.dart';
import 'package:myapp/shared/translations/translation_key.dart';
import 'package:myapp/shared/utils/screen_size.dart';

class IntroductionView extends StatefulWidget {
  const IntroductionView({super.key});

  @override
  State<IntroductionView> createState() => _IntroductionViewState();
}

class _IntroductionViewState extends State<IntroductionView> {
  late IntroductionCubit _bloc;
  @override
  void initState() {
    super.initState();
    _bloc = context.read();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IntroductionCubit, IntroductionState>(
        builder: (context, state) {
      return Stack(
        children: [
          PageView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            controller: _bloc.pageController,
            onPageChanged: _bloc.onPageChanged,
            itemCount: 3,
            itemBuilder: (context, index) {
              switch (index) {
                case 0:
                  return _buildStep1(currentPage: index);
                case 1:
                  return _buildStep2(currentPage: index);
                case 2:
                  return _buildStep3(currentPage: index);
                default:
                  return const Offstage();
              }
            },
          ),
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (index) {
                bool isActive = _bloc.currentPage == index;
                return dotIndicator(isActive: isActive);
              }),
            ),
          )
        ],
      );
    });
  }

  Widget _buildStep1({required int currentPage}) {
    return PageViewWidget(
        image: Assets.images.unsplashIntro1.image(
            width: double.infinity,
            height: Screens.getHeight(context) / 1.5,
            fit: BoxFit.cover),
        title: TranslationKeys.welcome1.tr,
        currentPage: currentPage,
        subTitle: TranslationKeys.introWelcome1.tr,
        onPressed: () => _bloc.handleNextPressed());
  }

  Widget _buildStep2({required int currentPage}) {
    return PageViewWidget(
        image: Assets.images.unsplashIntro2.image(
            width: double.infinity,
            height: Screens.getHeight(context) / 1.5,
            fit: BoxFit.cover),
        title: TranslationKeys.welcome2.tr,
        currentPage: currentPage,
        subTitle: TranslationKeys.introWelcome2.tr,
        onPressed: () => _bloc.handleNextPressed());
  }

  Widget _buildStep3({required int currentPage}) {
    return PageViewWidget(
        image: Assets.images.unsplashIntro3.image(
            width: double.infinity,
            height: Screens.getHeight(context) / 1.5,
            fit: BoxFit.cover),
        title: TranslationKeys.welcome3.tr,
        currentPage: currentPage,
        subTitle: TranslationKeys.introWelcome3.tr,
        onPressed: () => _bloc.handleToMainAuuth(context));
  }
}
