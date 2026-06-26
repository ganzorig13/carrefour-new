import 'package:carrefour/library/components/main/io_custom_tabbar.dart';
import 'package:carrefour/library/library.dart';
import 'package:carrefour/screens/menu/gift_employee_cards/cards_tab/cards_tab_controller.dart';
import 'package:carrefour/screens/menu/gift_employee_cards/employee_cards/employee_cards_screen.dart';
import 'package:carrefour/screens/menu/gift_employee_cards/gift_cards/gift_cards_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardsTabScreen extends GetView<CardsTabController> {
  final int initialIndex;
  const CardsTabScreen({super.key, this.initialIndex = 0});

  @override
  Widget build(BuildContext context) {
    return IOScaffold(
      appBar: IOAppBar(
        titleText: controller.titleText,
      ),
      body: Obx(() {
        if (controller.isInitialLoading.value) return const IOLoading();

        final tabs = <String>[
          if (controller.employeeCard != null) 'Ажилтны карт',
          'Бэлгийн карт',
        ];

        final tabViews = <Widget>[
          if (controller.employeeCard != null)
            EmployeeCardsScreen(card: controller.employeeCard),
          GiftCardsScreen(),
        ];

        return DefaultTabController(
          length: tabs.length,
          initialIndex: initialIndex.clamp(0, tabs.length - 1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 76,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: IOCustomTabbar(tabs: tabs),
                ),
              ),
              Expanded(
                child: TabBarView(children: tabViews),
              ),
            ],
          ),
        );
      }),
    );
  }
}
