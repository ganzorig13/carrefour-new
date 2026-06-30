import 'package:carrefour/library/library.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'sign_in_recover_customer_controller.dart';

class SignInRecoverCustomerScreen
    extends GetView<SignInRecoverCustomerController> {
  const SignInRecoverCustomerScreen({super.key});

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
                      if (!controller.showValidateStep.value) ...[
                        IOTextfieldWidget(
                          key: const ValueKey('recover_email'),
                          model: controller.emailField,
                        ),
                        const SizedBox(height: 16),
                        IOTextfieldWidget(
                          key: const ValueKey('recover_phone'),
                          model: controller.newPhoneField,
                        ),
                        const SizedBox(height: 24),
                        IOButtonWidget(
                          model: controller.requestButton.value,
                          onPressed: controller.onTapRequestRecover,
                        ),
                      ] else ...[
                        IOTextfieldWidget(
                          key: const ValueKey('recover_msg_code'),
                          model: controller.msgCodeField,
                        ),
                        const SizedBox(height: 16),
                        IOTextfieldWidget(
                          key: const ValueKey('recover_email_code'),
                          model: controller.emailCodeField,
                        ),
                        const SizedBox(height: 24),
                        IOButtonWidget(
                          model: controller.validateButton.value,
                          onPressed: controller.onTapValidate,
                        ),
                      ],
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
