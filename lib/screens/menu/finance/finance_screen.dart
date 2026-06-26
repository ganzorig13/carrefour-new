import 'package:carrefour/library/library.dart';
import 'package:carrefour/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FinanceScreen extends GetView<FinanceController> {
  const FinanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return IOScaffold(
      appBar: IOAppBar(
        titleText: controller.titleText,
      ),
      body: Obx(
        () => Column(
          children: [
            const SizedBox(height: 24),
            SizedBox(
              height: 36,
              child: Row(
                children: [
                  const SizedBox(width: 16),
                  ...controller.months.map(
                    (e) => Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                        ),
                        child: FinanceButtonWidget(
                          model: e,
                          onTap: () => controller.getOnTapMonth(e),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                ],
              ),
            ),
            Expanded(
              child: controller.isLoading.value
                  ? const IOLoading()
                  : controller.items.isEmpty
                      ? const IOEmptyWidget()
                      : CustomScrollView(
                          slivers: [
                            const SliverToBoxAdapter(
                              child: SizedBox(height: 24),
                            ),
                            SliverToBoxAdapter(
                              child: FinanceChartWidget(
                                amount: controller.totalAmount.value,
                                items: controller.items.toList(),
                              ),
                            ),
                            const SliverToBoxAdapter(
                              child: SizedBox(height: 24),
                            ),
                            SliverList.separated(
                              itemCount: controller.items.length,
                              itemBuilder: (context, index) {
                                final item = controller.items[index];
                                return FinanceDetailWidget(model: item);
                              },
                              separatorBuilder: (context, index) {
                                return const SizedBox(height: 16);
                              },
                            ),
                          ],
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
