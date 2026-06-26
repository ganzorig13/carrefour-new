import 'package:carrefour/screens/screens.dart';
import 'package:get/get.dart';

class TermsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TermsController());
  }
}
