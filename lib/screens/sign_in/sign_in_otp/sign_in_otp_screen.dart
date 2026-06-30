import 'package:carrefour/library/library.dart';
import 'package:carrefour/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInOtpScreen extends GetView<SignInOtpController> {
  const SignInOtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => IOScaffold(
        appBar: IOAppBar(
          titleText: controller.titleText,
        ),
        body: controller.isInitialLoading.value
            ? const IOLoading()
            : SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 24,
                  ),
                  child: Column(
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
                      IOOtpWidget(model: controller.otpField),
                      const SizedBox(height: 16),
                      IOOtpTimerWidget(
                        key: ObjectKey(controller.otpTimer.value),
                        model: controller.otpTimer.value,
                        onTap: controller.onTapGetOtp,
                      ),
                      // const SizedBox(height: 16),
                      // GestureDetector(
                      //   onTap: controller.onTapChangePhone,
                      //   child: Text(
                      //     'Утасны дугаараа солих',
                      //     style: IOStyles.body2Regular.copyWith(
                      //       color: IOColors.brand500,
                      //       decoration: TextDecoration.underline,
                      //     ),
                      //     textAlign: TextAlign.center,
                      //   ),
                      // ),
                      const Spacer(),
                      IOButtonWidget(
                        model: controller.loginButton.value,
                        onPressed: controller.onTapLogin,
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
