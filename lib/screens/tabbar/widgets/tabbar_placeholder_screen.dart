import 'package:carrefour/library/library.dart';
import 'package:carrefour/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// API нь хараахан гараагүй ecom tab-уудад (Дэлгүүр, Дуртай) түр харуулах дэлгэц.
class TabBarPlaceholderScreen extends StatelessWidget {
  final String icon;
  final String text;

  const TabBarPlaceholderScreen({
    super.key,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TabBarController>();
    return Obx(
      () => IOScaffold(
        appBar: TabBarAppBarWidget(
          count: controller.count.value,
          onTapNotfication: controller.onTapNotfication,
        ),
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: IOEmptyWidget(icon: icon, text: text),
        ),
      ),
    );
  }
}
