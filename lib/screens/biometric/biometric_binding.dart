import 'package:carrefour/screens/screens.dart';
import 'package:get/get.dart';

class BiometricBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BiometricController());
  }
}
