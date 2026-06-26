import 'package:carrefour/library/library.dart';
import 'package:carrefour/screens/screens.dart';
import 'package:flutter/material.dart';

class FinanceDetailWidget extends StatelessWidget {
  final FinanceDetailModel model;

  const FinanceDetailWidget({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
              ),
              child: IOImageNetworkWidget(
                imageUrl: model.iconUrl,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                model.categoryName,
                style: IOStyles.body2Regular.copyWith(
                  color: IOColors.brand700,
                ),
              ),
            ),
            Text(
              model.totalAmount.toCurrency(),
              textAlign: TextAlign.right,
              style: IOStyles.body2Bold.copyWith(
                color: IOColors.brand700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
