import 'package:carrefour/library/components/main/io_appbar.dart';
import 'package:carrefour/library/components/main/io_scaffold.dart';
import 'package:carrefour/library/theme/io_colors.dart';
import 'package:carrefour/library/theme/io_styles.dart';
import 'package:carrefour/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class GiftCardsQrScanScreen extends GetView<GiftCardsQrScanController> {
  const GiftCardsQrScanScreen({super.key});

  Widget _buildScanWindow(Rect scanWindowRect) {
    return ValueListenableBuilder(
      valueListenable: controller.qrController,
      builder: (context, value, child) {
        if (!value.isInitialized ||
            !value.isRunning ||
            value.error != null ||
            value.size.isEmpty) {
          return const SizedBox();
        }

        return CustomPaint(
          painter: ScannerOverlay(scanWindowRect),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final scanWindow = Rect.fromCenter(
      center: MediaQuery.sizeOf(context).center(
        const Offset(0, -80),
      ),
      width: 250,
      height: 250,
    );

    return IOScaffold(
      appBar: IOAppBar(
        titleText: controller.titleText,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          MobileScanner(
            fit: BoxFit.cover,
            scanWindow: scanWindow,
            controller: controller.qrController,
            onDetect: controller.onScan,
            errorBuilder: (context, error) {
              return ScannerErrorWidget(error: error);
            },
          ),
          _buildScanWindow(scanWindow),
          Align(
            alignment: const Alignment(0, -0.7),
            child: Text(
              'QR-аа уншуулна уу',
              textAlign: TextAlign.center,
              style: IOStyles.body1Bold.copyWith(
                color: IOColors.backgroundPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
