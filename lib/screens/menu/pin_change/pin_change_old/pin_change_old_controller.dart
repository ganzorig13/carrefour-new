import 'package:carrefour/library/library.dart';
import 'package:get/get.dart';

class PinChangeOldController extends IOController {
  final titleText = 'Гүйлгээний нууц үг солих';
  final otpText = 'Та одоогийн гүйлгээний нууц үгээ оруулна уу';
  final otpField = IOOtpModel(length: 4, isSecure: true);

  final resetButton = IOButtonModel(
    label: 'Нууц үг мартсан?',
    type: IOButtonType.textBrand,
    size: IOButtonSize.small,
  );

  final nextButton = IOButtonModel(
    label: 'Үргэлжлүүлэх',
    type: IOButtonType.primary,
    size: IOButtonSize.medium,
    isEnabled: false,
  ).obs;

  @override
  void onInit() {
    super.onInit();
    otpField.controller.addListener(checkValidation);
  }

  void checkValidation() {
    nextButton.update((val) {
      val?.isEnabled = otpField.isValid;
    });
  }

  void onTapReset() {
    MenuRoute.toPinResetOtp();
  }

  void onTapNext() {
    Get.focusScope?.unfocus();
    MenuRoute.toPinChangeNew(otpField.value);
  }
}
