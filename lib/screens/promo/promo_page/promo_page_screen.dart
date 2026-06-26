import 'package:carrefour/library/library.dart';
import 'package:carrefour/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PromoPageScreen extends StatelessWidget {
  final controller = Get.put(PromoPageController());
  PromoPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => DefaultTabController(
        length: controller.pages.length,
        child: IOScaffold(
          appBar: TabBarAppBarWidget(
            count: controller.count.value,
            onTapNotfication: controller.onTapNotfication,
          ),
          body: Column(
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 76,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  child: IOTabBar(
                    scrollable: true,
                    tabs: controller.pages.map((e) => e.title).toList(),
                  ),
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: controller.pages
                      .map((e) => PromoListScreen(type: e))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
