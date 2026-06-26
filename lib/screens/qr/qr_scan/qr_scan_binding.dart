import 'package:carrefour/screens/screens.dart';
import 'package:get/get.dart';

class QrScanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => QrScanController());
  }
}
