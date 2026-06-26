import 'package:carrefour/screens/screens.dart';
import 'package:get/get.dart';

class FaqBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FaqController());
  }
}
