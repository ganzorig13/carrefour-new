import 'package:carrefour/screens/screens.dart';
import 'package:get/get.dart';

class NotificationListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NotificationListController());
  }
}
