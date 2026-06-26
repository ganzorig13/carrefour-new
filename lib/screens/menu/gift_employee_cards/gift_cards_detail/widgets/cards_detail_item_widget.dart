import 'package:carrefour/library/library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CardsDetailItemWidget extends StatelessWidget {
  final String createDate;
  final String amount;
  const CardsDetailItemWidget({
    super.key,
    required this.createDate,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
        border: Border.all(
          color: 0 == 1 ? IOColors.brand500 : Colors.transparent,
          width: 2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                createDate
                    .toDateWithFormat(format: 'yyyy-MM-dd HH:mm:ss')
                    .toFormattedString(format: 'yyyy/MM/dd HH:mm'),
                style: IOStyles.caption1Medium.copyWith(
                  color: IOColors.brand400,
                ),
              ),
              IOCardWidget(
                backgroundColor: IOColors.secondary500,
                borderRadius: BorderRadius.circular(4),
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Row(
                    children: [
                      SizedBox(width: 4),
                      Text(
                        '$amount ',
                        style: IOStyles.body2Bold.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      SvgPicture.asset(
                        'assets/icons/carrefour_small_logo.svg',
                      ),
                      SizedBox(width: 4),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                amount,
                style: IOStyles.body1Bold.copyWith(
                  color: IOColors.brand500,
                ),
              ),
              SizedBox(width: 8),
              Image.asset(
                'assets/icons/ebarimt.png',
                height: 20,
              ),
              SizedBox(width: 4),
              Text(
                'e-barimt',
                style: IOStyles.body1Bold.copyWith(
                  color: IOColors.brand400,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
