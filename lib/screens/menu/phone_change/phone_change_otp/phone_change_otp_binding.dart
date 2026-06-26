import 'package:carrefour/screens/screens.dart';
import 'package:get/get.dart';

class PhoneChangeOtpBinding extends Bindings {
  final String phone;
  PhoneChangeOtpBinding({required this.phone});
  @override
  void dependencies() {
    Get.lazyPut(() => PhoneChangeOtpController(phone: phone));
  }
}
