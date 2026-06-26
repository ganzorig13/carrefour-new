import 'package:carrefour/library/library.dart';
import 'package:carrefour/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

class PromoQrSheet extends StatelessWidget {
  final PromoRewardModel model;
  const PromoQrSheet({super.key, required this.model});

  Future show() {
    return Get.bottomSheet(this, isScrollControlled: true);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: IOColors.backgroundPrimary,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: IOColors.textQuarternary,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
            const SizedBox(height: 40),
            Container(
              width: 192,
              height: 192,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  width: 2,
                  color: IOColors.brand100,
                ),
              ),
              child: QrImageView(
                data: model.rewardQrRepaced,
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
              ),
            ),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                'Бэлэг авах эрхтэй байна.',
                textAlign: TextAlign.center,
                style: IOStyles.h6.copyWith(
                  color: IOColors.brand700,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                'QR-г касс дээр уншуулаад бэлгээ аваарай.',
                textAlign: TextAlign.center,
                style: IOStyles.body1Regular.copyWith(
                  color: IOColors.brand700,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 16,
              ),
              child: IOButtonWidget(
                model: IOButtonModel(
                  label: 'Хаах',
                  type: IOButtonType.primary,
                  size: IOButtonSize.medium,
                  isExpanded: true,
                ),
                onPressed: Get.back,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
