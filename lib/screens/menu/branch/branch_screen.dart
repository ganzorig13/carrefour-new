import 'package:carrefour/library/library.dart';
import 'package:carrefour/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BranchScreen extends GetView<BranchController> {
  const BranchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => IOScaffold(
        appBar: IOAppBar(
          titleText: controller.titleText,
        ),
        body: controller.isInitialLoading.value
            ? const IOLoading()
            : DefaultTabController(
                length: 2,
                child: Stack(
                  children: [
                    TabBarView(
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        BranchMapWidget(
                          markers: controller.markers.toSet(),
                          onMapCreated: controller.onMapCreated,
                        ),
                        BranchListWidget(
                          branches: controller.branchItems.toList(),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 76,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 16,
                        ),
                        child: IOTabBar(
                          tabs: ['Газрын зураг', 'Жагсаалт'],
                        ),
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
