import 'package:carrefour/screens/screens.dart';
import 'package:get/get.dart';

class EbarimtBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EbarimtController());
  }
}
