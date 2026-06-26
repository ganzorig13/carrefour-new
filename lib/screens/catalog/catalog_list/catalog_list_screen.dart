import 'package:carrefour/library/library.dart';
import 'package:carrefour/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CatalogListScreen extends StatelessWidget {
  final controller = Get.put(CatalogListController());
  CatalogListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => IOScaffold(
        appBar: TabBarAppBarWidget(
          count: controller.count.value,
          onTapNotfication: controller.onTapNotfication,
        ),
        body: controller.isInitialLoading.value
            ? const IOLoading()
            : IORefresher(
                controller: controller.refreshController,
                enablePullDown: true,
                onRefresh: controller.onRefresh,
                child: controller.catalogItems.isEmpty
                    ? const IOEmptyWidget(
                        icon: 'catalogy.svg',
                        text: 'Идэвхтэй каталоги\nбайхгүй',
                      )
                    : GridView.count(
                        childAspectRatio: 0.6,
                        crossAxisCount: 2,
                        mainAxisSpacing: 32,
                        crossAxisSpacing: 16,
                        padding: const EdgeInsets.all(24),
                        children: controller.catalogItems
                            .map((e) => CatalogListItemWidget(item: e))
                            .toList(),
                      ),
              ),
      ),
    );
  }
}
