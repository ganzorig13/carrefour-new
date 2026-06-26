import 'package:carrefour/library/library.dart';
import 'package:carrefour/screens/menu/gift_employee_cards/gift_cards_detail/gift_cards_detail_controller.dart';
import 'package:carrefour/screens/menu/gift_employee_cards/gift_cards_detail/widgets/cards_detail_item_widget.dart';
import 'package:carrefour/screens/menu/gift_employee_cards/employee_cards/models/gift_cards_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class GiftCardsDetailScreen extends GetView<GiftCardsDetailController> {
  final GiftCardsModel item;
  const GiftCardsDetailScreen({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return IOScaffold(
      appBar: IOAppBar(
        titleText: 'Бэлгийн карт',
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 16),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            'assets/images/big-gift-card.png',
                            fit: BoxFit.cover,
                            width: 360,
                            height: 206,
                          ),
                        ),
                        Positioned(
                          bottom: 16,
                          left: 16,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 4),
                            child: Text(
                              'Gift Card: ',
                              style: IOStyles.h6
                                  .copyWith(color: IOColors.successSecondary),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 16,
                          right: 16,
                          child: Obx(() => Text(
                                controller.giftCartDetail.value?.balance
                                        .toCurrency() ??
                                    '',
                                style: IOStyles.h6
                                    .copyWith(color: IOColors.successSecondary),
                              )),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: IOCardWidget(
                    height: 76,
                    width: 360,
                    borderRadius: BorderRadius.circular(8),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Obx(() => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Үлдэгдэл',
                                    style: IOStyles.body2Regular.copyWith(
                                      color: IOColors.textTertiary,
                                    ),
                                  ),
                                  Text(
                                    controller.giftCartDetail.value?.balance
                                            .toCurrency() ??
                                        '',
                                    style: IOStyles.h6.copyWith(
                                      color: IOColors.textPrimary,
                                    ),
                                  ),
                                ],
                              )),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: IOButtonWidget(
                              model: controller.usingQr,
                              onPressed: () => controller.usingQrButton(
                                  controller.giftCartDetail.value?.code,
                                  controller.giftCartDetail.value?.balance
                                      .toCurrency()),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    'Хийгдсэн гүйлгээнүүд',
                    style: IOStyles.body1Bold.copyWith(
                      color: IOColors.brand700,
                    ),
                  ),
                ),
                Obx(() {
                  final items = controller.giftCartDetail.value?.zarlaga ?? [];
                  return controller.isLoading.value
                      ? const IOLoading()
                      : items.isEmpty
                          ? const IOEmptyWidget()
                          : Padding(
                              padding: const EdgeInsets.only(
                                  top: 12, bottom: 24, left: 24, right: 24),
                              child: ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: items.length,
                                padding: EdgeInsets.zero,
                                itemBuilder: (context, index) {
                                  final item = items[index];
                                  return CardsDetailItemWidget(
                                    amount: item.amount.toCurrency(),
                                    createDate: item.createDate.toString(),
                                  );
                                },
                                separatorBuilder: (_, __) =>
                                    const SizedBox(height: 12),
                              ),
                            );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
