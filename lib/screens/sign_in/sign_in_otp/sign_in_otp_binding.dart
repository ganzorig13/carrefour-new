import 'package:carrefour/screens/screens.dart';
import 'package:get/get.dart';

class SignInOtpBinding extends Bindings {
  final String phone;
  SignInOtpBinding({required this.phone});
  @override
  void dependencies() {
    Get.lazyPut(() => SignInOtpController(phone: phone));
  }
}
