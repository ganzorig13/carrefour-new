import 'package:carrefour/library/library.dart';
import 'package:carrefour/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PromoPageScreen extends StatelessWidget {
  final controller = Get.put(PromoPageController());

  /// Тусдаа дэлгэцээр нээх үед (ecom) буцах товчтой appBar дамжуулна.
  /// null бол tab-ын appBar харагдана.
  final PreferredSizeWidget? appBar;
  PromoPageScreen({super.key, this.appBar});

  @override
  Widget build(BuildContext context) {
    // Obx нь зөвхөн мэдэгдлийн тоо (count) уншдаг tab-ын appBar-т хэрэгтэй.
    // appBar дамжуулсан үед (ecom) observable байхгүй тул Obx ашиглавал GetX алдаа заана.
    if (appBar != null) return _buildBody(appBar!);
    return Obx(
      () => _buildBody(
        TabBarAppBarWidget(
          count: controller.count.value,
          onTapNotfication: controller.onTapNotfication,
        ),
      ),
    );
  }

  Widget _buildBody(PreferredSizeWidget appBar) {
    return DefaultTabController(
      length: controller.pages.length,
      child: IOScaffold(
        appBar: appBar,
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
    );
  }
}
