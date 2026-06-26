import 'dart:convert';

import 'package:carrefour/library/library.dart';
import 'package:carrefour/screens/screens.dart';
import 'package:g_json/g_json.dart';
import 'package:get/get.dart';

class QrPayController extends IOController {
  final String qrString;
  final payAmount = 0.0.obs;

  QrPayController({required this.qrString});

  final payButton = IOButtonModel(
    label: 'Төлбөр төлөх',
    type: IOButtonType.primary,
    size: IOButtonSize.medium,
    isExpanded: true,
  ).obs;

  bool get hasBiometric => BiometricManager.shared.isAutenticated;
  Map<String, dynamic> get qrData => jsonDecode(qrString);

  @override
  void onInit() {
    super.onInit();
    setAmount();
    setButton();
  }

  void setAmount() {
    final data = JSON(qrData);
    payAmount.value = data['spent_loyalty_points'].ddoubleValue;
  }

  void setButton() {
    if (hasBiometric) {
      payButton.update((val) {
        val?.prefixIcon = 'face.svg';
      });
    }
  }

  void onTapPay() {
    if (hasBiometric) {
      onCheckBiometric();
    } else {
      onPassword();
    }
  }

  Future onPassword() async {
    final pin = await const QrPasswordSheet().show();

    if (pin == null) return;

    payPoint(
      hasBiometric: false,
      password: pin,
    );
  }

  Future onCheckBiometric() async {
    final response = await BiometricManager.shared.checkAuthenticate();
    if (response.success) {
      payPoint(hasBiometric: true, password: HelperManager.user.password);
    } else {
      showError(text: response.errorMessage);
    }
  }

  Future payPoint({
    required bool hasBiometric,
    required String password,
  }) async {
    isLoading.value = true;
    payButton.update((val) {
      val?.isLoading = true;
    });

    final response = await CustomerApi().usePoint(
      qrData: qrData,
      hasBiometric: hasBiometric,
      pin: password,
    );

    isLoading.value = false;
    payButton.update((val) {
      val?.isLoading = false;
    });

    if (response.isSuccess) {
      Get.back();
      if (Get.isRegistered<HomeController>()) {
        Get.find<HomeController>().getPoint();
      }
      showSuccess(text: response.msg);
    } else {
      Get.back();
      showError(text: response.msg);
    }
  }
}
