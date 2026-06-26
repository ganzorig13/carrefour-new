import 'package:carrefour/screens/screens.dart';
import 'package:get/get.dart';

class FinanceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FinanceController());
  }
}
