import 'package:carrefour/screens/screens.dart';
import 'package:get/get.dart';

class SignUpPinBinding extends Bindings {
  final SignUpModel model;
  SignUpPinBinding({required this.model});
  @override
  void dependencies() {
    Get.lazyPut(() => SignUpPinController(model: model));
  }
}
