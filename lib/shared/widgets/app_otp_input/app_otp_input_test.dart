// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:myapp/shared/widgets/app_otp_input/app_otp_input.dart';

void main() {
  TextEditingController otpInputController = TextEditingController();
  List<String> log = [];

  testWidgets('Testing otp input', (WidgetTester tester) async {
    await tester.runAsync(() async {
      await tester.pumpWidget(GetMaterialApp(
        home: Scaffold(
          body: Center(
            child: AppOtpInput(
              controller: otpInputController,
              onFullfilled: (otp) {
                log.add(otp);
              },
            ),
          ),
        ),
      ));

      Finder otpInput = find.byType(AppOtpInput);
      expect(otpInput, findsOneWidget);
      await tester.enterText(otpInput, '1234');
      await tester.pump();
      expect(log[0], '1234');
      expect(otpInputController.text, '1234');

      otpInputController.clear();
      await tester.pump();
      expect(log.length, 1);
      expect(otpInputController.text, '');
    });
  });
}
