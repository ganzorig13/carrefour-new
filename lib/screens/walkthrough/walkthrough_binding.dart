import 'package:carrefour/screens/screens.dart';
import 'package:get/get.dart';

class WalkthroughBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WalkthroughController());
  }
}
