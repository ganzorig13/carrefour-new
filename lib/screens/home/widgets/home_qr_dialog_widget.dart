import 'package:carrefour/library/library.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class HomeQrDialogWidget extends StatelessWidget {
  const HomeQrDialogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      insetPadding: const EdgeInsets.all(50),
      backgroundColor: IOColors.backgroundPrimary,
      child: AspectRatio(
        aspectRatio: 1,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: QrImageView(
            data: HelperManager.user.barcode,
            errorCorrectionLevel: QrErrorCorrectLevel.H,
            padding: EdgeInsets.zero,
            gapless: false,
            eyeStyle: const QrEyeStyle(
              eyeShape: QrEyeShape.square,
              color: IOColors.brand500,
            ),
            dataModuleStyle: const QrDataModuleStyle(
              dataModuleShape: QrDataModuleShape.square,
              color: IOColors.brand500,
            ),
            // embeddedImage: const AssetImage(
            //   'assets/images/qr.embed.png',
            // ),
            // embeddedImageStyle: const QrEmbeddedImageStyle(
            //   size: Size.square(44),
            // ),
          ),
        ),
      ),
    );
  }
}
