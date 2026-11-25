import 'package:carrefour/library/library.dart';
import 'package:flutter/material.dart';

/// Replace the empty state with order cards when the orders API is available.
class ActiveOrdersWidget extends StatelessWidget {
  const ActiveOrdersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Text(
            'Идэвхтэй захиалга',
            style: IOStyles.body1Bold.copyWith(color: IOColors.brand700),
          ),
        ),
        IOCardWidget(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              const Icon(Icons.shopping_bag_outlined,
                  color: IOColors.brand600, size: 24),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Идэвхтэй захиалга байхгүй',
                  style: IOStyles.body2Medium.copyWith(
                    color: IOColors.brand600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
