import 'dart:async';

import 'package:carrefour/library/library.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrScanController extends IOController {
  final titleText = 'Оноо зарцуулах';
  final qrController = MobileScannerController(
    formats: [BarcodeFormat.qrCode],
  );

  Future onScan(BarcodeCapture capture) async {
    final List<Barcode> barcodes = capture.barcodes;
    final barcode = barcodes.first;

    if (barcode.rawValue != null) {
      // setResult(barcode.rawValue);
      await qrController.stop();
      Get.back(result: barcode.rawValue);
    }
  }

  @override
  void onClose() async {
    super.onClose();
    await qrController.dispose();
  }
}
