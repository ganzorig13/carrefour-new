import 'package:carrefour/screens/screens.dart';
import 'package:get/get.dart';

class SignUpOtpBinding extends Bindings {
  final SignUpModel model;
  SignUpOtpBinding({required this.model});
  @override
  void dependencies() {
    Get.lazyPut(() => SignUpOtpController(model: model));
  }
}
