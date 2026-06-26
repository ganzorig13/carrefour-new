import 'package:carrefour/library/library.dart';
import 'package:get/get.dart';

class QrPasswordController extends IOController {
  final pinfield = IOOtpModel(
    length: 4,
    isSecure: true,
    isAutoFocus: true,
  );

  @override
  void onInit() {
    super.onInit();
    pinfield.controller.addListener(checkValidation);
  }

  void checkValidation() {
    if (pinfield.isValid) {
      Get.back(result: pinfield.value);
    }
  }
}
