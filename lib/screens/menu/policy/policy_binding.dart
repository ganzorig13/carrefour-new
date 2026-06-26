import 'package:carrefour/screens/screens.dart';
import 'package:get/get.dart';

class PolicyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PolicyController());
  }
}
