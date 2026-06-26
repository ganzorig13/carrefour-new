import 'package:carrefour/screens/screens.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';

class CardsTabBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CardsTabController());
    Get.lazyPut(() => GiftCardsController());
  }
}
