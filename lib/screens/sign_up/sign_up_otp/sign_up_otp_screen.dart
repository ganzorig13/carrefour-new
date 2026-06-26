import 'package:carrefour/library/library.dart';
import 'package:carrefour/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpOtpScreen extends GetView<SignUpOtpController> {
  const SignUpOtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => IOScaffold(
        appBar: IOAppBar(
          titleText: controller.titleText,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 24,
            ),
            child: controller.isInitialLoading.value
                ? const IOLoading()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        controller.otpText,
                        textAlign: TextAlign.center,
                        style: IOStyles.body2Regular.copyWith(
                          color: IOColors.brand700,
                        ),
                      ),
                      const SizedBox(height: 16),
                      IOOtpWidget(
                        model: controller.otpField,
                      ),
                      const SizedBox(height: 16),
                      IOOtpTimerWidget(
                        key: ObjectKey(controller.otpTimer.value),
                        model: controller.otpTimer.value,
                        onTap: controller.onTapGetOtp,
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
