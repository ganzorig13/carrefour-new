import 'package:carrefour/library/library.dart';
import 'package:carrefour/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PointPageScreen extends GetView<PointPageController> {
  const PointPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return IOScaffold(
      appBar: IOAppBar(
        titleText: controller.titleText,
      ),
      body: const DefaultTabController(
        length: 2,
        child: Column(
          children: [
            SizedBox(
              height: 76,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                child: IOTabBar(
                  tabs: [
                    'Нэмэгдсэн',
                    'Зарцуулсан',
                  ],
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  PointListScreen(type: PointListType.collect),
                  PointListScreen(type: PointListType.spend),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
