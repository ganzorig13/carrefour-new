import 'package:carrefour/screens/screens.dart';
import 'package:get/get.dart';

class PointPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PointPageController());
  }
}
