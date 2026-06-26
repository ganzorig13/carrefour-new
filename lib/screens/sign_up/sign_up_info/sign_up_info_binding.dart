import 'package:carrefour/screens/screens.dart';
import 'package:get/get.dart';

class SignUpInfoBinding extends Bindings {
  final SignUpModel model;
  SignUpInfoBinding({required this.model});

  @override
  void dependencies() {
    Get.lazyPut(() => SignUpInfoController(model: model));
  }
}
