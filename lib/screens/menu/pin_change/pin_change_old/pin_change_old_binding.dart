import 'package:carrefour/screens/screens.dart';
import 'package:get/get.dart';

class PinChangeOldBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PinChangeOldController());
  }
}
