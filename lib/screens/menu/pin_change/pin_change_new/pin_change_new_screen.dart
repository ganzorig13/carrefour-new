import 'package:carrefour/library/library.dart';
import 'package:carrefour/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PinChangeNewScreen extends GetView<PinChangeNewController> {
  const PinChangeNewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return IOScaffold(
      appBar: IOAppBar(
        titleText: controller.titleText,
      ),
      body: Obx(
        () => AbsorbPointer(
          absorbing: controller.isLoading.value,
          child: SafeArea(
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
                  const SizedBox(height: 24),
                  Text(
                    controller.otpConfirmText,
                    style: IOStyles.body2Regular.copyWith(
                      color: IOColors.brand700,
                    ),
                  ),
                  const SizedBox(height: 16),
                  IOOtpWidget(model: controller.otpConfirmField),
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
      ),
    );
  }
}
