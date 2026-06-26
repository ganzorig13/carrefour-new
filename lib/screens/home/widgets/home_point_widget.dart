import 'package:carrefour/library/library.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class HomePointWidget extends StatelessWidget {
  final String qrString;
  final double point;
  final VoidCallback onTapQr;
  final VoidCallback onTapScan;

  const HomePointWidget({
    super.key,
    required this.qrString,
    required this.point,
    required this.onTapQr,
    required this.onTapScan,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: IOColors.backgroundPrimary,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: onTapQr,
            child: AspectRatio(
              aspectRatio: 1,
              child: QrImageView(
                data: qrString,
                errorCorrectionLevel: QrErrorCorrectLevel.H,
                padding: EdgeInsets.zero,
                version: QrVersions.auto,
                eyeStyle: const QrEyeStyle(
                  eyeShape: QrEyeShape.square,
                  color: IOColors.brand500,
                ),
                dataModuleStyle: const QrDataModuleStyle(
                  dataModuleShape: QrDataModuleShape.square,
                  color: IOColors.brand500,
                ),
                embeddedImage: const AssetImage(
                  'assets/images/qr.embed.png',
                ),
                embeddedImageStyle: const QrEmbeddedImageStyle(
                  size: Size.square(24),
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Таны оноо',
                  style: IOStyles.body2Bold.copyWith(
                    color: IOColors.brand500,
                  ),
                ),
                Text(
                  point.toCurrency(hasSymbol: false),
                  style: IOStyles.h4.copyWith(
                    color: IOColors.brand500,
                  ),
                ),
                IOButtonWidget(
                  model: IOButtonModel(
                    label: 'Оноо ашиглах',
                    type: IOButtonType.primary,
                    size: IOButtonSize.small,
                  ),
                  onPressed: onTapScan,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
