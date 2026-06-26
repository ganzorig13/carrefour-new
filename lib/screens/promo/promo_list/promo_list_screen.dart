import 'package:carrefour/library/library.dart';
import 'package:carrefour/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PromoListScreen extends StatelessWidget {
  final PromoPageType type;

  const PromoListScreen({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PromoListController>(
        autoRemove: false,
        tag: type.toString(),
        init: PromoListController(type: type),
        builder: (controller) {
          return Obx(
            () => controller.isInitialLoading.value
                ? const IOLoading()
                : IORefresher(
                    controller: controller.refreshController,
                    enablePullDown: true,
                    onRefresh: controller.onRefresh,
                    child: controller.items.isEmpty
                        ? IOEmptyWidget(
                            icon: 'coupon.svg',
                            text: controller.emptyText,
                          )
                        : ListView.separated(
                            padding: const EdgeInsets.all(24),
                            itemBuilder: (context, index) {
                              final item = controller.items[index];

                              return PromoListItemWidget(
                                userPoint: controller.main.point.value,
                                model: item,
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(height: 16);
                            },
                            itemCount: controller.items.length,
                          ),
                  ),
          );
        });
  }
}
