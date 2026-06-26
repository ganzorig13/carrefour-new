import 'package:carrefour/library/library.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInMainController extends IOController {
  final phoneField = IOTextfieldModel(
    label: 'Утасны дугаараа оруулна уу',
    placeholder: 'Утасны дугаар',
    validators: [ValidatorType.phone],
    maxLength: 8,
    keyboardType: TextInputType.phone,
  );
  final signInButton = IOButtonModel(
    label: 'Нэвтрэх',
    type: IOButtonType.primary,
    size: IOButtonSize.large,
    isExpanded: true,
    isEnabled: false,
  ).obs;
  final signUpButton = IOButtonModel(
    label: 'Бүртгүүлэх',
    type: IOButtonType.textBrand,
    size: IOButtonSize.large,
  );

  @override
  void onInit() {
    super.onInit();
    phoneField.status.addListener(() {
      signInButton.update((val) {
        val?.isEnabled = phoneField.isValid;
      });
    });
  }

  void onTapSignIn() {
    Get.focusScope?.unfocus();
    AuthRoute.toSignInOtp(phone: phoneField.value);
  }

  void onTapSignUp() {
    AuthRoute.toSignUpPhone();
  }
}
