import 'package:carrefour/library/components/main/io_gesture.dart';
import 'package:carrefour/library/library.dart';
import 'package:carrefour/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class HomeGiftCardsWidget extends StatelessWidget {
  final VoidCallback? onTapMore;
  final IOButtonModel usingQr;
  final VoidCallback? usingQrButton;
  final List<GiftCardsModel> giftCards;

  const HomeGiftCardsWidget({
    super.key,
    required this.onTapMore,
    required this.usingQr,
    required this.usingQrButton,
    required this.giftCards,
  });

  @override
  Widget build(BuildContext context) {
    final items = giftCards;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Картнууд',
                style: IOStyles.body1Bold.copyWith(
                  color: IOColors.brand700,
                ),
              ),
              IconButton(
                onPressed: onTapMore,
                padding: const EdgeInsets.only(left: 24),
                icon: SvgPicture.asset(
                  'assets/icons/arrow.right.myicon.svg',
                  width: 24,
                  height: 24,
                  colorFilter: const ColorFilter.mode(
                    IOColors.brand700,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 88,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            padding: EdgeInsets.only(right: 24, left: 24),
            itemBuilder: (context, index) {
              final item = items[index];
              return IOGesture(
                onTap: () {
                  if (item.isEmployeeCard == true) {
                    MenuRoute.toEmployeeCardPage();
                  } else {
                    MenuRoute.toCardDetailScreen(item: item);
                  }
                },
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        item.isEmployeeCard
                            ? 'assets/images/small-gift-card.png'
                            : 'assets/images/small-employee-gift-card.png',
                        fit: BoxFit.cover,
                        width: 311,
                        height: 88,
                      ),
                    ),
                    Positioned(
                      top: 14,
                      left: 14,
                      child: Text(
                        item.isEmployeeCard ? 'Ажилтны карт' : '',
                        style: IOStyles.body2Medium.copyWith(
                          color: IOColors.warningSecondary,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 8,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 4),
                        child: Row(
                          children: [
                            Text(
                              item.isEmployeeCard
                                  ? 'Үлдэгдэл: '
                                  : 'Gift Card: ',
                              style: IOStyles.body2Regular
                                  .copyWith(color: IOColors.successSecondary),
                            ),
                            Text(
                              item.balance.toCurrency(),
                              style: IOStyles.body1Bold
                                  .copyWith(color: IOColors.successSecondary),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 12,
                      right: 12,
                      child: IOButtonWidget(
                        model: usingQr,
                        onPressed: () {
                          Get.find<HomeController>().qrCode.value = item.code;
                          Get.find<HomeController>().balance.value =
                              item.balance.toCurrency();

                          if (item.isEmployeeCard == true) {
                            Get.find<HomeController>().isEmployee.value = true;
                          } else {
                            Get.find<HomeController>().isEmployee.value = false;
                          }
                          usingQrButton?.call();
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
