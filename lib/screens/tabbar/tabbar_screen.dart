import 'package:carrefour/library/library.dart';
import 'package:carrefour/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class TabBarScreen extends GetView<TabBarController> {
  static const routeName = '/TabBarScreen';
  const TabBarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => IOScaffold(
        body: IndexedStack(
          index: controller.tabIndex.value,
          children: controller.tabItems.map((e) => e.screen).toList(),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          elevation: 0,
          highlightElevation: 0,
          backgroundColor: IOColors.brand600,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(56),
          ),
          onPressed: controller.onTapQr,
          child: SvgPicture.asset(
            'assets/icons/qr.svg',
            width: 24,
            height: 24,
            colorFilter: const ColorFilter.mode(
              IOColors.backgroundPrimary,
              BlendMode.srcIn,
            ),
          ),
        ),
        bottomNavigationBar: TabBarWidget(
          items: controller.tabItems,
          currentIndex: controller.tabIndex.value,
          onChanged: controller.onTabChanged,
        ),
      ),
    );
  }
}
