import 'package:carrefour/library/library.dart';
import 'package:carrefour/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class SignInMainScreen extends GetView<SignInMainController> {
  static const routeName = '/SignInMainScreen';

  const SignInMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => IOScaffold(
        appBar: AppBar(
          backgroundColor: IOColors.brand500,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(110),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 35,
                horizontal: 60,
              ),
              child: SvgPicture.asset(
                'assets/icons/logo.horizontal.svg',
              ),
            ),
          ),
        ),
        body: SizedBox.expand(
          child: AbsorbPointer(
            absorbing: controller.isLoading.value,
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: Get.focusScope?.unfocus,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 32,
                ),
                child: Column(
                  children: [
                    IOTextfieldWidget(model: controller.phoneField),
                  ],
                ),
              ),
            ),
          ),
        ),
        bottomSheet: Container(
          color: IOColors.backgroundSecondary,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 16,
            ),
            child: IOButtonWidget(
              model: controller.signInButton.value,
              onPressed: controller.onTapSignIn,
            ),
          ),
        ),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 24, right: 24, bottom: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                IOButtonWidget(
                  model: controller.signUpButton,
                  onPressed: controller.onTapSignUp,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
