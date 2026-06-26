import 'package:carrefour/library/library.dart';
import 'package:carrefour/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WalkthroughScreen extends GetView<WalkthroughController> {
  static const routeName = '/WalkthroughScreen';
  const WalkthroughScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return IOScaffold(
      backgroundColor: IOColors.backgroundSecondary,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: IOButtonWidget(
              model: controller.skipButton,
              onPressed: controller.onLogin,
            ),
          ),
        ],
      ),
      body: Obx(
        () => Stack(
          children: [
            Positioned.fill(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return FadeTransition(opacity: animation, child: child);
                },
                child: Image.asset(
                  key: UniqueKey(),
                  controller.image,
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.topCenter,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                decoration: const BoxDecoration(
                  color: IOColors.backgroundSecondary,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                ),
                child: SafeArea(
                  top: false,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 36, bottom: 16),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 130,
                          child: PageView(
                            physics: const NeverScrollableScrollPhysics(),
                            controller: controller.pageTextController,
                            children: controller.items
                                .map(
                                  (e) => WalkthroughPageWidget(
                                    model: e,
                                    direction: controller.direction,
                                    onNext: controller.onNextPage,
                                    onBack: controller.onBackPage,
                                    onLogin: controller.onLogin,
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                          ),
                          child: Row(
                            children: [
                              IOPageIndicator(
                                controller: controller.pageTextController,
                                count: controller.items.length,
                              ),
                              const Spacer(),
                              if (controller.currentIndex.value != 0)
                                IOButtonWidget(
                                  model: controller.previousButton,
                                  onPressed: controller.onBackPage,
                                ),
                              const SizedBox(width: 16),
                              IOButtonWidget(
                                model: controller.nextButton,
                                onPressed: controller.onNextPage,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
