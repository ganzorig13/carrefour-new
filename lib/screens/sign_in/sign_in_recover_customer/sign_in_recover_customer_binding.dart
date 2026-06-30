import 'package:get/get.dart';

import 'sign_in_recover_customer_controller.dart';

class SignInRecoverCustomerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignInRecoverCustomerController());
  }
}
