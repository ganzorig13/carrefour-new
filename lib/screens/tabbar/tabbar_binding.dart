import 'package:carrefour/screens/screens.dart';
import 'package:get/get.dart';

class TabBarBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(TabBarController());
  }
}
