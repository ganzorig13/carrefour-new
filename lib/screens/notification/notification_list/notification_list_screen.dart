import 'package:carrefour/library/library.dart';
import 'package:carrefour/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationListScreen extends GetView<NotificationListController> {
  const NotificationListScreen({super.key});

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
                enablePullDown: true,
                onRefresh: controller.onRefresh,
                child: controller.notificationItems.isEmpty
                    ? const IOEmptyWidget(
                        icon: 'notification.svg',
                        text: 'Танд мэдэгдэл ирээгүй байна',
                      )
                    : ListView(
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                        ),
                        children: controller.notificationItems
                            .map((e) => NotificatoinListItemWidget(
                                  item: e,
                                  onTap: () => controller.onTapItem(e),
                                ))
                            .toList(),
                      ),
              ),
      ),
    );
  }
}
