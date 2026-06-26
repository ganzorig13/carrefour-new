import 'package:carrefour/library/library.dart';
import 'package:carrefour/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpInfoScreen extends GetView<SignUpInfoController> {
  const SignUpInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return IOScaffold(
      appBar: IOAppBar(
        titleText: controller.titleText,
      ),
      body: Obx(
        () => SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 24,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                IOTextfieldWidget(
                  model: controller.surname,
                ),
                const SizedBox(height: 16),
                IOTextfieldWidget(
                  model: controller.name,
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
