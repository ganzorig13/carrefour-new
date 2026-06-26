import 'package:carrefour/screens/screens.dart';
import 'package:get/get.dart';

class SignUpTermsBinding extends Bindings {
  final SignUpModel model;
  SignUpTermsBinding({required this.model});

  @override
  void dependencies() {
    Get.lazyPut(() => SignUpTermsController(model: model));
  }
}
