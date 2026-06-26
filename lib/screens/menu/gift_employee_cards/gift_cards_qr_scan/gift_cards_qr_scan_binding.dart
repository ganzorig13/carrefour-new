import 'package:carrefour/screens/menu/gift_employee_cards/gift_cards_qr_scan/gift_cards_qr_scan_controller.dart';
import 'package:get/get.dart';

class GiftCardsQrScanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GiftCardsQrScanController());
  }
}
