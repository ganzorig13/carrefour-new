import 'package:carrefour/library/library.dart';
import 'package:carrefour/screens/screens.dart';
import 'package:flutter/material.dart';

class FinanceButtonWidget extends StatelessWidget {
  final FinanceButtonModel model;
  final VoidCallback onTap;
  const FinanceButtonWidget({
    super.key,
    required this.model,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onTap,
      style: FilledButton.styleFrom(
        backgroundColor: model.selected ? IOColors.brand500 : IOColors.brand50,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        model.title,
        style: IOStyles.body2Medium.copyWith(
          color:
              model.selected ? IOColors.backgroundPrimary : IOColors.brand500,
        ),
      ),
    );
  }
}
