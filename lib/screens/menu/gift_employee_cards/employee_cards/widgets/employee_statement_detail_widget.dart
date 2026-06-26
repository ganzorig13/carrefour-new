import 'package:carrefour/library/library.dart';
import 'package:carrefour/screens/menu/gift_employee_cards/employee_cards/models/gift_card_detail_info_model.dart';
import 'package:flutter/material.dart';

class EmployeeStatementDetailWidget extends StatelessWidget {
  final Zarlaga model;

  const EmployeeStatementDetailWidget({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return IOCardWidget(
      height: 72,
      width: 327,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    model.createDate!
                        .toDateWithFormat(format: 'yyyy-MM-dd HH:mm:ss')
                        .toFormattedString(format: 'yyyy/MM/dd HH:mm'),
                    style: IOStyles.body2Regular.copyWith(
                      color: IOColors.brand700,
                      height: 1.2,
                    ),
                  ),
                  SizedBox(height: 3),
                  Text(
                    model.comment.toString(),
                    style: IOStyles.body2Medium.copyWith(
                      color: IOColors.brand400,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              model.amount.toCurrency(),
              textAlign: TextAlign.right,
              style: IOStyles.body2Bold.copyWith(
                color: IOColors.errorPrimary,
              ),
            ),
            const SizedBox(width: 8),
          ],
        ),
      ),
    );
  }
}

class EmployeeIncomeDetailWidget extends StatelessWidget {
  final Orlogo model;

  const EmployeeIncomeDetailWidget({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return IOCardWidget(
      height: 72,
      width: 327,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    model.date!
                        .toDateWithFormat(format: 'yyyy-MM-dd HH:mm:ss')
                        .toFormattedString(format: 'yyyy/MM/dd HH:mm'),
                    style: IOStyles.body2Regular.copyWith(
                      color: IOColors.brand700,
                      height: 1.2,
                    ),
                  ),
                  SizedBox(height: 3),
                  Text(
                    model.comment.toString(),
                    style: IOStyles.body2Medium.copyWith(
                      color: IOColors.brand400,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              '+${model.amount.toCurrency()}',
              textAlign: TextAlign.right,
              style: IOStyles.body2Bold.copyWith(
                color: IOColors.successPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
