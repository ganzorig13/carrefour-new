import 'package:carrefour/library/library.dart';
import 'package:carrefour/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class RatingPointSheet extends StatelessWidget {
  final int id;
  const RatingPointSheet({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RatingPointController>(
      init: RatingPointController(id: id),
      builder: (controller) {
        return Container(
          decoration: const BoxDecoration(
            color: IOColors.backgroundPrimary,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(16),
            ),
          ),
          child: SafeArea(
            child: Obx(
              () => controller.isInitialLoading.value
                  ? const SizedBox(
                      height: 200,
                      child: IOLoading(),
                    )
                  : AbsorbPointer(
                      absorbing: controller.isLoading.value,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 48,
                            child: Stack(
                              children: [
                                Positioned(
                                  top: 16,
                                  left: 0,
                                  right: 0,
                                  child: Align(
                                    alignment: Alignment.topCenter,
                                    child: Container(
                                      width: 40,
                                      height: 4,
                                      decoration: BoxDecoration(
                                        color: IOColors.textQuarternary,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: IconButton(
                                    onPressed: Get.back,
                                    icon: SvgPicture.asset(
                                      'assets/icons/close.svg',
                                      colorFilter: const ColorFilter.mode(
                                        IOColors.brand500,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: Text(
                              controller.rate.value.title,
                              textAlign: TextAlign.center,
                              style: IOStyles.body1Bold.copyWith(
                                color: IOColors.brand700,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: Text(
                              controller.rate.value.description,
                              textAlign: TextAlign.center,
                              style: IOStyles.body2Regular.copyWith(
                                color: IOColors.brand700,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: controller.rateItems
                                  .map((e) => TextButton(
                                        onPressed: () =>
                                            controller.onTapPoint(e),
                                        style: TextButton.styleFrom(
                                          foregroundColor: IOColors.brand500,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 12,
                                            vertical: 12,
                                          ),
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            SizedBox.square(
                                              dimension: 40,
                                              child: SvgPicture.asset(
                                                'assets/icons/${e.icon}',
                                              ),
                                            ),
                                            const SizedBox(height: 16),
                                            Text(
                                              e.name,
                                              style: IOStyles.caption2Bold,
                                            ),
                                          ],
                                        ),
                                      ))
                                  .toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
          ),
        );
      },
    );
  }
}
