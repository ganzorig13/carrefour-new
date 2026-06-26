import 'package:carrefour/library/library.dart';
import 'package:carrefour/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PurchaseListScreen extends GetView<PurchaseListController> {
  const PurchaseListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return IOScaffold(
      appBar: IOAppBar(
        titleText: controller.titleText,
      ),
      body: Obx(
        () => controller.isInitialLoading.value
            ? const IOLoading()
            : IORefresher(
                controller: controller.refreshController,
                onLoading: controller.onLoad,
                onRefresh: controller.onRefresh,
                enablePullDown: true,
                enablePullUp: true,
                child: controller.historyItems.isEmpty
                    ? IOEmptyWidget(
                        icon: 'recipe.svg',
                        text: controller.emptyText,
                      )
                    : ListView.separated(
                        padding: const EdgeInsets.all(24),
                        itemBuilder: (context, index) {
                          final item = controller.historyItems[index];
                          return PurchaseListItemWidget(
                            item: item,
                            onTap: () => controller.onTapItem(item),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(height: 16);
                        },
                        itemCount: controller.historyItems.length,
                      ),
              ),
      ),
    );
  }
}
