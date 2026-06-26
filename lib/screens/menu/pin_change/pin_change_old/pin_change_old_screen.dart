import 'package:carrefour/library/library.dart';
import 'package:carrefour/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PinChangeOldScreen extends GetView<PinChangeOldController> {
  const PinChangeOldScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return IOScaffold(
      appBar: IOAppBar(
        titleText: controller.titleText,
      ),
      body: Obx(
        () => SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  controller.otpText,
                  style: IOStyles.body2Regular.copyWith(
                    color: IOColors.brand700,
                  ),
                ),
                const SizedBox(height: 16),
                IOOtpWidget(model: controller.otpField),
                const SizedBox(height: 16),
                IOButtonWidget(
                  model: controller.resetButton,
                  onPressed: controller.onTapReset,
                ),
                const Spacer(),
                IOButtonWidget(
                  model: controller.nextButton.value,
                  onPressed: controller.onTapNext,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
