import 'package:carrefour/library/library.dart';
import 'package:carrefour/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PurchaseListItemWidget extends StatelessWidget {
  final PurchaseListModel item;
  final VoidCallback onTap;
  const PurchaseListItemWidget({
    super.key,
    required this.item,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return IOButtonOpacityWidget(
      onTap: onTap,
      child: IOCardWidget(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    item.dateOrder
                        .toDateWithFormat(format: 'yyyy-MM-dd HH:mm:ss')
                        .toFormattedString(format: 'yyyy/MM/dd HH:mm'),
                    style: IOStyles.caption1Medium.copyWith(
                      color: IOColors.brand400,
                    ),
                  ),
                  if (item.loyaltyValue != 0)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: IOColors.secondary500,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        children: [
                          Text(
                            item.loyaltySign +
                                item.loyaltyValue.toCurrency(hasSymbol: false),
                            style: IOStyles.caption2Bold.copyWith(
                              color: IOColors.backgroundPrimary,
                            ),
                          ),
                          const SizedBox(width: 4),
                          SizedBox(
                            width: 12,
                            height: 10,
                            child: SvgPicture.asset(
                              'assets/icons/logo.svg',
                              colorFilter: const ColorFilter.mode(
                                IOColors.backgroundPrimary,
                                BlendMode.srcIn,
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                ],
              ),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    item.totalAmount.toCurrency(),
                    style: IOStyles.body1Bold.copyWith(
                      color: IOColors.brand500,
                    ),
                  ),
                  const SizedBox(width: 4),
                  SizedBox.square(
                    dimension: 24,
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Image.asset(
                        'assets/icons/ebarimt.png',
                      ),
                    ),
                  ),
                  Text(
                    'e-barimt',
                    style: IOStyles.caption1Bold.copyWith(
                      color: IOColors.brand400,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
