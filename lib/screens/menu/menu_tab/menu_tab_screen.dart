import 'package:carrefour/library/library.dart';
import 'package:carrefour/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuTabScreen extends StatelessWidget {
  final controller = Get.put(MenuTabController());
  MenuTabScreen({super.key});

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
            : SingleChildScrollView(
                padding: const EdgeInsets.only(
                  left: 24,
                  right: 24,
                  top: 24,
                  bottom: 24 + 36,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    MenuProfileWidget(
                      user: controller.user.value,
                      onTap: controller.onTapProfile,
                    ),
                    const SizedBox(height: 16),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        final model = controller.items[index];
                        return MenuTabWidget(
                          model: model,
                          onTap: controller.onTapItem,
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 16);
                      },
                      itemCount: controller.items.length,
                    ),
                    const SizedBox(height: 16),
                    IOButtonWidget(
                      model: controller.logoutButton,
                      onPressed: controller.onTapLogout,
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
