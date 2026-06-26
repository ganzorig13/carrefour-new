import 'package:carrefour/library/library.dart';
import 'package:carrefour/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpPhoneController extends IOController {
  final titleText = 'Бүртгүүлэх';
  final phoneField = IOTextfieldModel(
    label: 'Утасны дугаараа оруулна уу',
    placeholder: 'Утасны дугаар',
    validators: [ValidatorType.phone],
    keyboardType: TextInputType.phone,
    maxLength: 8,
  );
  final nextButton = IOButtonModel(
    label: 'Үргэлжлүүлэх',
    type: IOButtonType.primary,
    size: IOButtonSize.medium,
    isEnabled: false,
  ).obs;

  final model = SignUpModel();

  @override
  void onInit() {
    super.onInit();
    phoneField.status.addListener(checkValidation);
  }

  void checkValidation() {
    nextButton.update((val) {
      val?.isEnabled = phoneField.isValid;
    });
  }

  void onTapNext() {
    Get.focusScope?.unfocus();
    model.phone = phoneField.value;
    AuthRoute.toSignUpOtp(model);
  }
}
