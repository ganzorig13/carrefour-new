import 'package:carrefour/library/library.dart';
import 'package:carrefour/screens/menu/gift_employee_cards/employee_cards/models/employee_completed_transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class EmployeeCompletedTransactionButton extends StatelessWidget {
  final EmployeeCardTransactionModel model;
  final VoidCallback onTap;
  const EmployeeCompletedTransactionButton({
    super.key,
    required this.model,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => FilledButton(
        onPressed: onTap,
        style: FilledButton.styleFrom(
          backgroundColor:
              model.selected.value ? IOColors.brand500 : IOColors.brand50,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          model.title,
          style: IOStyles.body2Medium.copyWith(
            color: model.selected.value
                ? IOColors.backgroundPrimary
                : IOColors.brand500,
          ),
        ),
      ),
    );
  }
}
