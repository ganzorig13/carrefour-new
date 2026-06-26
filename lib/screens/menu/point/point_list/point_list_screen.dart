import 'package:carrefour/library/library.dart';
import 'package:carrefour/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PointListScreen extends GetView<PointListController> {
  final PointListType type;
  const PointListScreen({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      autoRemove: false,
      tag: type.toString(),
      init: PointListController(type: type),
      builder: (controller) {
        return Obx(
          () => controller.isInitialLoading.value
              ? const IOLoading()
              : IORefresher(
                  controller: controller.refreshController,
                  onLoading: controller.onLoad,
                  onRefresh: controller.onRefresh,
                  enablePullDown: true,
                  enablePullUp: true,
                  child: controller.pointItems.isEmpty
                      ? IOEmptyWidget(
                          icon: 'coin.svg',
                          text: controller.emptyText,
                        )
                      : ListView.separated(
                          padding: const EdgeInsets.only(
                            left: 24,
                            right: 24,
                            top: 8,
                            bottom: 24,
                          ),
                          itemBuilder: (context, index) {
                            final item = controller.pointItems[index];
                            return PointListItemWidget(item: item);
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(height: 16);
                          },
                          itemCount: controller.pointItems.length,
                        ),
                ),
        );
      },
    );
  }
}
