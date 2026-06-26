import 'package:carrefour/library/library.dart';
import 'package:carrefour/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return IOScaffold(
      body: Obx(
        () => CustomScrollView(
          slivers: [
            ProfileAppbarWidget(
              imageUrl: controller.user.value.avatar.isEmpty
                  ? ''
                  : controller.user.value.photoUrl,
              onTap: controller.onTapPhoto,
            ),
            ProfileMainWidget(
              user: controller.user.value,
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 16),
            ),
            ProfilePhoneWidget(
              phone: controller.user.value.phone,
              onEdit: controller.onChangePhone,
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 16),
            ),
            ProfileAdditionalWidget(
              user: controller.user.value,
              onEdit: controller.onTapEdit,
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 16),
            ),

            /// delete account
            if (HelperManager.user.phone == '87654321') ...[
              profileDeleteWidget(),
              const SliverToBoxAdapter(
                child: SizedBox(height: 16),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(height: 16),
              ),
            ]
          ],
        ),
      ),
    );
  }

  profileDeleteWidget() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: IOButtonWidget(
          model: controller.deleteAccountButton,
          onPressed: controller.onDeleteAccount,
        ),
      ),
    );
  }
}
