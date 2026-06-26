import 'package:carrefour/library/library.dart';
import 'package:carrefour/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpPinScreen extends GetView<SignUpPinController> {
  const SignUpPinScreen({super.key});

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
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 24,
              ),
              child: Column(
                children: [
                  Text(
                    controller.pinText,
                    style: IOStyles.body2Regular.copyWith(
                      color: IOColors.brand700,
                    ),
                  ),
                  const SizedBox(height: 16),
                  IOOtpWidget(model: controller.pinField),
                  const SizedBox(height: 36),
                  Text(
                    controller.confirm,
                    style: IOStyles.body2Regular.copyWith(
                      color: IOColors.brand700,
                    ),
                  ),
                  const SizedBox(height: 16),
                  IOOtpWidget(model: controller.confirmField),
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
