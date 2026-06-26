import 'package:carrefour/library/components/main/io_gesture.dart';
import 'package:carrefour/library/theme/io_colors.dart';
import 'package:carrefour/library/theme/io_styles.dart';
import 'package:carrefour/screens/menu/gift_employee_cards/employee_cards/models/gift_cards_model.dart';
import 'package:flutter/widgets.dart';

class GiftCardsItemWidget extends StatelessWidget {
  final GiftCardsModel item;
  final String amount;
  final VoidCallback onTapDetailScreen;

  const GiftCardsItemWidget({
    super.key,
    required this.item,
    required this.amount,
    required this.onTapDetailScreen,
  });

  @override
  Widget build(BuildContext context) {
    return IOGesture(
      onTap: onTapDetailScreen,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  'assets/images/big-gift-card.png',
                  fit: BoxFit.cover,
                  width: 350,
                  height: 206,
                ),
              ),
              Positioned(
                bottom: 16,
                left: 16,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                  child: Text(
                    'Gift Card: ',
                    style:
                        IOStyles.h6.copyWith(color: IOColors.successSecondary),
                  ),
                ),
              ),
              Positioned(
                bottom: 16,
                right: 16,
                child: Text(
                  amount,
                  style: IOStyles.h6.copyWith(color: IOColors.successSecondary),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
