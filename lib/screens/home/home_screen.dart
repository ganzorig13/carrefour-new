import 'package:carrefour/library/library.dart';
import 'package:carrefour/screens/home/widgets/home_gift_cards_widget.dart';
import 'package:carrefour/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  final controller = Get.put(HomeController());
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return IOScaffold(
      body: Obx(
        () => IORefresher(
          controller: controller.refreshController,
          enablePullDown: true,
          onRefresh: controller.getData,
          child: CustomScrollView(
            slivers: [
              HomeAppBarWidget(
                point: HomePointWidget(
                  qrString: controller.user.value.barcode,
                  point: controller.main.point.value,
                  onTapQr: controller.onTapQrImage,
                  onTapScan: controller.onTapQrScan,
                ),
                count: controller.count.value,
                onTapNotfication: controller.onTapNotfication,
              ),
              controller.giftCards.filteredCards.isNotEmpty
                  ? SliverToBoxAdapter(
                      child: HomeGiftCardsWidget(
                        onTapMore: controller.onTapMore,
                        usingQr: controller.usingQr,
                        usingQrButton: controller.onTapUsingQr,
                        giftCards: controller.giftCards.filteredCards,
                      ),
                    )
                  : SliverToBoxAdapter(child: SizedBox.shrink()),
              const SliverToBoxAdapter(
                child: SizedBox(height: 24),
              ),
              if (controller.bannerItems.isNotEmpty) ...[
                HomeBannerWidget(
                  items: controller.bannerItems.toList(),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(height: 16),
                ),
              ],
              if (controller.promoItems.isNotEmpty) ...[
                PromoListSectionWidget(
                  headerText: 'Онцгой санал',
                  padding: const EdgeInsets.only(
                    left: 24,
                  ),
                  userPoint: controller.main.point.value,
                  onTapMore: controller.onTapPromoMore,
                  items: controller.promoItems.toList(),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(height: 16),
                ),
              ],
              if (controller.promoBannerItems.isNotEmpty) ...[
                HomePromoBannerWidget(
                  items: controller.promoBannerItems,
                  onTap: controller.onTapPromoBanner,
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(height: 16),
                ),
              ],
              if (controller.catalogItems.isNotEmpty) ...[
                HomeCatalogyWidget(
                  headerText: 'Хямдралын каталог',
                  padding: const EdgeInsets.only(
                    left: 24,
                  ),
                  onTapMore: controller.onTapCatalogyMore,
                  items: controller.catalogItems.toList(),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(height: 16),
                ),
              ],
              const SliverToBoxAdapter(
                child: SizedBox(height: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
