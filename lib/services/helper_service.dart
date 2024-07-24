import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myapp/commands/core/app_style.dart';
import 'package:myapp/shared/translations/translation_key.dart';
import 'package:myapp/shared/widgets/app_button/app_button.dart';
import 'package:myapp/shared/widgets/app_button/app_button.types.dart';
import 'package:myapp/shared/widgets/app_sized_box/app_sized_box.dart';
import 'package:myapp/shared/widgets/dialog_custom.dart';
import 'package:permission_handler/permission_handler.dart';

class HelperService {
  HelperService._();

  static final ImagePicker _picker = ImagePicker();
  static ImagePicker get picker => _picker;

  Future<XFile?> pickImageFromGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    return image;
  }

  Future<XFile?> pickImageFromCamera() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    return image;
  }

  static Future catchPermisionImage(BuildContext context) async {
    var status = await Permission.camera.status;
    if (status.isDenied) {
      if (!context.mounted) {
        return;
      }
      showMessageDialog(
        context,
        title: TranslationKeys.titleBiometricSetting
            .trParams({'biometric': 'photo'}),
        message: TranslationKeys.contentBiometricSetting
            .trParams({'biometric': 'your gallery'}),
        buttons: [
          // TextButton(
          //     onPressed: () => Get.back(),
          //     child: AppText(
          //       TranslationKeys.biometricPopupButton2.tr,
          //       variant: AppTextVariant.button,
          //       style: TextStyle(color: AppColor.navyBlue),
          //     )),
          // TextButton(
          //     onPressed: () {
          //       openAppSettings();
          //       Get.back();
          //     },
          //     child: AppText(
          //       TranslationKeys.settings.tr,
          //       variant: AppTextVariant.button,
          //       style: TextStyle(color: AppColor.navyBlue),
          //     ))
          Expanded(
            child: AppButton(
                title: TranslationKeys.cancel.tr,
                style: ButtonStyles.buttonPopupStyle,
                variant: AppButtonVariant.primaryAmber,
                onPressed: () {
                  return Navigator.of(context, rootNavigator: true).pop(false);
                }),
          ),
          AppSizedBox.square10,
          Expanded(
            child: AppButton(
                title: TranslationKeys.settings.tr,
                style: ButtonStyles.buttonPopupStyle,
                onPressed: () {
                  openAppSettings();
                  return Navigator.of(context, rootNavigator: true).pop(true);
                }),
          ),
        ],
      );
    }
  }
}
