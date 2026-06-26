import 'package:carrefour/library/library.dart';
import 'package:carrefour/screens/screens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class PromoDetailScreen extends GetView<PromoDetailController> {
  const PromoDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => IOScaffold(
        appBar: IOAppBar(
          titleText: 'Урамшуулал',
        ),
        body: controller.isInitialLoading.value
            ? const IOLoading()
            : AbsorbPointer(
                absorbing: controller.isLoading.value,
                child: CustomScrollView(
                  slivers: [
                    SliverPadding(
                      padding: const EdgeInsets.only(
                          left: 24, right: 24, top: 24, bottom: 16),
                      sliver: SliverToBoxAdapter(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 160,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: IOColors.backgroundImage,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: IOImageNetworkWidget(
                                  imageUrl: controller.promo.value.photo,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: IOColors.secondary500,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    controller.promo.value.tag,
                                    style: IOStyles.caption1Bold.copyWith(
                                      color: IOColors.backgroundPrimary,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  SizedBox(
                                    height: 10,
                                    width: 12,
                                    child: SvgPicture.asset(
                                      'assets/icons/${controller.promo.value.isPointReward ? 'logo.svg' : 'box.gift.svg'}',
                                      colorFilter: const ColorFilter.mode(
                                        IOColors.backgroundPrimary,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              // child: Text(
                              //   controller.promo.value.tag,
                              //   style: IOStyles.caption1Bold.copyWith(
                              //     color: IOColors.backgroundPrimary,
                              //   ),
                              // ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              controller.promo.value.name,
                              style: IOStyles.body2Bold.copyWith(
                                color: IOColors.brand700,
                              ),
                            ),
                            const SizedBox(height: 16),
                            switch (controller.promo.value.progressType) {
                              PromoType.step => PromoStepWidget(
                                  totalCount: controller.promo.value.stepMax,
                                  currentCount:
                                      controller.promo.value.stepCurrent,
                                ),
                              PromoType.progress => PromoProgressWidget(
                                  totalAmount:
                                      controller.promo.value.purchaseAmount,
                                  currentAmount:
                                      controller.promo.value.purchaseCurrent,
                                ),
                              PromoType.point => PromoPointWidget(
                                  totalPoint:
                                      controller.promo.value.pointAmount,
                                  currentPoint: controller.main.point.value,
                                ),
                              PromoType.survey => const SizedBox.shrink(),
                              PromoType.none => const SizedBox.shrink(),
                            },
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/calendar.svg',
                                  width: 16,
                                  height: 16,
                                  colorFilter: const ColorFilter.mode(
                                    IOColors.brand400,
                                    BlendMode.srcIn,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  controller.promo.value.endValue,
                                  style: IOStyles.caption1Medium.copyWith(
                                    color: IOColors.brand400,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (controller.hasPointButton)
                      SliverPadding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 24,
                        ),
                        sliver: SliverToBoxAdapter(
                          child: IOButtonWidget(
                            model: controller.pointButton.value,
                            onPressed: controller.onTapSetComplete,
                          ),
                        ),
                      ),
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 24,
                      ),
                      sliver: SliverToBoxAdapter(
                        child: Text(
                          'Бэлэг',
                          style: IOStyles.body1Bold.copyWith(
                            color: IOColors.brand700,
                          ),
                        ),
                      ),
                    ),
                    SliverList.separated(
                      itemCount: controller.rewards.length,
                      itemBuilder: (context, index) {
                        final item = controller.rewards[index];
                        return PromoRewardWidget(
                          model: item,
                          endDate: controller.promo.value.endValue,
                          onTap: () => controller.onTapReward(item),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 16);
                      },
                    ),
                    if (controller.mission.isNotEmpty) ...[
                      const SliverToBoxAdapter(
                        child: SizedBox(height: 16),
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 24,
                        ),
                        sliver: SliverToBoxAdapter(
                          child: Text(
                            'Авах бүтээгдэхүүн',
                            style: IOStyles.body1Bold.copyWith(
                              color: IOColors.brand700,
                            ),
                          ),
                        ),
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        sliver: SliverGrid.count(
                          mainAxisSpacing: 24,
                          crossAxisSpacing: 16,
                          crossAxisCount: 2,
                          childAspectRatio: 0.8,
                          children: controller.mission
                              .map(
                                (e) => PromoMissionWidget(
                                  model: e,
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ],
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: Get.mediaQuery.padding.bottom,
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
