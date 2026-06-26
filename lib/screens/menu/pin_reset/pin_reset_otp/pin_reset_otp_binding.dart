import 'package:carrefour/screens/screens.dart';
import 'package:get/get.dart';

class PinResetOtpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PinResetOtpController());
  }
}
