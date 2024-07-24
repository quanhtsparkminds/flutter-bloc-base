import 'package:flutter/material.dart';
import 'package:myapp/commands/set_localauth_command.dart';
import 'package:myapp/gen/assets.gen.dart';
import 'package:myapp/shared/utils/screen_size.dart';

class FlashScreens extends StatefulWidget {
  const FlashScreens({super.key});

  @override
  State<FlashScreens> createState() => _FlashState();
}

class _FlashState extends State<FlashScreens> {
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  Future<void> startTimer() async {
    return Future.delayed(const Duration(milliseconds: 2000), () async {
      await LocalAuthCommand().loadBiometric();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
              child: Assets.images.splashScreen
                  .image(width: Screens.getWidth(context), fit: BoxFit.cover)),
        ],
      ),
    );
  }
}
