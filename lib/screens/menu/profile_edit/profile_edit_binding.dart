import 'package:carrefour/screens/menu/profile_edit/profile_edit_controller.dart';
import 'package:get/get.dart';

class ProfileEditBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProfileEditController());
  }
}
