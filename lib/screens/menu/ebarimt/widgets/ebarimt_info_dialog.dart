import 'package:carrefour/library/library.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EbarimtInfoDialog extends StatelessWidget {
  const EbarimtInfoDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: IOColors.backgroundSecondary,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              'assets/images/ebarimt.png',
            ),
            const SizedBox(height: 12),
            Text(
              'Та өөрийн бүртгэлтэй И-баримт апп-ын бусад цэсийг дарж код оо харах боломжтой.',
              style: IOStyles.body1Regular.copyWith(
                color: IOColors.brand700,
              ),
            ),
            const SizedBox(height: 32),
            IOButtonWidget(
              model: IOButtonModel(
                label: 'Хаах',
                type: IOButtonType.primary,
                size: IOButtonSize.medium,
              ),
              onPressed: Get.back,
            )
          ],
        ),
      ),
    );
  }

  void show() {
    Get.dialog(this);
  }
}
