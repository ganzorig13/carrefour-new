import 'package:carrefour/library/library.dart';
import 'package:carrefour/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EbarimtController extends IOController {
  final titleText = 'E barimt - холбох';
  final infoText =
      'И-баримтын аппликейшны нэвтрэх нэрээ оруулаад автоматаар баримтаа бүртгүүлээрэй.';
  final acceptText = 'Баримт биетээр хэвлэнэ';

  final isChecked = false.obs;
  final ebarimt = IOTextfieldModel(
    label: 'Иргэний 8 оронтой кодоо оруулаарай',
    placeholder: '12345678',
    maxLength: 8,
    keyboardType: TextInputType.number,
  );

  final saveButton = IOButtonModel(
    label: 'Хадгалах',
    type: IOButtonType.primary,
    size: IOButtonSize.medium,
    isEnabled: false,
  ).obs;

  @override
  void onInit() {
    super.onInit();
    ebarimt.controller.text = HelperManager.user.ebarimtNumber;
    isChecked.value = HelperManager.user.isPrintBarimt;
    checkValidation();
    ebarimt.controller.addListener(checkValidation);
  }

  void checkValidation() {
    saveButton.update((val) {
      val?.isEnabled = ebarimt.value.length == 8;
    });
  }

  void onTapInfo() {
    Get.focusScope?.unfocus();
    const EbarimtInfoDialog().show();
  }

  Future onTapSave() async {
    Get.focusScope?.unfocus();
    isLoading.value = true;
    saveButton.update((val) {
      val?.isLoading = true;
    });
    final response = await CustomerApi().addEbarimt(
      number: ebarimt.value,
      isPrint: isChecked.value,
    );
    isLoading.value = false;
    saveButton.update((val) {
      val?.isLoading = false;
    });

    if (response.isSuccess) {
      Get.back();
      ClientManager.getUserInfo();
      if (Get.isRegistered<HomeController>()) {
        Get.find<HomeController>().getPoint();
      }
      if (Get.isRegistered<PromoPageController>()) {
        Get.find<PromoPageController>().refreshNotifier.notify();
      }
    } else {
      showError(text: response.msg);
    }
  }
}
