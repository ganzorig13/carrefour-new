import 'package:carrefour/library/library.dart';
import 'package:carrefour/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpPhoneScreen extends GetView<SignUpPhoneController> {
  const SignUpPhoneScreen({super.key});

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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                IOTextfieldWidget(
                  model: controller.phoneField,
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
