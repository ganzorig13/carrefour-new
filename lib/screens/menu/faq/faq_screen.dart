import 'package:carrefour/library/library.dart';
import 'package:carrefour/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FaqScreen extends GetView<FaqController> {
  const FaqScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return IOScaffold(
      appBar: IOAppBar(
        titleText: 'Түгээмэл асуулт хариулт',
      ),
      body: Obx(
        () => controller.isInitialLoading.value
            ? const IOLoading()
            : controller.items.isEmpty
                ? const IOEmptyWidget(
                    icon: 'question.svg',
                  )
                : ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemBuilder: (context, index) {
                      final item = controller.items[index];
                      return Container(
                        decoration: BoxDecoration(
                          color: IOColors.backgroundPrimary,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: IOShadow.black8,
                        ),
                        child: ExpansionTile(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          collapsedShape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          collapsedIconColor: IOColors.brand600,
                          iconColor: IOColors.brand600,
                          childrenPadding: const EdgeInsets.only(
                            left: 16,
                            right: 16,
                            bottom: 12,
                          ),
                          title: Text(
                            item.question,
                            style: IOStyles.caption1Bold.copyWith(
                              color: IOColors.brand700,
                            ),
                          ),
                          children: [
                            Text(
                              item.answer,
                              textAlign: TextAlign.justify,
                              style: IOStyles.body2Regular.copyWith(
                                color: IOColors.brand500,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 16);
                    },
                    itemCount: controller.items.length,
                  ),
      ),
    );
  }
}
