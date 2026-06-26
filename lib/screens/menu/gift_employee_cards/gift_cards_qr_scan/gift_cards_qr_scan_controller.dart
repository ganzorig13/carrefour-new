import 'package:carrefour/library/library.dart';
import 'package:carrefour/screens/menu/gift_employee_cards/cards_tab/cards_tab_controller.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class GiftCardsQrScanController extends IOController {
  final titleText = 'Бэлгийн карт нэмэх';

  final qrController = MobileScannerController(
    formats: [BarcodeFormat.qrCode],
  );

  Future onScan(BarcodeCapture capture) async {
    final List<Barcode> barcodes = capture.barcodes;
    final barcode = barcodes.first;

    if (barcode.rawValue != null) {
      await qrController.stop();
      giftCardLink(barcode.rawValue);
    }
  }

  Future giftCardLink(barcode) async {
    isLoading.value = true;
    final response = await CustomerApi().giftCardLink(
      barcodeValue: barcode,
    );
    isLoading.value = false;

    if (response.isSuccess) {
      Get.find<CardsTabController>().getGiftCards();
      Get.until((route) => route.isFirst);
    } else {
      Get.back();
      showError(text: response.msg);
    }
  }

  @override
  void onClose() async {
    super.onClose();
    await qrController.dispose();
  }
}
