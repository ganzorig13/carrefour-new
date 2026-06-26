import 'package:carrefour/library/library.dart';
import 'package:carrefour/screens/rating/rating.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class RatingQuestionSheet extends StatelessWidget {
  final int id;
  final int point;
  final RatingModel rateInfo;

  const RatingQuestionSheet({
    super.key,
    required this.id,
    required this.point,
    required this.rateInfo,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RatingQuestionController>(
      init: RatingQuestionController(
        id: id,
        point: point,
        rateInfo: rateInfo,
      ),
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
              () => AbsorbPointer(
                absorbing: controller.isLoading.value,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
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
                        controller.rateInfo.question,
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
                        controller.rateInfo.description,
                        textAlign: TextAlign.center,
                        style: IOStyles.body2Regular.copyWith(
                          color: IOColors.brand700,
                        ),
                      ),
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsetsDirectional.symmetric(
                        vertical: 12,
                        horizontal: 24,
                      ),
                      itemBuilder: (context, index) {
                        final item = controller.rateInfo.answerchoices[index];
                        final selected =
                            controller.selectedIndex.value == index;
                        return Center(
                          child: FilledButton(
                            onPressed: () => controller.onSelected(index),
                            style: FilledButton.styleFrom(
                              backgroundColor: selected
                                  ? IOColors.secondary500
                                  : IOColors.brand50,
                            ),
                            child: Text(
                              item.answer,
                              style: IOStyles.caption1Bold.copyWith(
                                color: selected
                                    ? IOColors.backgroundPrimary
                                    : IOColors.brand500,
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 12);
                      },
                      itemCount: controller.rateInfo.answerchoices.length,
                    ),
                    Center(
                      child: FilledButton(
                        onPressed: () => controller.onSelected(
                            controller.rateInfo.answerchoices.length),
                        style: FilledButton.styleFrom(
                          backgroundColor: controller.isOther
                              ? IOColors.secondary500
                              : IOColors.brand50,
                        ),
                        child: Text(
                          'Бусад',
                          style: IOStyles.caption1Bold.copyWith(
                            color: controller.isOther
                                ? IOColors.backgroundPrimary
                                : IOColors.brand500,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Divider(
                      height: 1,
                      thickness: 1,
                      color: IOColors.strokePrimary,
                    ),
                    AnimatedSize(
                      duration: const Duration(milliseconds: 300),
                      child: SizedBox(
                        height: controller.isOther ? 16 : 0,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                      ),
                      child: AnimatedSize(
                        duration: const Duration(milliseconds: 300),
                        child: SizedBox(
                          height: controller.isOther ? null : 0,
                          child: controller.isOther
                              ? IOTextfieldWidget(
                                  model: controller.otherField,
                                )
                              : null,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 16,
                      ),
                      child: IOButtonWidget(
                        model: controller.sendButton.value,
                        onPressed: controller.onTapSend,
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
