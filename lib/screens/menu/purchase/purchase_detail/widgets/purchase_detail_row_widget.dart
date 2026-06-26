import 'package:carrefour/library/library.dart';
import 'package:flutter/widgets.dart';

class PurchaseDetailRowWidget extends StatelessWidget {
  final String title;
  final String value;

  const PurchaseDetailRowWidget({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: IOStyles.caption1Medium,
        ),
        Text(
          value,
          style: IOStyles.caption1Medium.copyWith(
            color: IOColors.brand500,
          ),
        ),
      ],
    );
  }
}
