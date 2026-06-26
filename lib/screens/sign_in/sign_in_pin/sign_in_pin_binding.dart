import 'package:carrefour/screens/screens.dart';
import 'package:get/get.dart';

class SignInPinBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignInPinController());
  }
}
