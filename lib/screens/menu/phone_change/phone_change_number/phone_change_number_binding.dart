import 'package:carrefour/screens/screens.dart';
import 'package:get/get.dart';

class PhoneChangeNumberBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PhoneChangeNumberController());
  }
}
