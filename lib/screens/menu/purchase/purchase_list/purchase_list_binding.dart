import 'package:carrefour/screens/screens.dart';
import 'package:get/get.dart';

class PurchaseListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PurchaseListController());
  }
}
