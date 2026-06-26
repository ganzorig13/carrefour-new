import 'package:carrefour/screens/screens.dart';
import 'package:get/get.dart';

class PinResetNewBinding extends Bindings {
  final String phone;
  final String token;

  PinResetNewBinding({
    required this.phone,
    required this.token,
  });

  @override
  void dependencies() {
    Get.lazyPut(
      () => PinResetNewController(phone: phone, token: token),
    );
  }
}
