import 'package:carrefour/screens/screens.dart';
import 'package:get/get.dart';

class SignUpPhoneBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignUpPhoneController());
  }
}
