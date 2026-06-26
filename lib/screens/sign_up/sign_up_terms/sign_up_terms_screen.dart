import 'package:carrefour/library/library.dart';
import 'package:carrefour/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';

class SignUpTermsScreen extends GetView<SignUpTermsController> {
  const SignUpTermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return IOScaffold(
      appBar: IOAppBar(
        titleText: controller.titleText,
      ),
      body: Obx(
        () => controller.isInitialLoading.value
            ? const IOLoading()
            : CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.all(24),
                    sliver: SliverToBoxAdapter(
                      child: HtmlWidget(
                        controller.terms.value.description,
                        textStyle: IOStyles.body2Regular,
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: EdgeInsets.only(
                      left: 24,
                      right: 24,
                      bottom: 24 + Get.mediaQuery.padding.bottom,
                    ),
                    sliver: SliverToBoxAdapter(
                      child: Column(
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
                            model: controller.nextButton.value,
                            onPressed: controller.onTapNext,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
