import 'package:carrefour/library/library.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PhoneChangeNumberController extends IOController {
  final titleText = 'Дугаар солих';

  final currentField = IOTextfieldModel(
    label: 'Одоогийн дугаар',
    placeholder: 'Утасны дугаар',
    validators: [ValidatorType.phone],
    maxLength: 8,
    keyboardType: TextInputType.phone,
    isEnabled: false,
  );

  final phoneField = IOTextfieldModel(
    label: 'Солих дугаараа оруулна уу',
    placeholder: 'Утасны дугаар',
    validators: [ValidatorType.phone],
    maxLength: 8,
    keyboardType: TextInputType.phone,
  );

  final nextButton = IOButtonModel(
    label: 'Үргэлжлүүлэх',
    type: IOButtonType.primary,
    size: IOButtonSize.large,
    isEnabled: false,
  ).obs;

  @override
  void onInit() {
    super.onInit();
    currentField.controller.text = HelperManager.user.phone;
    phoneField.status.addListener(() {
      nextButton.update((val) {
        val?.isEnabled = phoneField.isValid;
      });
    });
  }

  void onTapNext() {
    Get.focusScope?.unfocus();
    MenuRoute.toPhoneChangeOtp(phone: phoneField.value);
  }
}
