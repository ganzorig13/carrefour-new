import 'package:carrefour/library/library.dart';
import 'package:carrefour/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class EbarimtScreen extends GetView<EbarimtController> {
  const EbarimtScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return IOScaffold(
      appBar: IOAppBar(
        titleText: controller.titleText,
      ),
      bottomNavigationBar: Obx(
        () => AbsorbPointer(
          absorbing: controller.isLoading.value,
          child: IOBottomNavigationBar(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      SizedBox.square(
                        dimension: 16,
                        child: Checkbox(
                          value: controller.isChecked.value,
                          onChanged: controller.isChecked.call,
                          activeColor: IOColors.brand500,
                          side: const BorderSide(
                            width: 1,
                            color: IOColors.brand500,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: controller.isChecked.toggle,
                        child: Text(
                          controller.acceptText,
                          style: IOStyles.body2Medium.copyWith(
                            color: IOColors.brand700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  IOButtonWidget(
                    model: controller.saveButton.value,
                    onPressed: controller.onTapSave,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Obx(
        () => GestureDetector(
          onTap: () => controller.ebarimt.focusNode.unfocus(),
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: AbsorbPointer(
              absorbing: controller.isLoading.value,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                child: Column(
                  children: [
                    const EbarimgCardWidget(),
                    const SizedBox(height: 24),
                    IOTextfieldWidget(
                      model: controller.ebarimt,
                      suffix: SizedBox(
                        width: 56,
                        child: IconButton(
                          onPressed: controller.onTapInfo,
                          icon: SvgPicture.asset(
                            'assets/icons/help.svg',
                            width: 24,
                            height: 24,
                            colorFilter: const ColorFilter.mode(
                              IOColors.brand200,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      controller.infoText,
                      style: IOStyles.body2Regular.copyWith(
                        color: IOColors.brand700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
