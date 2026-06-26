import 'package:carrefour/library/library.dart';
import 'package:get/get.dart';

class PinChangeNewController extends IOController {
  final String oldPin;

  PinChangeNewController({required this.oldPin});

  final titleText = 'Гүйлгээний нууц үг солих';
  final otpText = 'Та солих гүйлгээний нууц үгээ оруулна уу';
  final otpConfirmText = 'Гүйлгээний нууц үгээ давтан оруулна уу';
  final otpField = IOOtpModel(length: 4, isSecure: true);
  final otpConfirmField = IOOtpModel(length: 4, isSecure: true);

  final nextButton = IOButtonModel(
    label: 'Хадгалах',
    type: IOButtonType.primary,
    size: IOButtonSize.medium,
    isEnabled: false,
  ).obs;

  @override
  void onInit() {
    super.onInit();

    otpField.controller.addListener(checkValidation);
    otpConfirmField.controller.addListener(checkValidation);
  }

  void checkValidation() {
    nextButton.update((val) {
      val?.isEnabled = otpField.isValid && otpConfirmField.isValid;
    });
  }

  void onTapNext() {
    Get.focusScope?.unfocus();
    if (otpField.value != otpConfirmField.value) {
      showError(text: 'Давтсан нууц үг таарахгүй байна');
      return;
    }
    changePin();
  }

  Future changePin() async {
    isLoading.value = true;
    nextButton.update((val) {
      val?.isLoading = true;
    });

    final response = await CustomerApi().changePin(
      oldPin: oldPin,
      newPin: otpField.value,
    );

    isLoading.value = false;
    nextButton.update((val) {
      val?.isLoading = false;
    });

    if (response.isSuccess) {
      Get.until((route) => route.isFirst);
      showSuccess(
        text: 'Таны гүйлгээний нууц үг амжилттай солигдлоо.',
      );
    } else {
      showError(text: response.msg);
    }
  }
}
