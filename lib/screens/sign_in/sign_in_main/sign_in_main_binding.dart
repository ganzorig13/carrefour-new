import 'package:carrefour/screens/screens.dart';
import 'package:get/get.dart';

class SignInMainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignInMainController());
  }
}
