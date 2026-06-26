import 'package:carrefour/library/library.dart';
import 'package:carrefour/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PromoSurveyScreen extends GetView<PromoSurveyController> {
  const PromoSurveyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => IOScaffold(
        appBar: IOAppBar(
          titleText: controller.titleText,
        ),
        body: controller.isInitialLoading.value
            ? const IOLoading()
            : AbsorbPointer(
                absorbing: controller.isLoading.value,
                child: ListView.separated(
                  padding: const EdgeInsets.all(24),
                  itemCount: controller.question.value.questions.length,
                  itemBuilder: (context, index) {
                    final item = controller.question.value.questions[index];
                    return PromoSurveyQuestionWidget(
                      index: index,
                      question: item,
                      onTapAnswer: controller.onTapAnswer,
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider(
                      height: 64,
                      thickness: 1,
                      color: IOColors.strokePrimary,
                    );
                  },
                ),
              ),
        bottomNavigationBar: IOBottomNavigationBar(
          child: IOButtonWidget(
            model: controller.submitButton.value,
            onPressed: controller.onTapSubmit,
          ),
        ),
      ),
    );
  }
}
