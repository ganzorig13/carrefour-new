import 'package:carrefour/library/library.dart';
import 'package:carrefour/screens/screens.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class EbarimtController extends IOController {
  final titleText = 'E barimt - холбох';
  final infoText =
      'И-баримтын аппликейшны нэвтрэх нэрээ оруулаад автоматаар баримтаа бүртгүүлээрэй.';
  final acceptText = 'Баримт биетээр хэвлэнэ';

  final isChecked = false.obs;
  final ebarimt = IOTextfieldModel(
    label: 'Иргэний 8-12 оронтой кодоо оруулаарай',
    placeholder: '12345678',
    minLength: 8,
    maxLength: 12,
    keyboardType: TextInputType.number,
    inputFormatters: [
      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
    ],
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
      val?.isEnabled =
          (ebarimt.value.length >= 8 && ebarimt.value.length <= 12) ||
              ebarimt.value.isEmpty;
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
