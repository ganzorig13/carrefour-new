import 'package:carrefour/library/library.dart';
import 'package:carrefour/screens/menu/gift_employee_cards/gift_cards/gift_cards_controller.dart';
import 'package:carrefour/screens/menu/gift_employee_cards/gift_cards/widgets/gift_cards_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

class GiftCardsScreen extends GetView<GiftCardsController> {
  const GiftCardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return IOScaffold(
      bottomNavigationBar: SafeArea(
        child: IOBottomNavigationBar(
          child: IOButtonWidget(
            model: controller.giftCartAdd,
            onPressed: controller.onTapGiftCardAdd,
          ),
        ),
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            SizedBox(
              height: 80,
              width: 380,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: IOTabBar(
                  tabs: [
                    'Идэвхтэй',
                    'Ашиглагдсан',
                  ],
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _buildGiftCardList(
                      isActive: true,
                      padding: const EdgeInsets.symmetric(horizontal: 10)),
                  _buildGiftCardList(
                      isActive: false,
                      padding: const EdgeInsets.symmetric(horizontal: 24)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGiftCardList({
    required bool isActive,
    required EdgeInsets padding,
  }) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const IOLoading();
      }

      final cards = isActive
          ? controller.controller.giftCards
          : controller.controller.usedCards;

      if (cards.isEmpty) {
        return const IOEmptyWidget(
          text: 'Бэлгийн карт байхгүй байна.',
        );
      }

      return ListView.separated(
        padding: padding,
        itemCount: cards.length,
        itemBuilder: (context, index) {
          final card = cards[index];
          return GiftCardsItemWidget(
            amount: card.balance.toCurrency(),
            item: card,
            onTapDetailScreen: () => controller.onTapDetailScreen(card),
          );
        },
        separatorBuilder: (_, __) => const SizedBox(height: 12),
      );
    });
  }
}
