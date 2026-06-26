import 'package:carrefour/screens/screens.dart';
import 'package:get/get.dart';

class PinChangeNewBinding extends Bindings {
  final String oldPin;
  PinChangeNewBinding({required this.oldPin});
  @override
  void dependencies() {
    Get.lazyPut(() => PinChangeNewController(oldPin: oldPin));
  }
}
